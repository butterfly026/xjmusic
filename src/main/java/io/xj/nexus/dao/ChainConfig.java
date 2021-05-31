package io.xj.nexus.dao;

import com.google.common.base.Strings;
import com.google.common.collect.Maps;
import com.typesafe.config.Config;
import com.typesafe.config.ConfigException;
import com.typesafe.config.ConfigFactory;
import io.xj.Chain;
import io.xj.lib.util.Text;
import io.xj.lib.util.ValueException;

import javax.sound.sampled.AudioFormat;
import java.util.Map;

/**
 Parse a TypeSafe `config` value for a Chain's configuration, overriding values from top-level default.conf--
 e.g.
 if the `config` value contains only `previewLengthMaxHours = 8`
 <p>
 [#177355683] Artist saves Chain config, validate & combine with defaults.
 */
public class ChainConfig {
  private static final String KEY_PREFIX = "chain.";

  private final int outputChannels;
  private final String KEY_OUTPUT_CHANNELS = "outputChannels";

  private final String outputContainer;
  private final String KEY_OUTPUT_CONTAINER = "outputContainer";

  private final AudioFormat.Encoding outputEncoding;
  private final String KEY_OUTPUT_ENCODING = "outputEncoding";

  private final double outputEncodingQuality;
  private final String KEY_OUTPUT_ENCODING_QUALITY = "outputEncodingQuality";

  private final int outputFrameRate;
  private final String KEY_OUTPUT_FRAME_RATE = "outputFrameRate";

  private final int outputSampleBits;
  private final String KEY_OUTPUT_SAMPLE_BITS = "outputSampleBits";

  private final double mixerCompressAheadSeconds;
  private final String KEY_MIXER_COMPRESS_AHEAD_SECONDS = "mixerCompressAheadSeconds";

  private final double mixerCompressDecaySeconds;
  private final String KEY_MIXER_COMPRESS_DECAY_SECONDS = "mixerCompressDecaySeconds";

  private final double mixerCompressRatioMax;
  private final String KEY_MIXER_COMPRESS_RATIO_MAX = "mixerCompressRatioMax";

  private final double mixerCompressRatioMin;
  private final String KEY_MIXER_COMPRESS_RATIO_MIN = "mixerCompressRatioMin";

  private final double mixerCompressToAmplitude;
  private final String KEY_MIXER_COMPRESS_TO_AMPLITUDE = "mixerCompressToAmplitude";

  private final int mixerDspBufferSize;
  private final String KEY_MIXER_DSP_BUFFER_SIZE = "mixerDspBufferSize";

  private final double mixerHighpassThresholdHz;
  private final String KEY_MIXER_HIGHPASS_THRESHOLD_HZ = "mixerHighpassThresholdHz";

  private final double mixerLowpassThresholdHz;
  private final String KEY_MIXER_LOWPASS_THRESHOLD_HZ = "mixerLowpassThresholdHz";

  private final double mixerNormalizationMax;
  private final String KEY_MIXER_NORMALIZATION_MAX = "mixerNormalizationMax";

  private final long mixerSampleAttackMicros;
  private final String KEY_MIXER_SAMPLE_ATTACK_MICROS = "mixerSampleAttackMicros";

  private final long mixerSampleReleaseMicros;
  private final String KEY_MIXER_SAMPLE_RELEASE_MICROS = "mixerSampleReleaseMicros";

  private final double dubMasterVolumeInstrumentTypePercussive;
  private final String KEY_DUB_MASTER_VOLUME_INSTRUMENT_TYPE_PERCUSSIVE = "dubMasterVolumeInstrumentTypePercussive";

  private final double dubMasterVolumeInstrumentTypeBass;
  private final String KEY_DUB_MASTER_VOLUME_INSTRUMENT_TYPE_BASS = "dubMasterVolumeInstrumentTypeBass";

  private final double dubMasterVolumeInstrumentTypePad;
  private final String KEY_DUB_MASTER_VOLUME_INSTRUMENT_TYPE_PAD = "dubMasterVolumeInstrumentTypePad";

