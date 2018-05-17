// Copyright (c) 2018, XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.core.model.chain_sequence;

import io.xj.core.exception.BusinessException;
import io.xj.core.model.entity.EntityWrapper;

/**
 Wrapper for use as POJO for decoding messages received by JAX-RS resources
 a.k.a. JSON input will be stored into an entity inside this object
 */
public class ChainSequenceWrapper extends EntityWrapper {

  // Chain
  private ChainSequence chainSequence;

  public ChainSequence getChainSequence() {
    return chainSequence;
  }

  public ChainSequenceWrapper setChainSequence(ChainSequence chainSequence) {
    this.chainSequence = chainSequence;
    return this;
  }

  /**
   Validate data.

   @throws BusinessException if invalid.
   */
  @Override
  public ChainSequence validate() throws BusinessException {
    if (null == chainSequence) {
      throw new BusinessException("Chain Sequence is required.");
    }
    chainSequence.validate();
    return chainSequence;
  }

}
