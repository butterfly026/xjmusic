// Copyright (c) 2018, XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.core.model.phase;

import io.xj.core.exception.BusinessException;
import io.xj.core.transport.CSV;
import io.xj.core.util.Text;

import java.util.Objects;

public enum PhaseState {
  Draft,
  Published,
  Erase;

  /**
   cast string to enum
   <p>
   FUTURE: Pattern can be created in draft state, then published
   </p>

   @param value to cast to enum
   @return config state enum
   @throws BusinessException on failure
   */
  public static PhaseState validate(String value) throws BusinessException {
    if (Objects.isNull(value))
      return Published;

    try {
      return valueOf(Text.toProperSlug(value));
    } catch (Exception ignored) {
      throw new BusinessException("'" + value + "' is not a valid state (" + CSV.joinEnum(PhaseState.values()) + ").");
    }
  }
}