  private final double dubMasterVolumeInstrumentTypeSticky;
  private final String KEY_DUB_MASTER_VOLUME_INSTRUMENT_TYPE_STICKY = "dubMasterVolumeInstrumentTypeSticky";

  private final double dubMasterVolumeInstrumentTypeStripe;
  private final String KEY_DUB_MASTER_VOLUME_INSTRUMENT_TYPE_STRIPE = "dubMasterVolumeInstrumentTypeStripe";

  private final double dubMasterVolumeInstrumentTypeStab;
  private final String KEY_DUB_MASTER_VOLUME_INSTRUMENT_TYPE_STAB = "dubMasterVolumeInstrumentTypeStab";

  /**
   Instantiate a Chain configuration from a string of typesafe config.
   Said string will be embedded in a `chain{...}` block such that
   provided simple Key=Value pairs will be understood as members of `chain`
   e.g. will override values from the `chain{...}` block of the top-level **default.conf**

   @param chain to get Config from
   */
  public ChainConfig(Chain chain, Config defaultConfig) throws ValueException {
    try {
      Config config = Strings.isNullOrEmpty(chain.getConfig()) ?
        defaultConfig :
        ConfigFactory.parseString(String.format("chain {\n%s\n}", chain.getConfig()))
          .withFallback(defaultConfig);
      outputChannels = config.getInt(cp(KEY_OUTPUT_CHANNELS));
      outputContainer = config.getString(cp(KEY_OUTPUT_CONTAINER));
      outputEncoding = new AudioFormat.Encoding(config.getString(cp(KEY_OUTPUT_ENCODING)));
      outputEncodingQuality = config.getDouble(cp(KEY_OUTPUT_ENCODING_QUALITY));
      outputFrameRate = config.getInt(cp(KEY_OUTPUT_FRAME_RATE));
      outputSampleBits = config.getInt(cp(KEY_OUTPUT_SAMPLE_BITS));
      mixerCompressAheadSeconds = config.getDouble(cp(KEY_MIXER_COMPRESS_AHEAD_SECONDS));
      mixerCompressDecaySeconds = config.getDouble(cp(KEY_MIXER_COMPRESS_DECAY_SECONDS));
      mixerCompressRatioMax = config.getDouble(cp(KEY_MIXER_COMPRESS_RATIO_MAX));
      mixerCompressRatioMin = config.getDouble(cp(KEY_MIXER_COMPRESS_RATIO_MIN));
      mixerCompressToAmplitude = config.getDouble(cp(KEY_MIXER_COMPRESS_TO_AMPLITUDE));
      mixerDspBufferSize = config.getInt(cp(KEY_MIXER_DSP_BUFFER_SIZE));
      mixerHighpassThresholdHz = config.getDouble(cp(KEY_MIXER_HIGHPASS_THRESHOLD_HZ));
      mixerLowpassThresholdHz = config.getDouble(cp(KEY_MIXER_LOWPASS_THRESHOLD_HZ));
      mixerNormalizationMax = config.getDouble(cp(KEY_MIXER_NORMALIZATION_MAX));
      mixerSampleAttackMicros = config.getLong(cp(KEY_MIXER_SAMPLE_ATTACK_MICROS));
      mixerSampleReleaseMicros = config.getLong(cp(KEY_MIXER_SAMPLE_RELEASE_MICROS));
      dubMasterVolumeInstrumentTypePercussive = config.getDouble(cp(KEY_DUB_MASTER_VOLUME_INSTRUMENT_TYPE_PERCUSSIVE));
      dubMasterVolumeInstrumentTypeBass = config.getDouble(cp(KEY_DUB_MASTER_VOLUME_INSTRUMENT_TYPE_BASS));
      dubMasterVolumeInstrumentTypePad = config.getDouble(cp(KEY_DUB_MASTER_VOLUME_INSTRUMENT_TYPE_PAD));
      dubMasterVolumeInstrumentTypeSticky = config.getDouble(cp(KEY_DUB_MASTER_VOLUME_INSTRUMENT_TYPE_STICKY));
      dubMasterVolumeInstrumentTypeStripe = config.getDouble(cp(KEY_DUB_MASTER_VOLUME_INSTRUMENT_TYPE_STRIPE));
      dubMasterVolumeInstrumentTypeStab = config.getDouble(cp(KEY_DUB_MASTER_VOLUME_INSTRUMENT_TYPE_STAB));

    } catch (ConfigException e) {
      throw new ValueException(e.getMessage());
    }
  }

