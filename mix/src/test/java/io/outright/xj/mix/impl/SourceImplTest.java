// Copyright (c) 2017, Outright Mental Inc. (http://outright.io) All Rights Reserved.
package io.outright.xj.mix.impl;

import io.outright.xj.mix.MixFactory;
import io.outright.xj.mix.MixModule;
import io.outright.xj.mix.Source;
import io.outright.xj.mix.impl.exception.SourceException;
import io.outright.xj.mix.impl.resource.InternalResource;

import com.google.inject.Guice;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import javax.sound.sampled.AudioFormat;
import java.io.BufferedInputStream;
import java.io.FileInputStream;

import static org.junit.Assert.assertArrayEquals;
import static org.junit.Assert.assertEquals;

public class SourceImplTest {

  private MixFactory mixFactory = Guice.createInjector(new MixModule()).getInstance(MixFactory.class);

  private Source F32LSB_48kHz_Stereo;
  private Source S16LSB_44100Hz_Mono;

  @Before
  public void setUp() throws Exception {
    F32LSB_48kHz_Stereo = mixFactory.createSource(
      "F32LSB_48kHz_Stereo",
      new BufferedInputStream(
        new FileInputStream(
          new InternalResource(
            "test_audio/F32LSB_48kHz_Stereo.wav"
          ).getFile())));

    S16LSB_44100Hz_Mono = mixFactory.createSource(
      "S16LSB_44100Hz_Mono",
      new BufferedInputStream(
        new FileInputStream(
          new InternalResource(
            "test_audio/S16LSB_44100Hz_Mono.wav"
          ).getFile())));
  }

  @After
  public void tearDown() throws Exception {
    F32LSB_48kHz_Stereo = null;
    S16LSB_44100Hz_Mono = null;
  }

  @Test(expected = SourceException.class)
  public void unsupported_over2channels() throws Exception {
    mixFactory.createSource(
      "F32LSB_48kHz_6ch",
      new BufferedInputStream(
        new FileInputStream(
          new InternalResource(
            "test_audio/F32LSB_48kHz_6ch.wav"
          ).getFile())));
  }

  @Test
  public void frameAt_F32LSB_48kHz_Stereo() throws Exception {
    double[] frameAt = F32LSB_48kHz_Stereo.frameAt(243, 0.9, 0, 2);
    assertArrayEquals(new double[]{-0.002029318059794605, -0.0013323662686161696}, frameAt, 0);
  }

  @Test
  public void frameAt_S16LSB_44100Hz_Mono() throws Exception {
    double[] frameAt = S16LSB_44100Hz_Mono.frameAt(125, 0.9, 0, 2);
    assertArrayEquals(new double[]{0.0010986328125, 0.0010986328125}, frameAt, 0);
  }

  @Test
  public void lengthMicros_F32LSB_48kHz_Stereo() throws Exception {
    long lengthMicros = F32LSB_48kHz_Stereo.lengthMicros();
    assertEquals(361750, lengthMicros);
  }

  @Test
  public void lengthMicros_S16LSB_44100Hz_Mono() throws Exception {
    long lengthMicros = S16LSB_44100Hz_Mono.lengthMicros();
    assertEquals(865306, lengthMicros);
  }

  @Test
  public void getInputFormat_F32LSB_48kHz_Stereo() throws Exception {
    AudioFormat audioFormat = F32LSB_48kHz_Stereo.getInputFormat();
    assertEquals(2, audioFormat.getChannels());
    assertEquals(48000, audioFormat.getSampleRate(),0);
    assertEquals(48000, audioFormat.getFrameRate(),0);
    assertEquals(32,audioFormat.getSampleSizeInBits());
    assertEquals(8,audioFormat.getFrameSize());
    assertEquals(false, audioFormat.isBigEndian());
  }

  @Test
  public void getInputFormat_S16LSB_44100Hz_Mono() throws Exception {
    AudioFormat audioFormat = S16LSB_44100Hz_Mono.getInputFormat();
    assertEquals(1, audioFormat.getChannels());
    assertEquals(44100, audioFormat.getSampleRate(),0);
    assertEquals(44100, audioFormat.getFrameRate(),0);
    assertEquals(16,audioFormat.getSampleSizeInBits());
    assertEquals(2,audioFormat.getFrameSize());
    assertEquals(false, audioFormat.isBigEndian());
  }

  @Test
  public void getState() throws Exception {
    assertEquals(Source.READY, F32LSB_48kHz_Stereo.getState());
    assertEquals(Source.READY, S16LSB_44100Hz_Mono.getState());
  }

  @Test
  public void getSourceId() throws Exception {
    assertEquals("F32LSB_48kHz_Stereo", F32LSB_48kHz_Stereo.getSourceId());
    assertEquals("S16LSB_44100Hz_Mono", S16LSB_44100Hz_Mono.getSourceId());
  }

  @Test
  public void getFrameRate() throws Exception {
    assertEquals(48000, F32LSB_48kHz_Stereo.getFrameRate(), 0);
    assertEquals(44100, S16LSB_44100Hz_Mono.getFrameRate(), 0);
  }

}