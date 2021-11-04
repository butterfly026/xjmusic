// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.

package io.xj.ship.broadcast;

import com.google.inject.Inject;
import com.google.inject.assistedinject.Assisted;
import io.lindstrom.mpd.MPDParser;
import io.lindstrom.mpd.data.*;
import io.lindstrom.mpd.data.descriptor.GenericDescriptor;
import io.xj.hub.TemplateConfig;
import io.xj.lib.app.Environment;
import io.xj.lib.filestore.FileStoreException;
import io.xj.lib.filestore.FileStoreProvider;
import io.xj.lib.util.ValueException;
import io.xj.lib.util.Values;
import io.xj.nexus.persistence.ChainManager;
import io.xj.nexus.persistence.ManagerExistenceException;
import io.xj.nexus.persistence.ManagerFatalException;
import io.xj.nexus.persistence.ManagerPrivilegeException;
import io.xj.ship.ShipException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.time.Duration;
import java.time.Instant;
import java.time.OffsetDateTime;
import java.time.ZoneId;
import java.util.List;
import java.util.stream.Collectors;

/**
 Ship broadcast via HTTP Live Streaming #179453189
 */
public class PlaylistPublisherImpl implements PlaylistPublisher {
  private static final Logger LOG = LoggerFactory.getLogger(ChunkPrinterImpl.class);
  private static final String XML_HEADER = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n";
  private static final String AUDIO_MIME_TYPE = "audio/mp4";
  private static final String AUDIO_CODECS = "mp4a.40.2";
  private final ChainManager chains;
  private final ChunkManager chunks;
  private final FileStoreProvider fileStoreProvider;
  private final MPDParser parser;
  private final String mpdMimeType;
  private final String playlistKey;
  private final String shipKey;
  private final String streamBucket;
  private final int chunkSeconds;
  private final int shipBitrateHigh;

  @Inject
  public PlaylistPublisherImpl(
    @Assisted("shipKey") String shipKey,
    ChainManager chains,
    ChunkManager chunks,
    Environment env,
    FileStoreProvider fileStoreProvider
  ) {
    this.chains = chains;
    this.chunks = chunks;
    this.fileStoreProvider = fileStoreProvider;
    this.shipKey = shipKey;

    chunkSeconds = env.getShipChunkSeconds();
    mpdMimeType = env.getShipMpdMimeType();
    parser = new MPDParser();
    playlistKey = String.format("%s.mpd", shipKey);
    shipBitrateHigh = env.getShipBitrateHigh();
    streamBucket = env.getStreamBucket();
  }

  @Override
  public void publish(long nowMillis) {
    String content = "";
    try {
      content = computeMediaPresentationDescriptionXML(nowMillis);
      fileStoreProvider.putS3ObjectFromString(content, streamBucket, playlistKey, mpdMimeType);
      LOG.info("did ship {} bytes to s3://{}/{}", content.length(), streamBucket, playlistKey);
    } catch (FileStoreException | IOException | ShipException | ManagerFatalException | ManagerExistenceException | ManagerPrivilegeException | ValueException e) {
      LOG.error("failed to ship {} bytes to s3://{}/{}", content.length(), streamBucket, playlistKey);
    }
  }

  @Override
  public String computeMediaPresentationDescriptionXML(long nowMillis) throws IOException, ShipException, ManagerFatalException, ManagerExistenceException, ManagerPrivilegeException, ValueException {

    LOG.info("chunks {}",
      chunks.getAll(shipKey, nowMillis).stream()
        .map(chunk -> String.format("%s(%s)", chunk.getKey(shipBitrateHigh), chunk.getState()))
        .collect(Collectors.joining(",")));

    var chunks = this.chunks.getContiguousDone(shipKey, nowMillis);
    var chunk = chunks.stream().findFirst().orElseThrow(() -> new ShipException("No chunks!"));
    var templateConfig = new TemplateConfig(chains.readOneByShipKey(shipKey).getTemplateConfig());

    // use any segment to determine audio metadata
    // NOTE: INCONSISTENCY AMONG SOURCE AUDIO RATES WILL RESULT IN A MALFORMED OUTPUT

    var mpd = MPD.builder()
      .withProfiles(Profiles.builder().withProfiles(List.of(Profile.MPEG_DASH_LIVE)).build())
      .withType(PresentationType.DYNAMIC)
      .withMinBufferTime(Duration.ofSeconds(2))
      .withAvailabilityStartTime(OffsetDateTime.ofInstant(Instant.ofEpochMilli(0), ZoneId.systemDefault()))
      .withProgramInformations(List.of(
        ProgramInformation.builder()
          .withLang("eng")
          .withSource(templateConfig.getMetaSource())
          .withTitle(templateConfig.getMetaTitle())
          .build()))
      .withPeriods(List.of(
        Period.builder()
          .withStart(Duration.ofSeconds(0))
          .withAdaptationSet(
            AdaptationSet.builder()
              .withId(0)
              .withContentType("audio")
              .withSegmentAlignment("true")
              .withBitstreamSwitching(true)
              .withRepresentations(List.of(

                // FUTURE: multiple available representations, e.g. 320kbps, 240kbps, and 160kbps
                Representation.builder()
                  .withId(Values.k(shipBitrateHigh))
                  .withAudioSamplingRate(String.valueOf(chunk.getTemplateConfig().getOutputFrameRate()))
                  .withBandwidth(shipBitrateHigh)
                  .withCodecs(AUDIO_CODECS)
                  .withMimeType(AUDIO_MIME_TYPE)
                  .withAudioChannelConfigurations(
                    GenericDescriptor.builder()
                      .withSchemeIdUri("urn:mpeg:dash:23003:3:audio_channel_configuration:2011")
                      .withValue("2")
                      .build())
                  .withSegmentTemplate(
                    SegmentTemplate.builder()
                      .withDuration((long) chunkSeconds * 1000000L)
                      .withInitialization(String.format("%s-$RepresentationID$-IS.mp4", shipKey))
                      .withMedia(String.format("%s-$RepresentationID$-$Number$.m4s", shipKey))
                      .withStartNumber(0L)
                      .withTimescale(1000000L)
                      .build()
                  ).build()

              )).build()
          ).build()
      )).build();


    return String.format("%s%s", XML_HEADER, parser.writeAsString(mpd));
  }

}