// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.

package io.xj.lib.entity.common;

import com.google.common.base.Strings;
import com.google.common.collect.Maps;
import com.typesafe.config.Config;
import com.typesafe.config.ConfigException;
import com.typesafe.config.ConfigFactory;
import io.xj.api.Instrument;
import io.xj.lib.util.Text;
import io.xj.lib.util.ValueException;

import java.util.Map;

/**
 Parse a TypeSafe `config` value for a Instrument's configuration, overriding values from top-level default.conf--
 e.g.
 if the `config` value contains only `previewLengthMaxHours = 8`
 */
public class InstrumentConfig {
  private static final String KEY_PREFIX = "instrument.";

  private final Boolean isTonal;
  private final String KEY_IS_TONAL = "isTonal";

  private final Boolean isMultiphonic;
  private final String KEY_IS_MULTIPHONIC = "isMultiphonic";

  /**
   Instantiate a Instrument configuration from a string of typesafe config.
   Said string will be embedded in a `instrument{...}` block such that
   provided simple Key=Value pairs will be understood as members of `instrument`
   e.g. will override values from the `instrument{...}` block of the top-level **default.conf**
   */
  public InstrumentConfig(String configText, Config defaultConfig) throws ValueException {
    try {
      Config config = Strings.isNullOrEmpty(configText) ?
        defaultConfig :
        ConfigFactory.parseString(String.format("instrument {\n%s\n}", configText))
          .withFallback(defaultConfig);
      isTonal = getOptionalBoolean(config, prefixed(KEY_IS_TONAL));
      isMultiphonic = getOptionalBoolean(config, prefixed(KEY_IS_MULTIPHONIC));

    } catch (ConfigException e) {
      throw new ValueException(e.getMessage());
    }
  }

  /**
   Instantiate a Instrument configuration from a string of typesafe config.
   Said string will be embedded in a `instrument{...}` block such that
   provided simple Key=Value pairs will be understood as members of `instrument`
   e.g. will override values from the `instrument{...}` block of the top-level **default.conf**

   @param instrument to get Config from
   */
  public InstrumentConfig(Instrument instrument, Config defaultConfig) throws ValueException {
    try {
      Config config = Strings.isNullOrEmpty(instrument.getConfig()) ?
        defaultConfig :
        ConfigFactory.parseString(String.format("instrument {\n%s\n}", instrument.getConfig()))
          .withFallback(defaultConfig);
      isTonal = getOptionalBoolean(config, prefixed(KEY_IS_TONAL));
      isMultiphonic = getOptionalBoolean(config, prefixed(KEY_IS_MULTIPHONIC));

    } catch (ConfigException e) {
      throw new ValueException(e.getMessage());
    }
  }

  /**
   Get a instrument config from only the default config

   @param config from which to get instrument config
   @throws ValueException on failure
   */
  public InstrumentConfig(Config config) throws ValueException {
    this("", config);
  }

  /**
   If a boolean value is present in the config, return it, otherwise false

   @param config to search for value at key
   @param key    at which to search
   @return value if present, else false
   */
  private Boolean getOptionalBoolean(Config config, String key) {
    if (!config.hasPath(key)) return false;
    return config.getBoolean(key);
  }

  /**
   Instrument-prefixed version of a key

   @param key to prefix
   @return instrument-prefixed key
   */
  private String prefixed(String key) {
    return String.format("%s%s", KEY_PREFIX, key);
  }

  @SuppressWarnings("DuplicatedCode")
  @Override
  public String toString() {
    Map<String, String> config = Maps.newHashMap();
    config.put(KEY_IS_TONAL, isTonal.toString());
    config.put(KEY_IS_MULTIPHONIC, isMultiphonic.toString());
    return Text.formatMultiline(config.entrySet().stream()
      .sorted(Map.Entry.comparingByKey())
      .map(pair -> String.format("%s = %s", pair.getKey(), pair.getValue()))
      .toArray());
  }

  /**
   @return True if multiphonic
   */
  public Boolean isMultiphonic() {
    return isMultiphonic;
  }

  /**
   @return true if tonal
   */
  public Boolean isTonal() {
    return isTonal;
  }
}