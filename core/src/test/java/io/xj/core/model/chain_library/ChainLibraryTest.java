// Copyright (c) 2018, XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.core.model.chain_library;

import io.xj.core.exception.CoreException;

import org.junit.Rule;
import org.junit.Test;
import org.junit.rules.ExpectedException;

import java.math.BigInteger;

public class ChainLibraryTest {
  @Rule
  public ExpectedException failure = ExpectedException.none();

  @Test
  public void validate() throws Exception {
    new ChainLibrary()
      .setLibraryId(BigInteger.valueOf(125434L))
      .setChainId(BigInteger.valueOf(125434L))
      .validate();
  }

  @Test
  public void validate_failsWithoutChainId() throws Exception {
    failure.expect(CoreException.class);
    failure.expectMessage("Chain ID is required");

    new ChainLibrary()
      .setLibraryId(BigInteger.valueOf(125434L))
      .validate();
  }

  @Test
  public void validate_failsWithoutLibraryId() throws Exception {
    failure.expect(CoreException.class);
    failure.expectMessage("Library ID is required");

    new ChainLibrary()
      .setChainId(BigInteger.valueOf(125434L))
      .validate();
  }

}
