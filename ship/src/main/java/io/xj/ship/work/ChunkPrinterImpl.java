// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.ship.work;

import com.google.api.client.util.Lists;
import com.google.common.collect.ImmutableList;
import com.google.inject.Inject;
import com.google.inject.assistedinject.Assisted;
import io.xj.lib.app.Environment;
import io.xj.lib.filestore.FileStoreProvider;
import io.xj.lib.mixer.AudioStreamWriter;
import io.xj.lib.mixer.OutputEncoder;
import io.xj.lib.util.CSV;
import io.xj.lib.util.Text;
import io.xj.lib.util.Values;
import io.xj.nexus.persistence.Segments;
import io.xj.ship.ShipException;
import io.xj.ship.broadcast.Chunk;
import io.xj.ship.broadcast.ChunkManager;
import io.xj.ship.broadcast.ChunkState;
import io.xj.ship.source.SegmentAudio;
import io.xj.ship.source.SegmentAudioManager;
import io.xj.ship.source.SegmentAudioState;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.sound.sampled.AudioFormat;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.nio.file.Files;
import java.nio.file.Path;
import java.time.Instant;
import java.util.Collection;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

import static io.xj.lib.util.Files.getFileSize;

/**
 * Ship broadcast via HTTP Live Streaming #179453189
 */
public class ChunkPrinterImpl implements ChunkPrinter {
  private static final Logger LOG = LoggerFactory.getLogger(ChunkPrinterImpl.class);
  private static final int AUDIO_CHANNELS = 2;
  private static final float QUALITY = 100;
  private final Chunk chunk;
  private final ChunkManager chunkManager;
  private final FileStoreProvider fileStoreProvider;
  private final SegmentAudioManager segmentAudioManager;
  private final String m4sFileName;
  private final String m4sFilePath;
  private final String m4sFilePathTemplate;
  private final String mp4InitFileName;
  private final String mp4InitFilePath;
  private final String streamBucket;
  private final String tempPlaylistFilePath;
  private final String threadName;
  private final String wavFilePath;
  private final int bitrate;
  private final int shipChunkPrintTimeoutSeconds;
  private final int shipChunkSeconds;

  // PCM data
  private double[][] output;

  @Inject
  public ChunkPrinterImpl(
    @Assisted("chunk") Chunk chunk,
    ChunkManager chunkManager,
    Environment env,
    FileStoreProvider fileStoreProvider,
    SegmentAudioManager segmentAudioManager
  ) {
    this.chunk = chunk;
    this.chunkManager = chunkManager;
    this.fileStoreProvider = fileStoreProvider;
    this.segmentAudioManager = segmentAudioManager;

    bitrate = env.getShipBitrateHigh();
    mp4InitFileName = String.format("%s-%s-IS.mp4", chunk.getShipKey(), Values.kbps(bitrate));
    mp4InitFilePath = String.format("%s%s", env.getTempFilePathPrefix(), mp4InitFileName);

    String key = chunk.getKey(bitrate);
    m4sFileName = String.format("%s.m4s", key);
    m4sFilePath = String.format("%s%s", env.getTempFilePathPrefix(), m4sFileName);
    m4sFilePathTemplate = String.format("%s%s-%s-%%d.m4s", env.getTempFilePathPrefix(), chunk.getShipKey(), Values.kbps(bitrate));
    shipChunkPrintTimeoutSeconds = env.getShipChunkPrintTimeoutSeconds();
    shipChunkSeconds = env.getShipChunkSeconds();
    streamBucket = env.getStreamBucket();
    tempPlaylistFilePath = String.format("%s%s-%s.m3u8", env.getTempFilePathPrefix(), chunk.getShipKey(), Values.kbps(bitrate));
    threadName = String.format("CHUNK:%s", chunk.getKey());
    wavFilePath = String.format("%s%s.wav", env.getTempFilePathPrefix(), chunk.getKey());
  }

