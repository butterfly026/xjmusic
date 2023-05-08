// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.lib.mixer;


import io.xj.lib.app.AppEnvironment;
import io.xj.lib.notification.NotificationProvider;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.Mock;
import org.mockito.junit.MockitoJUnitRunner;

import javax.sound.sampled.AudioFormat;

import static org.junit.Assert.assertNotNull;

@RunWith(MockitoJUnitRunner.class)
public class MixerFactoryTest {
  private MixerFactory mixerFactory;
  @Mock
  NotificationProvider notificationProvider;

  @Before
  public void setUp() {
    AppEnvironment env = new AppEnvironment();
    EnvelopeProvider envelopeProvider = new EnvelopeProviderImpl();
    mixerFactory = new MixerFactoryImpl(env, envelopeProvider, notificationProvider);
  }

  @Test
  public void createMixerNotNull() throws Exception {
    Mixer mixer = mixerFactory.createMixer(new MixerConfig(
      new AudioFormat(AudioFormat.Encoding.PCM_FLOAT,
        48000, 32, 2, 8, 48000, false)
    ));
    assertNotNull(mixer);
  }

  /**
   * [#339] Mix module should support Big-Endian audio files
   */
  @Test
  public void createMixerNotNull_supportBigEndian() throws Exception {
    var mixer = mixerFactory.createMixer(new MixerConfig(
      new AudioFormat(AudioFormat.Encoding.PCM_FLOAT,
        48000, 32, 2, 8, 48000, true)
    ));
    assertNotNull(mixer);
  }

}