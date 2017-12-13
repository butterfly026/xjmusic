// Copyright (c) 2017, Outright Mental Inc. (http://outright.io) All Rights Reserved.
package io.xj.core.dub;

import io.xj.core.exception.BusinessException;

/**
 [#264] Link audio is compressed to MP3 and shipped to https://link.xj.io
 */
public interface ShipDub {

  /**
   perform delivery for the current link
   */
  void doWork() throws BusinessException;

}