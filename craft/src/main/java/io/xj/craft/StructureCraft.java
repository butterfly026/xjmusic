// Copyright (c) 2017, XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.craft;

import io.xj.core.exception.BusinessException;

/**
 Structure craft for the current link includes rhythm and detail
 [#214] If a Chain has Patterns associated with it directly, prefer those choices to any in the Library
 */
public interface StructureCraft {

  /**
   perform craft for the current link
   */
  void doWork() throws BusinessException;

}