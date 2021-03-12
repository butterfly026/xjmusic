// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.service.nexus.dub;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.google.inject.Inject;
import com.google.inject.assistedinject.Assisted;
import com.typesafe.config.Config;
import datadog.trace.api.Trace;
import io.xj.InstrumentAudio;
import io.xj.Segment;
import io.xj.SegmentChoiceArrangementPick;
import io.xj.SegmentMessage;
import io.xj.lib.mixer.Mixer;
import io.xj.lib.mixer.MixerConfig;
import io.xj.lib.mixer.MixerFactory;
import io.xj.lib.mixer.OutputEncoder;
import io.xj.lib.util.Text;
import io.xj.service.nexus.NexusException;
import io.xj.service.nexus.fabricator.Fabricator;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.UUID;

/**
 [#214] If a Chain has Sequences associated with it directly, prefer those choices to any in the Library
 */
public class DubMasterImpl implements DubMaster {
  private static final int MICROSECONDS_PER_SECOND = 1000000;
  private static final long OUTPUT_LENGTH_EXTRA_SECONDS = 2; // FUTURE need to compute actual longest sound in segment
  private final Logger log = LoggerFactory.getLogger(DubMasterImpl.class);
  private final Fabricator fabricator;
  private final MixerFactory mixerFactory;
  private final List<String> warnings = Lists.newArrayList();
  private final Map<String, Double> pickOffsetStart = Maps.newHashMap();
  private final Map<String, Double> pickPitchRatio = Maps.newHashMap();
  private final DubAudioCache dubAudioCache;
  private final long audioAttackMicros;
  private final long audioReleaseMicros;
  private Mixer _mixer;
  private final double normalizationMax;
  private final int dspBufferSize;
  private final double compressRatioMax;
  private final double compressRatioMin;
  private final double highpassThresholdHz;
  private final double lowpassThresholdHz;
  private final double compressToAmplitude;
  private final double compressAheadSeconds;
  private final double compressDecaySeconds;

  @Inject
  public DubMasterImpl(
    @Assisted("basis") Fabricator fabricator,
    DubAudioCache dubAudioCache,
    MixerFactory mixerFactory,
    Config config
    /*-*/) {
    this.dubAudioCache = dubAudioCache;
    this.fabricator = fabricator;
    this.mixerFactory = mixerFactory;

    audioAttackMicros = config.getInt("chain.mixerSampleAttackMicros");
    audioReleaseMicros = config.getInt("chain.mixerSampleReleaseMicros");
    normalizationMax = config.getDouble("chain.mixerNormalizationMax");
    dspBufferSize = config.getInt("chain.mixerDspBufferSize");
    compressRatioMax = config.getDouble("chain.mixerCompressRatioMax");
    compressRatioMin = config.getDouble("chain.mixerCompressRatioMin");
    highpassThresholdHz = config.getDouble("chain.mixerHighpassThresholdHz");
    lowpassThresholdHz = config.getDouble("chain.mixerLowpassThresholdHz");
    compressToAmplitude = config.getDouble("chain.mixerCompressToAmplitude");
    compressAheadSeconds = config.getDouble("chain.mixerCompressAheadSeconds");
    compressDecaySeconds = config.getDouble("chain.mixerCompressDecaySeconds");
  }

  /**
   Microseconds of seconds

   @param seconds to convert
   @return microseconds
   */
  private static Long toMicros(Double seconds) {
    return (long) (seconds * MICROSECONDS_PER_SECOND);
  }

  @Override
  @Trace(resourceName = "nexus/dub/master", operationName = "doWork")
  public void doWork() throws NexusException {
    Segment.Type type = null;
    try {
      type = fabricator.getType();
      doMixerSourceLoading();
      double preroll = computePreroll();
      doMixerTargetSetting(preroll);
      doMix();
      reportWarnings();
      report();

      // write updated segment with waveform preroll
      fabricator.updateSegment(fabricator.getSegment().toBuilder()
        .setWaveformPreroll(preroll).build());
      fabricator.done();

    } catch (Exception e) {
      throw new NexusException(
        String.format("Failed to do %s-type MasterDub for segment #%s",
          type, fabricator.getSegment().getId()), e);
    }
  }

  /**
   @throws Exception if failed to stream data of item of cache
   */
  @Trace(resourceName = "nexus/dub/master", operationName = "doMixerSourceLoading")
  private void doMixerSourceLoading() throws Exception {
    for (InstrumentAudio audio : fabricator.getPickedAudios()) {
      String key = audio.getWaveformKey();

      if (!mixer().hasLoadedSource(audio.getId())) try {
        mixer().loadSource(audio.getId(), dubAudioCache.get(key));

      } catch (Exception e) {
        dubAudioCache.refresh(key);
        warnings.add(e.getMessage() + " " + Text.formatStackTrace(e));
      }
    }
  }

  /**
   Iterate through every picked audio and, based on its transient and position in the segment, determine the preroll required, and keep the maximum preroll required out of all the audios.
   <p>
   [#165799913] Dubbed audio can begin before segment start
   - During dub work, the waveform preroll required for the current segment is determined by finding the earliest positioned audio sample. **This process must factor in the transient of each audio sample.**

   @return computed preroll (in seconds)
   */
  @Trace(resourceName = "nexus/dub/master", operationName = "computePreroll")
  private double computePreroll() {
    double maxPreroll = 0.0;
    for (SegmentChoiceArrangementPick pick : fabricator.getPicks())
      try {
        maxPreroll = Math.max(maxPreroll, computeOffsetStart(pick) - pick.getStart());
      } catch (Exception e) {
        warnings.add(e.getMessage() + " " + Text.formatStackTrace(e));
      }
    return maxPreroll;
  }

