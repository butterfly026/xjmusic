// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.nexus.dub;

import com.google.common.base.Strings;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.google.inject.Inject;
import com.google.inject.assistedinject.Assisted;
import io.xj.api.InstrumentAudio;
import io.xj.api.SegmentChoiceArrangementPick;
import io.xj.api.SegmentMessage;
import io.xj.api.SegmentMessageType;
import io.xj.api.SegmentType;
import io.xj.lib.mixer.Mixer;
import io.xj.lib.mixer.MixerConfig;
import io.xj.lib.mixer.MixerFactory;
import io.xj.lib.mixer.OutputEncoder;
import io.xj.lib.util.Text;
import io.xj.nexus.NexusException;
import io.xj.nexus.fabricator.Fabricator;
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
  private final Logger log = LoggerFactory.getLogger(DubMasterImpl.class);
  private final Fabricator fabricator;
  private final MixerFactory mixerFactory;
  private final List<String> warnings = Lists.newArrayList();
  private final Map<UUID, Double> pickOffsetStart = Maps.newHashMap();
  private final DubAudioCache dubAudioCache;
  private Mixer mixer;

  @Inject
  public DubMasterImpl(
    @Assisted("basis") Fabricator fabricator,
    DubAudioCache dubAudioCache,
    MixerFactory mixerFactory
    /*-*/) {
    this.dubAudioCache = dubAudioCache;
    this.fabricator = fabricator;
    this.mixerFactory = mixerFactory;
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
  public void doWork() throws NexusException {
    SegmentType type = null;
    try {
      type = fabricator.getType();
      doMixerSourceLoading();
      double preroll = computePreroll();
      doMixerTargetSetting(preroll);
      doMix();
      reportWarnings();
      report();

      // write updated segment with waveform preroll
      fabricator.updateSegment(fabricator.getSegment()
        .waveformPreroll(preroll));
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
  private void doMixerSourceLoading() throws Exception {
    for (InstrumentAudio audio : fabricator.getPickedAudios()) {
      String key = audio.getWaveformKey();
      if (Strings.isNullOrEmpty(key)) continue;

      if (!mixer().hasLoadedSource(audio.getId().toString()))
        mixer().loadSource(audio.getId().toString(), dubAudioCache.get(key));
    }
  }

  /**
   Iterate through every picked audio and, based on its transient and position in the segment, determine the preroll required, and keep the maximum preroll required out of all the audios.
   <p>
   [#165799913] Dubbed audio can begin before segment start
   - During dub work, the waveform preroll required for the current segment is determined by finding the earliest positioned audio sample. **This process must factor in the transient of each audio sample.**

   @return computed preroll (in seconds)
   */
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
   [#341] Dub process takes into account the start offset of each audio, in order to ensure that it is mixed such that the hit is exactly on the meter
   [#165799913] Dubbed audio can begin before segment start
   - During dub work, output audio includes the head start, and `waveform_preroll` value is persisted to segment
   [#171224848] Duration of events should include segment preroll

   @param preroll (seconds)
   @param pick    to set playback for
   */
  private void setupTarget(Double preroll, SegmentChoiceArrangementPick pick) throws Exception {
    mixer().put(
      fabricator.sourceMaterial().getInstrumentTypeForAudioId(pick.getInstrumentAudioId()).toString(),
      pick.getInstrumentAudioId().toString(),
      toMicros(preroll + pick.getStart() - computeOffsetStart(pick)),
      toMicros(preroll + pick.getStart() + pick.getLength()),
      pick.getAmplitude() * fabricator.getAudioVolume(pick));
  }

  /**
   Compute the offset start for a pick, and cache results

   @param pick to get offset start for
   @return offset start, or cached result
   */
  private Double computeOffsetStart(SegmentChoiceArrangementPick pick) throws NexusException {
    if (!pickOffsetStart.containsKey(pick.getId()))
      pickOffsetStart.put(pick.getId(),
        fabricator.sourceMaterial().getInstrumentAudio(pick.getInstrumentAudioId())
          .orElseThrow(() -> new NexusException("compute offset start"))
          .getStart());
    return pickOffsetStart.get(pick.getId());
  }

  /**
   MasterDub implements Mixer module to mix final output to waveform streamed directly to Amazon S3@param preroll
   */
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
    if (Objects.isNull(mixer)) {
      MixerConfig config = new MixerConfig(fabricator.getOutputAudioFormat())
        .setLogPrefix(String.format("[segId=%s] ", fabricator.getSegment().getId()))
        .setNormalizationCeiling(fabricator.getChainConfig().getMixerNormalizationCeiling())
        .setDSPBufferSize(fabricator.getChainConfig().getMixerDspBufferSize())
        .setNormalizationBoostThreshold(fabricator.getChainConfig().getMixerNormalizationBoostThreshold())
        .setCompressRatioMax(fabricator.getChainConfig().getMixerCompressRatioMax())
        .setCompressRatioMin(fabricator.getChainConfig().getMixerCompressRatioMin())
        .setHighpassThresholdHz(fabricator.getChainConfig().getMixerHighpassThresholdHz())
        .setLowpassThresholdHz(fabricator.getChainConfig().getMixerLowpassThresholdHz())
        .setCompressToAmplitude(fabricator.getChainConfig().getMixerCompressToAmplitude())
        .setCompressAheadSeconds(fabricator.getChainConfig().getMixerCompressAheadSeconds())
        .setCompressDecaySeconds(fabricator.getChainConfig().getMixerCompressDecaySeconds());

      mixer = mixerFactory.createMixer(config);
    }

    mixer.setBusLevel("Percussive", fabricator.getChainConfig().getDubMasterVolumeInstrumentTypePercussive());
    mixer.setBusLevel("Bass", fabricator.getChainConfig().getDubMasterVolumeInstrumentTypeBass());
    mixer.setBusLevel("Pad", fabricator.getChainConfig().getDubMasterVolumeInstrumentTypePad());
    mixer.setBusLevel("Sticky", fabricator.getChainConfig().getDubMasterVolumeInstrumentTypeSticky());
    mixer.setBusLevel("Stripe", fabricator.getChainConfig().getDubMasterVolumeInstrumentTypeStripe());
    mixer.setBusLevel("Stab", fabricator.getChainConfig().getDubMasterVolumeInstrumentTypeStab());

    return mixer;
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

      fabricator.add(new SegmentMessage()
        .id(UUID.randomUUID())
        .segmentId(fabricator.getSegment().getId())
        .type(SegmentMessageType.WARNING)
        .body(body.toString())
        );
    } catch (Exception e1) {
      log.warn("Failed to create SegmentMessage", e1);
    }
  }

}
