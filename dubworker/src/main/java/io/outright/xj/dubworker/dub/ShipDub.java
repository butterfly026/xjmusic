// Copyright (c) 2017, Outright Mental Inc. (http://outright.io) All Rights Reserved.
package io.outright.xj.dubworker.dub;

import io.outright.xj.core.app.exception.BusinessException;

/**
 [#264] Link audio is compressed to MP3 and shipped to https://link.xj.outright.io
 */
public interface ShipDub {

  /**
   perform delivery for the current link
   */
  void doWork() throws BusinessException;

}
