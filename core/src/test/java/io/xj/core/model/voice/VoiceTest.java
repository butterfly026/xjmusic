// Copyright (c) 2018, XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.core.model.voice;

import io.xj.core.exception.CoreException;

import org.junit.Rule;
import org.junit.Test;
import org.junit.rules.ExpectedException;

import java.math.BigInteger;

public class VoiceTest {

  @Rule
  public ExpectedException failure = ExpectedException.none();

  @Test
  public void validate() throws Exception {
    new Voice()
      .setSequenceId(BigInteger.valueOf(251L))
      .setType("Harmonic")
      .setDescription("Mic Check One Two")
      .validate();
  }

  @Test
  public void validate_failsWithoutPatternID() throws Exception {
    failure.expect(CoreException.class);
    failure.expectMessage("Sequence ID is required");

    new Voice()
      .setType("Harmonic")
      .setDescription("Mic Check One Two")
      .validate();
  }

  @Test
  public void validate_failsWithoutType() throws Exception {
    failure.expect(CoreException.class);
    failure.expectMessage("Type is required");

    new Voice()
      .setSequenceId(BigInteger.valueOf(251L))
      .setDescription("Mic Check One Two")
      .validate();
  }

  @Test
  public void validate_failsWithInvalidType() throws Exception {
    failure.expect(CoreException.class);
    failure.expectMessage("'chimney' is not a valid type");

    new Voice()
      .setSequenceId(BigInteger.valueOf(251L))
      .setType("chimney")
      .setDescription("Mic Check One Two")
      .validate();
  }

  @Test
  public void validate_failsWithoutDescription() throws Exception {
    failure.expect(CoreException.class);
    failure.expectMessage("Description is required");

    new Voice()
      .setSequenceId(BigInteger.valueOf(251L))
      .setType("Harmonic")
      .validate();
  }

}