  @Override
  public double[][] getOutputPcmData() {
    return output;
  }

  @Override
  public String getWavFilePath() {
    return wavFilePath;
  }

  @Override
  public void print() {
    final Thread currentThread = Thread.currentThread();
    final String oldName = currentThread.getName();
    currentThread.setName(threadName);
    try {
      doWork();
    } catch (ShipException e) {
      LOG.error("Failed to print!", e);
    } finally {
      currentThread.setName(oldName);
    }
  }

  /**
   * Do the work inside a named thread
   */
  private void doWork() throws ShipException {
    switch (chunk.getState()) {
      case Pending:
        break;
      case Done:
        return;
      case Encoding, Mixing, Shipping:
        if (Instant.now().minusSeconds(shipChunkPrintTimeoutSeconds).isAfter(chunk.getUpdated()))
          chunkManager.put(chunk.reset());
        break;
    }

    if (!isSourceAudioReady()) return;

    var audios = getAllIntersectingAudios();

    // fail if any of the source audios are not ready
    var notReady = audios.stream()
      .filter(audio -> !SegmentAudioState.Ready.equals(audio.getState()))
      .map(SegmentAudio::getId)
      .collect(Collectors.toList());
    if (!notReady.isEmpty())
      throw new ShipException(String.format("Segment%s[%s] %s not actually ready!",
        1 < notReady.size() ? "s" : "",
        CSV.from(notReady),
        1 < notReady.size() ? "are" : "is"));

    // use any segment to determine audio metadata
    // NOTE: INCONSISTENCY AMONG SOURCE AUDIO RATES WILL RESULT IN A MALFORMED OUTPUT
    var ref = audios.stream().findAny()
      .orElseThrow(() -> new ShipException("No Segment Audio found!"))
      .getAudioFormat();
    int rate = (int) ref.getSampleRate();
    int channels = ref.getChannels();
    output = new double[rate * shipChunkSeconds][AUDIO_CHANNELS];

    // get the buffer from each audio and lay it into the output buffer
    LOG.debug("ready; will mix");
    chunkManager.put(chunk.setState(ChunkState.Mixing));
    for (var audio : audios) {
      var initialSourceFrame = audio.getFrame(chunk.getFromInstant());
      for (int f = 0; f < rate * shipChunkSeconds; f++)
        for (var c = 0; c < channels; c++)
          output[f][c] += read(initialSourceFrame + f, c, audio);
    }

    LOG.debug("mixed; will write");
    var audioFormat = computeAudioFormat(audios);
    try {
      var writer = new AudioStreamWriter(output, QUALITY);
      writer.writeToFile(getWavFilePath(), audioFormat, OutputEncoder.WAV, output.length);
      LOG.debug("did write {}", getWavFilePath());
    } catch (Exception e) {
      LOG.error("Failed to write audio", e);
      return;
    }

    LOG.debug("mixed; will encode");
    chunkManager.put(chunk.setState(ChunkState.Encoding));
    try {
      Files.deleteIfExists(Path.of(m4sFilePath));
      var cmd = computeCmdFFMPEG((int) audioFormat.getSampleRate());
      var proc = Runtime.getRuntime().exec(cmd);

      String line;
      List<String> output = Lists.newArrayList();
      BufferedReader stdError = new BufferedReader(new InputStreamReader(proc.getErrorStream()));
      while ((line = stdError.readLine()) != null) output.add(line);
      if (0 != proc.waitFor()) {
        LOG.error("Failed: {}\n\n{}", cmd, Text.formatMultiline(output.toArray()));
        return;
      }

      LOG.debug("did encode MPEG-2 transport stream at {} to {}", bitrate, m4sFilePath);
    } catch (Exception e) {
      LOG.error("Failed to encode audio", e);
      return;
    }

    LOG.debug("encoded; will ship");
    chunkManager.put(chunk.setState(ChunkState.Shipping));
    try {
      fileStoreProvider.putS3ObjectFromTempFile(m4sFilePath, streamBucket, m4sFileName);
      LOG.info("did ship {} bytes of {} audio to s3://{}/{}", getFileSize(m4sFilePath), Values.kbps(bitrate), streamBucket, m4sFileName);
    } catch (Exception e) {
      LOG.error("Failed to ship audio", e);
      return;
    }
    if (!chunkManager.isInitialized(chunk.getShipKey()))
      try {
        fileStoreProvider.putS3ObjectFromTempFile(mp4InitFilePath, streamBucket, mp4InitFileName);
        chunkManager.didInitialize(chunk.getShipKey());
        LOG.info("did ship {} bytes of {} initializer to s3://{}/{}", getFileSize(mp4InitFilePath), Values.kbps(bitrate), streamBucket, mp4InitFileName);
      } catch (Exception e) {
        LOG.error("Failed to ship audio", e);
        return;
      }

    chunk.addStreamOutputKey(m4sFileName);
    chunkManager.put(chunk.setState(ChunkState.Done));
  }

