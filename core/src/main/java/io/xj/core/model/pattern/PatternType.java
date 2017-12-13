// Copyright (c) 2017, Outright Mental Inc. (http://outright.io) All Rights Reserved.
package io.xj.core.model.pattern;

import io.xj.core.exception.BusinessException;
import io.xj.core.transport.CSV;
import io.xj.core.util.Text;

import com.google.common.collect.ImmutableList;

import java.util.Objects;

public enum PatternType {
  Macro,
  Main,
  Rhythm,
  Detail;

  /**
   String Values

   @return ImmutableList of string values
   */
  public static ImmutableList<String> stringValues() {
    ImmutableList.Builder<String> valuesBuilder = ImmutableList.builder();
    for (PatternType value : values()) {
      valuesBuilder.add(value.toString());
    }
    return valuesBuilder.build();
  }

  /**
   cast string to enum

   @param value to cast to enum
   @return enum
   @throws BusinessException on failure
   */
  public static PatternType validate(String value) throws BusinessException {
    if (Objects.isNull(value))
      throw new BusinessException("Type is required");

    try {
      return valueOf(Text.toProperSlug(value));
    } catch (Exception e) {
      throw new BusinessException("'" + value + "' is not a valid type (" + CSV.joinEnum(values()) + ").", e);
    }
  }

}