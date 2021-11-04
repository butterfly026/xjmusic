// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.

package io.xj.hub.api;

import io.xj.hub.ProgramConfig;
import io.xj.hub.tables.pojos.Program;
import io.xj.lib.util.ValueException;
import org.junit.Test;

import static org.junit.Assert.*;

/**
 [#177355683] Artist saves Program config, validate & combine with defaults.
 */
public class ProgramConfigTest {

  @Test
  public void setFromProgram() throws ValueException {
    var program = new Program();
    program.setConfig("doPatternRestartOnChord = true");

    var subject = new ProgramConfig(program);

    assertTrue( subject.doPatternRestartOnChord());
  }

  @Test
  public void setFromDefaults() throws ValueException {
    var subject = new ProgramConfig(ProgramConfig.DEFAULT);

    assertFalse( subject.doPatternRestartOnChord());
  }

  @Test
  public void defaultsToString() throws ValueException {
    var subject = new ProgramConfig(ProgramConfig.DEFAULT);

    assertEquals(ProgramConfig.DEFAULT, subject.toString());
  }

}