  /**
   Implements Mixer module to set playback for Picks in current Segment
   <p>
   [#165799913] Dubbed audio can begin before segment start
   - During dub work, output audio includes the head start, and `waveform_preroll` value is persisted to segment

   @param preroll (seconds)
   */
  @Trace(resourceName = "nexus/dub/master", operationName = "doMixerTargetSetting")
  private void doMixerTargetSetting(Double preroll) {
    for (SegmentChoiceArrangementPick pick : fabricator.getPicks())
      try {
        setupTarget(preroll, pick);
      } catch (Exception e) {
        warnings.add(e.getMessage() + " " + Text.formatStackTrace(e));
      }
  }

  /**
   Set playback for a pick
   <p>
   [#283] Pitch ratio should result in lower audio playback for lower note
   [#341] Dub process takes into account the start offset of each audio, in order to ensure that it is mixed such that the hit is exactly on the meter
   [#165799913] Dubbed audio can begin before segment start
   - During dub work, output audio includes the head start, and `waveform_preroll` value is persisted to segment
   [#171224848] Duration of events should include segment preroll

   @param preroll (seconds)
   @param pick    to set playback for
   */
  @Trace(resourceName = "nexus/dub/master", operationName = "setupTarget")
  private void setupTarget(Double preroll, SegmentChoiceArrangementPick pick) throws Exception {
    mixer().put(pick.getInstrumentAudioId(),
      toMicros(preroll + pick.getStart() - computeOffsetStart(pick)),
      toMicros(preroll + pick.getStart() + pick.getLength()) + audioReleaseMicros,
      audioAttackMicros,
      audioReleaseMicros,
      pick.getAmplitude() * fabricator.getAmplitudeForInstrumentType(pick),
      computePitchRatio(pick),
      0);
  }

  /**
   Compute the pitch ratio for a pick, and cache results
   <p>
   If the picked audio is at higher pitch than the original source material, the ratio will be < 1.0 --
   meaning that the audio is to be played back at a slower speed (lower pitch).
   <p>
   A ratio > 1.0 means the audio is to be played back at a faster speed (higher pitch).

   @param pick to get pitch ratio for
   @return pitch ratio, or cached result
   */
  @Trace(resourceName = "nexus/dub/master", operationName = "computePitchRatio")
  private Double computePitchRatio(SegmentChoiceArrangementPick pick) throws NexusException {
    if (!pickPitchRatio.containsKey(pick.getId()))
      pickPitchRatio.put(pick.getId(),
        fabricator.getSourceMaterial().getInstrumentAudio(pick.getInstrumentAudioId())
          .orElseThrow(() -> new NexusException("compute pitch ratio"))
          .getPitch() / pick.getPitch());
    return pickPitchRatio.get(pick.getId());
  }

  /**
   Compute the offset start for a pick, and cache results

   @param pick to get offset start for
   @return offset start, or cached result
   */
  @Trace(resourceName = "nexus/dub/master", operationName = "computeOffsetStart")
  private Double computeOffsetStart(SegmentChoiceArrangementPick pick) throws NexusException {
    if (!pickOffsetStart.containsKey(pick.getId()))
      pickOffsetStart.put(pick.getId(),
        fabricator.getSourceMaterial().getInstrumentAudio(pick.getInstrumentAudioId())
          .orElseThrow(() -> new NexusException("compute offset start"))
          .getStart() / computePitchRatio(pick));
    return pickOffsetStart.get(pick.getId());
  }

  /**
   MasterDub implements Mixer module to mix final output to waveform streamed directly to Amazon S3@param preroll
   */
  @Trace(resourceName = "nexus/dub/master", operationName = "doMix")
  private void doMix() throws Exception {
    float quality = (float) fabricator.getChainConfig().getOutputEncodingQuality();
    mixer().mixToFile(OutputEncoder.parse(fabricator.getChainConfig().getOutputContainer()), fabricator.getFullQualityAudioOutputFilePath(), quality);
  }

  /**
   Get a mixer instance
   (caches instance)

   @return mixer
   */
  private Mixer mixer() throws Exception {
    if (Objects.isNull(_mixer)) {
      MixerConfig config = new MixerConfig(fabricator.getOutputAudioFormat(), fabricator.getSegmentTotalLength().plusSeconds(OUTPUT_LENGTH_EXTRA_SECONDS))
        .setLogPrefix(String.format("[segId=%s] ", fabricator.getSegment().getId()))
        .setNormalizationMax(normalizationMax)
        .setDSPBufferSize(dspBufferSize)
        .setCompressRatioMax(compressRatioMax)
        .setCompressRatioMin(compressRatioMin)
        .setHighpassThresholdHz(highpassThresholdHz)
        .setLowpassThresholdHz(lowpassThresholdHz)
        .setCompressToAmplitude(compressToAmplitude)
        .setCompressAheadSeconds(compressAheadSeconds)
        .setCompressDecaySeconds(compressDecaySeconds);

      _mixer = mixerFactory.createMixer(config);
    }

    return _mixer;
  }

  /**
   Report
   */
  private void report() {
    // fabricator.report() anything else interesting of the dub operation
  }

  /**
   Report warnings in a concatenated Segment Message
   */
  private void reportWarnings() {
    try {
      if (warnings.isEmpty()) return;

      StringBuilder body = new StringBuilder("MasterDub had warnings:");
      for (String warning : warnings) {
        body.append(String.format("%n%n%s", warning));
      }

      fabricator.add(SegmentMessage.newBuilder()
        .setId(UUID.randomUUID().toString())
        .setSegmentId(fabricator.getSegment().getId())
        .setType(SegmentMessage.Type.Warning)
        .setBody(body.toString())
        .build());
    } catch (Exception e1) {
      log.warn("Failed to create SegmentMessage", e1);
    }
  }

}