  /**
   Chain-prefixed version of a key

   @param key to prefix
   @return chain-prefixed key
   */
  private String cp(String key) {
    return String.format("%s%s", KEY_PREFIX, key);
  }

  @SuppressWarnings("DuplicatedCode")
  @Override
  public String toString() {
    Map<String, String> config = Maps.newHashMap();
    config.put(KEY_OUTPUT_CHANNELS, String.valueOf(outputChannels));
    config.put(KEY_OUTPUT_CONTAINER, Text.doubleQuoted(outputContainer));
    config.put(KEY_OUTPUT_ENCODING, Text.doubleQuoted(outputEncoding.toString()));
    config.put(KEY_OUTPUT_ENCODING_QUALITY, String.valueOf(outputEncodingQuality));
    config.put(KEY_OUTPUT_FRAME_RATE, String.valueOf(outputFrameRate));
    config.put(KEY_OUTPUT_SAMPLE_BITS, String.valueOf(outputSampleBits));
    config.put(KEY_MIXER_COMPRESS_AHEAD_SECONDS, String.valueOf(mixerCompressAheadSeconds));
    config.put(KEY_MIXER_COMPRESS_DECAY_SECONDS, String.valueOf(mixerCompressDecaySeconds));
    config.put(KEY_MIXER_COMPRESS_RATIO_MAX, String.valueOf(mixerCompressRatioMax));
    config.put(KEY_MIXER_COMPRESS_RATIO_MIN, String.valueOf(mixerCompressRatioMin));
    config.put(KEY_MIXER_COMPRESS_TO_AMPLITUDE, String.valueOf(mixerCompressToAmplitude));
    config.put(KEY_MIXER_DSP_BUFFER_SIZE, String.valueOf(mixerDspBufferSize));
    config.put(KEY_MIXER_HIGHPASS_THRESHOLD_HZ, String.valueOf(mixerHighpassThresholdHz));
    config.put(KEY_MIXER_LOWPASS_THRESHOLD_HZ, String.valueOf(mixerLowpassThresholdHz));
    config.put(KEY_MIXER_NORMALIZATION_MAX, String.valueOf(mixerNormalizationMax));
    config.put(KEY_MIXER_SAMPLE_ATTACK_MICROS, String.valueOf(mixerSampleAttackMicros));
    config.put(KEY_MIXER_SAMPLE_RELEASE_MICROS, String.valueOf(mixerSampleReleaseMicros));
    config.put(KEY_DUB_MASTER_VOLUME_INSTRUMENT_TYPE_PERCUSSIVE, String.valueOf(dubMasterVolumeInstrumentTypePercussive));
    config.put(KEY_DUB_MASTER_VOLUME_INSTRUMENT_TYPE_BASS, String.valueOf(dubMasterVolumeInstrumentTypeBass));
    config.put(KEY_DUB_MASTER_VOLUME_INSTRUMENT_TYPE_PAD, String.valueOf(dubMasterVolumeInstrumentTypePad));
    config.put(KEY_DUB_MASTER_VOLUME_INSTRUMENT_TYPE_STICKY, String.valueOf(dubMasterVolumeInstrumentTypeSticky));
    config.put(KEY_DUB_MASTER_VOLUME_INSTRUMENT_TYPE_STRIPE, String.valueOf(dubMasterVolumeInstrumentTypeStripe));
    config.put(KEY_DUB_MASTER_VOLUME_INSTRUMENT_TYPE_STAB, String.valueOf(dubMasterVolumeInstrumentTypeStab));
    return Text.formatMultiline(config.entrySet().stream()
      .sorted(Map.Entry.comparingByKey())
      .map(pair -> String.format("%s = %s", pair.getKey(), pair.getValue()))
      .toArray());
  }

