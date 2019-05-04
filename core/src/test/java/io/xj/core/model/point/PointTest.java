// Copyright (c) 2018, XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.core.model.point;

import io.xj.core.exception.CoreException;

import org.junit.Rule;
import org.junit.Test;
import org.junit.rules.ExpectedException;

import java.math.BigInteger;

public class PointTest {

  @Rule
  public ExpectedException failure = ExpectedException.none();

  @Test
  public void validate() throws Exception {
    new Point()
      .setMorphId(BigInteger.valueOf(457832L))
      .setPatternEventId(BigInteger.valueOf(76943L))
      .setPosition(1.25)
      .setNote("F")
      .setDuration(0.74)
      .validate();
  }

  @Test
  public void validate_failsWithoutMorphID() throws Exception {
    failure.expect(CoreException.class);
    failure.expectMessage("Morph ID is required");

    new Point()
      .setPatternEventId(BigInteger.valueOf(76943L))
      .setPosition(1.25)
      .setNote("F")
      .setDuration(0.74)
      .validate();
  }

  @Test
  public void validate_failsWithoutPatternEventID() throws Exception {
    failure.expect(CoreException.class);
    failure.expectMessage("PatternEvent ID is required");

    new Point()
      .setMorphId(BigInteger.valueOf(457832L))
      .setPosition(1.25)
      .setNote("F")
      .setDuration(0.74)
      .validate();
  }

  @Test
  public void validate_failsWithoutPosition() throws Exception {
    failure.expect(CoreException.class);
    failure.expectMessage("Position is required");

    new Point()
      .setMorphId(BigInteger.valueOf(457832L))
      .setPatternEventId(BigInteger.valueOf(76943L))
      .setNote("F")
      .setDuration(0.74)
      .validate();
  }

  @Test
  public void validate_failsWithoutDuration() throws Exception {
    failure.expect(CoreException.class);
    failure.expectMessage("Duration is required");

    new Point()
      .setMorphId(BigInteger.valueOf(457832L))
      .setPatternEventId(BigInteger.valueOf(76943L))
      .setPosition(1.25)
      .setNote("F")
      .validate();
  }

  @Test
  public void validate_failsWithoutNote() throws Exception {
    failure.expect(CoreException.class);
    failure.expectMessage("Note is required");

    new Point()
      .setMorphId(BigInteger.valueOf(457832L))
      .setPatternEventId(BigInteger.valueOf(76943L))
      .setPosition(1.25)
      .setDuration(0.74)
      .validate();
  }


}
