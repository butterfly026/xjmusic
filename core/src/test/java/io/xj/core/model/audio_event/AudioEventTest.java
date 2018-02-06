// Copyright (c) 2018, XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.core.model.audio_event;

import io.xj.core.exception.BusinessException;
import org.junit.Rule;
import org.junit.Test;
import org.junit.rules.ExpectedException;

import java.math.BigInteger;

import static org.junit.Assert.assertEquals;

public class AudioEventTest {

  @Rule public ExpectedException failure = ExpectedException.none();

  @Test
  public void validate() throws Exception {
    new AudioEvent()
      .setAudioId(BigInteger.valueOf(1235))
      .setPosition(0.75)
      .setDuration(3.45)
      .setInflection("SMACK")
      .setNote("D6")
      .setTonality(0.6)
      .setVelocity(0.9)
      .validate();
  }

  @Test
  public void validate_failsWithoutDuration() throws Exception {
    failure.expect(BusinessException.class);
    failure.expectMessage("Duration is required");

    new AudioEvent()
      .setAudioId(BigInteger.valueOf(1235))
      .setPosition(0.75)
      .setInflection("SMACK")
      .setNote("D6")
      .setTonality(0.6)
      .setVelocity(0.9)
      .validate();
  }

  @Test
  public void validate_failsWithoutAudioID() throws Exception {
    failure.expect(BusinessException.class);
    failure.expectMessage("Audio ID is required");

    new AudioEvent()
      .setPosition(0.75)
      .setDuration(3.45)
      .setInflection("SMACK")
      .setNote("D6")
      .setTonality(0.6)
      .setVelocity(0.9)
      .validate();
  }

  @Test
  public void validate_failsWithoutPosition() throws Exception {
    failure.expect(BusinessException.class);
    failure.expectMessage("Position is required");

    new AudioEvent()
      .setAudioId(BigInteger.valueOf(1235))
      .setDuration(3.45)
      .setInflection("SMACK")
      .setNote("D6")
      .setTonality(0.6)
      .setVelocity(0.9)
      .validate();
  }

  @Test
  public void validate_failsWithoutInflection() throws Exception {
    failure.expect(BusinessException.class);
    failure.expectMessage("Inflection is required");

    new AudioEvent()
      .setAudioId(BigInteger.valueOf(1235))
      .setPosition(0.75)
      .setDuration(3.45)
      .setNote("D6")
      .setTonality(0.6)
      .setVelocity(0.9)
      .validate();
  }

  @Test
  public void validate_failsWithoutNote() throws Exception {
    failure.expect(BusinessException.class);
    failure.expectMessage("Note is required");

    new AudioEvent()
      .setAudioId(BigInteger.valueOf(1235))
      .setPosition(0.75)
      .setDuration(3.45)
      .setInflection("SMACK")
      .setTonality(0.6)
      .setVelocity(0.9)
      .validate();
  }

  @Test
  public void validate_failsWithoutTonality() throws Exception {
    failure.expect(BusinessException.class);
    failure.expectMessage("Tonality is required");

    new AudioEvent()
      .setAudioId(BigInteger.valueOf(1235))
      .setPosition(0.75)
      .setDuration(3.45)
      .setInflection("SMACK")
      .setNote("D6")
      .setVelocity(0.9)
      .validate();
  }

  @Test
  public void validate_failsWithoutVelocity() throws Exception {
    failure.expect(BusinessException.class);
    failure.expectMessage("Velocity is required");

    new AudioEvent()
      .setAudioId(BigInteger.valueOf(1235))
      .setPosition(0.75)
      .setDuration(3.45)
      .setInflection("SMACK")
      .setNote("D6")
      .setTonality(0.6)
      .validate();
  }

  /**
   [#154976066] Architect wants to limit the floating point precision of chord and event position, in order to limit obsession over the position of things.
   */
  @Test
  public void position_rounded() throws Exception {
    assertEquals(1.25, new AudioEvent().setPosition(1.25179957).getPosition(), 0.0000001);
  }


}