  /**
   @return Output Sample Bits
   */
  public int getOutputSampleBits() {
    return outputSampleBits;
  }

  /**
   @return Output Frame Rate (Hz)
   */
  public int getOutputFrameRate() {
    return outputFrameRate;
  }

  /**
   @return Output Encoding Quality (ratio from 0 to 1)
   */
  public double getOutputEncodingQuality() {
    return outputEncodingQuality;
  }

  /**
   @return Output Encoding
   */
  public AudioFormat.Encoding getOutputEncoding() {
    return outputEncoding;
  }

  /**
   @return Output Container
   */
  public String getOutputContainer() {
    return outputContainer;
  }

  /**
   @return # of Output Channels
   */
  public int getOutputChannels() {
    return outputChannels;
  }

  /**
   @return ratio of amplitude to dub audio for Percussive-type instruments
   */
  public double getDubMasterVolumeInstrumentTypePercussive() {
    return dubMasterVolumeInstrumentTypePercussive;
  }

  /**
   @return ratio of amplitude to dub audio for Bass-type instruments
   */
  public double getDubMasterVolumeInstrumentTypeBass() {
    return dubMasterVolumeInstrumentTypeBass;
  }

  /**
   @return ratio of amplitude to dub audio for Pad-type instruments
   */
  public double getDubMasterVolumeInstrumentTypePad() {
    return dubMasterVolumeInstrumentTypePad;
  }

  /**
   @return ratio of amplitude to dub audio for Stick-type instruments
   */
  public double getDubMasterVolumeInstrumentTypeSticky() {
    return dubMasterVolumeInstrumentTypeSticky;
  }

  /**
   @return ratio of amplitude to dub audio for Strip-type instruments
   */
  public double getDubMasterVolumeInstrumentTypeStripe() {
    return dubMasterVolumeInstrumentTypeStripe;
  }

  /**
   @return ratio of amplitude to dub audio for Stab-type instruments
   */
  public double getDubMasterVolumeInstrumentTypeStab() {
    return dubMasterVolumeInstrumentTypeStab;
  }

  /**
   @return mixer Compress Ahead Seconds
   */
  public double getMixerCompressAheadSeconds() {
    return mixerCompressAheadSeconds;
  }

  /**
   @return mixer Compress Decay Seconds
   */
  public double getMixerCompressDecaySeconds() {
    return mixerCompressDecaySeconds;
  }

  /**
   @return mixer Compress Ratio Max
   */
  public double getMixerCompressRatioMax() {
    return mixerCompressRatioMax;
  }

  /**
   @return mixer Compress Ratio Min
   */
  public double getMixerCompressRatioMin() {
    return mixerCompressRatioMin;
  }

  /**
   @return mixer Compress To Amplitude
   */
  public double getMixerCompressToAmplitude() {
    return mixerCompressToAmplitude;
  }

  /**
   @return mixer Dsp Buffer Size
   */
  public int getMixerDspBufferSize() {
    return mixerDspBufferSize;
  }

  /**
   @return mixer Highpass Threshold Hz
   */
  public double getMixerHighpassThresholdHz() {
    return mixerHighpassThresholdHz;
  }

  /**
   @return mixer Lowpass Threshold Hz
   */
  public double getMixerLowpassThresholdHz() {
    return mixerLowpassThresholdHz;
  }

  /**
   @return mixer Normalization Max
   */
  public double getMixerNormalizationMax() {
    return mixerNormalizationMax;
  }

  /**
   @return mixer Sample Attack Micros
   */
  public long getMixerSampleAttackMicros() {
    return mixerSampleAttackMicros;
  }

  /**
   @return mixer Sample Release Micros
   */
  public long getMixerSampleReleaseMicros() {
    return mixerSampleReleaseMicros;
  }
}