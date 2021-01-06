package io.xj.service.hub.dao;

import com.google.common.base.Strings;
import com.typesafe.config.Config;
import com.typesafe.config.ConfigException;
import com.typesafe.config.ConfigFactory;
import io.xj.Program;
import io.xj.lib.util.ValueException;

/**
 Parse a TypeSafe `config` value for a Program's configuration, overriding values from top-level default.conf--
 e.g.
 if the `config` value contains only `previewLengthMaxHours = 8`
 */
public class ProgramConfig {
  private final boolean patternRestartOnChord;
  private final boolean transpose;


  /**
   Instantiate a Program configuration from a string of typesafe config.
   Said string will be embedded in a `program{...}` block such that
   provided simple Key=Value pairs will be understood as members of `program`
   e.g. will override values from the `program{...}` block of the top-level **default.conf**

   @param program to get Config from
   */
  public ProgramConfig(Program program, Config defaultConfig) throws ValueException {
    try {
      Config config = Strings.isNullOrEmpty(program.getConfig()) ?
        defaultConfig :
        ConfigFactory.parseString(String.format("program {\n%s\n}", program.getConfig()))
          .withFallback(defaultConfig);
      patternRestartOnChord = config.getBoolean("program.doPatternRestartOnChord");
      transpose = config.getBoolean("program.doTranspose");

    } catch (ConfigException e) {
      throw new ValueException(e.getMessage());
    }
  }

  /**
   @return # of Output Channels
   */
  public boolean doPatternRestartOnChord() {
    return patternRestartOnChord;
  }

  /**
   @return whether to do transposition for this program
   */
  public boolean doTranspose() {
    return transpose;
  }
}