// Copyright (c) 2018, XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.core.model.account;

import io.xj.core.exception.CoreException;
import io.xj.core.model.entity.impl.EntityImpl;

import java.math.BigInteger;
import java.util.Objects;

/**
 POJO for persisting data in memory while performing business logic,
 or decoding messages received by JAX-RS resources.
 a.k.a. JSON input will be stored into an instance of this object
 <p>
 Business logic ought to be performed beginning with an instance of this object,
 to implement common methods.
 <p>
 NOTE: There can only be ONE of any getter/setter (with the same # of input params)
 */
public class Account extends EntityImpl {

  /**
   For use in maps.
   */
  public static final String KEY_ONE = "account";
  public static final String KEY_MANY = "accounts";
  // Name
  private String name;

  public String getName() {
    return name;
  }

  public Account setName(String name) {
    this.name = name;
    return this;
  }

  @Override
  public BigInteger getParentId() {
    return new BigInteger(""); // has no parent!
  }

  @Override
  public void validate() throws CoreException {
    if (Objects.isNull(name)|| name.isEmpty()) {
      throw new CoreException("Account name is required.");
    }
  }

}