  /**
   * Compute the command to run ffmpeg for this chunk printing
   *
   * @param bitrate of target
   * @return ffmpeg command
   */
  private String computeCmdFFMPEG(int bitrate) {
    var ffmpegBitrate = String.format("%dk", bitrate / 1000);
    return String.join(" ", ImmutableList.of(
      "ffmpeg",
      "-i", getWavFilePath(),
      "-f", "hls",
      "-ac", "2",
      "-c:a", "aac",
      "-b:a", ffmpegBitrate,
      "-minrate", ffmpegBitrate,
      "-maxrate", ffmpegBitrate,
      "-start_number", String.valueOf(chunk.getIndex()),
      "-hls_fmp4_init_filename", mp4InitFileName,
      "-hls_segment_filename", m4sFilePathTemplate,
      "-hls_segment_type", "fmp4",
      "-hls_time", "11",
      tempPlaylistFilePath));
  }

  /**
   * Whether all the source segments for this chunk are ready
   *
   * @return true if all segments are ready
   */
  private boolean isSourceAudioReady() {
    List<String> ready = Lists.newArrayList();
    List<String> notReady = Lists.newArrayList();
    var audios = getAllIntersectingAudios();

    if (audios.isEmpty()) {
      LOG.warn("waiting on segments");
      return false;
    }

    for (var audio : audios)
      if (SegmentAudioState.Ready.equals(audio.getState()))
        ready.add(Segments.getIdentifier(audio.getSegment()));
      else
        notReady.add(Segments.getIdentifier(audio.getSegment()));

    if (notReady.isEmpty() && Objects.equals(ready.size(), audios.size())) {
      LOG.info("will mix audio from segments {}", CSV.from(ready));
      return true;
    }

    LOG.warn("waiting on audio from segments {}", CSV.from(notReady));
    return false;
  }

  /**
   * Compute the audio format from the given set of audios
   *
   * @param audios from which to compute format
   * @return audio format
   */
  private AudioFormat computeAudioFormat(Collection<SegmentAudio> audios) {
    return audios.stream().findAny().orElseThrow().getAudioFormat();
  }

  /**
   * Add one frame of a segment's source audio buffer onto the output buffer
   *
   * @param sourceFrame from which to get source
   * @param audio       source
   */
  private double read(int sourceFrame, int channel, SegmentAudio audio) {
    if (sourceFrame >= 0 && sourceFrame < audio.getPcmData().size())
      return audio.getPcmData().get(sourceFrame)[channel];
    else
      return 0;
  }

  /**
   * Get all the segment audios intersecting with this chunk
   *
   * @return segment audios
   */
  private Collection<SegmentAudio> getAllIntersectingAudios() {
    return segmentAudioManager.getAllIntersecting(chunk.getShipKey(), chunk.getFromInstant(), chunk.getToInstant());
  }
}
