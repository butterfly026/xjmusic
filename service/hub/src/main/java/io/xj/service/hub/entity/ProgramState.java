// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.service.hub.entity;

import io.xj.lib.util.CSV;
import io.xj.lib.util.Text;
import io.xj.lib.util.ValueException;

import java.util.List;
import java.util.Objects;

public enum ProgramState {
  Draft,
  Published;

  /**
   String Values

   @return ImmutableList of string values
   */
  public static List<String> stringValues() {
    return Text.toStrings(values());
  }

  /**
   cast string to enum
   <p>
   FUTURE: Sequence can be createdin draft state, then published
   </p>

   @param value to cast to enum
   @return config state enum
   @throws ValueException on failure
   */
  public static ProgramState validate(String value) throws ValueException {
    if (Objects.isNull(value))
      return Published;

    try {
      return valueOf(Text.toProperSlug(value));
    } catch (Exception ignored) {
      throw new ValueException("'" + value + "' is not a valid state (" + CSV.joinEnum(ProgramState.values()) + ").");
    }
  }
}