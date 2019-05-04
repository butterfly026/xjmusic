// Copyright (c) 2018, XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.core.model.library;

import io.xj.core.exception.CoreException;

import org.junit.Rule;
import org.junit.Test;
import org.junit.rules.ExpectedException;

import java.math.BigInteger;

public class LibraryTest {

  @Rule
  public ExpectedException failure = ExpectedException.none();

  @Test
  public void validate() throws Exception {
    new Library()
      .setAccountId(BigInteger.valueOf(562L))
      .setName("Mic Check One Two")
      .validate();
  }

  @Test
  public void validate_failsWithoutAccountID() throws Exception {
    failure.expect(CoreException.class);
    failure.expectMessage("Account ID is required");

    new Library()
      .setName("Mic Check One Two")
      .validate();
  }

  @Test
  public void validate_failsWithoutName() throws Exception {
    failure.expect(CoreException.class);
    failure.expectMessage("Name is required");

    new Library()
      .setAccountId(BigInteger.valueOf(562L))
      .validate();
  }

}
