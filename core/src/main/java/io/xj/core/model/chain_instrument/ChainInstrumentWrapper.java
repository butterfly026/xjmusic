// Copyright (c) 2017, Outright Mental Inc. (http://outright.io) All Rights Reserved.
package io.xj.core.model.chain_instrument;

import io.xj.core.app.exception.BusinessException;
import io.xj.core.model.EntityWrapper;

/**
 Wrapper for use as POJO for decoding messages received by JAX-RS resources
 a.k.a. JSON input will be stored into an entity inside this object
 */
public class ChainInstrumentWrapper extends EntityWrapper {

  // Chain
  private ChainInstrument chainInstrument;

  public ChainInstrument getChainInstrument() {
    return chainInstrument;
  }

  public ChainInstrumentWrapper setChainInstrument(ChainInstrument chainInstrument) {
    this.chainInstrument = chainInstrument;
    return this;
  }

  /**
   Validate data.

   @throws BusinessException if invalid.
   */
  public ChainInstrument validate() throws BusinessException {
    if (this.chainInstrument == null) {
      throw new BusinessException("Chain Instrument is required.");
    }
    this.chainInstrument.validate();
    return this.chainInstrument;
  }

}