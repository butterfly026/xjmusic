// Copyright (c) 2020, XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.mixer.demo;

import com.google.inject.Guice;
import com.google.inject.Module;

import io.xj.mixer.Mixer;
import io.xj.mixer.MixerConfig;
import io.xj.mixer.MixerFactory;
import io.xj.mixer.MixerModule;
import io.xj.mixer.OutputEncoder;
import io.xj.mixer.util.InternalResource;

import javax.sound.sampled.AudioFormat;
import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.time.Duration;

/**
 * Demo of mix, Java-native sequence-based audio mixing for music apps.
 *
 * @author Charney Kaye
 */
public enum Main {
  ;
  private static final long attackMicros = 10000;
  private static final long releaseMicros = 50000;

  private static final Duration preRoll = Duration.ofSeconds(1);
  private static final Duration postRoll = Duration.ofSeconds(2);

  private static final String outputFilePath = "/tmp/OUTPUT-MY-FILE.wav";
  private static final int outputFrameRate = 48000;
  private static final int outputChannels = 2;
  private static final int outputSampleBits = 32;
  private static final AudioFormat.Encoding outputEncoding = AudioFormat.Encoding.PCM_SIGNED;

  private static final long bpm = 121;
  private static final Duration beat = Duration.ofMinutes(1).dividedBy(bpm);
  private static final Duration step = beat.dividedBy(4);
  private static final int loopTimes = 8;

  private static final String filePrefix = "demo_audio/808/";
  private static final String fileSuffix = ".wav";

  private static final String kick1 = "kick1";
  private static final String kick2 = "kick2";
  private static final String marac = "maracas";
  private static final String snare = "snare";
  private static final String lotom = "tom1";
  private static final String clhat = "cl_hihat";

  private static final String[] sources = {
    kick1,
    kick2,
    marac,
    snare,
    lotom,
    clhat
  };

  private static final String[] demoSequence = {
    kick2,
    marac,
    clhat,
    marac,
    snare,
    marac,
    clhat,
    kick2,
    clhat,
    marac,
    kick1,
    marac,
    snare,
    lotom,
    clhat,
    marac
  };

  /**
   * Main method.
   *
   * @param args arguments
   * @throws Exception if execution fails
   */
  public static void main(String[] args) throws Exception {
    Module mod = new MixerModule();

    MixerFactory mixerFactory = Guice.createInjector(mod).getInstance(MixerFactory.class);

    Mixer demoMixer = mixerFactory.createMixer(new MixerConfig(
      new AudioFormat(outputEncoding, outputFrameRate, outputSampleBits, outputChannels,
        (outputChannels * outputSampleBits / 8), outputFrameRate, false),
      totalLength()
    ));

    // setup the sources
    for (String sourceName : sources) {
      //Get file from resources folder
      InternalResource internalResource = new InternalResource(filePrefix + sourceName + fileSuffix);
      demoMixer.loadSource(sourceName, new BufferedInputStream(new FileInputStream(internalResource.getFile())));
    }

    // setup the music
    int iL = demoSequence.length;
    for (int n = 0; loopTimes > n; n++) {
      for (int i = 0; i < iL; i++) {
        demoMixer.put(demoSequence[i], atMicros(n, i), atMicros(n, i + 3), attackMicros, releaseMicros, 1.0, 1.0, 0);
      }
    }

    // mix it
    demoMixer.mixToFile(OutputEncoder.WAV, outputFilePath, 0.618f);
  }

  private static long atMicros(int loopNum, int stepNum) {
    return preRoll.plus(loopLength().multipliedBy(loopNum)).plus(step.multipliedBy(stepNum)).toNanos() / 1000;
  }

  private static Duration totalLength() {
    return preRoll.plus(loopLength().multipliedBy(loopTimes)).plus(postRoll);
  }

  private static Duration loopLength() {
    return step.multipliedBy(demoSequence.length);
  }

}