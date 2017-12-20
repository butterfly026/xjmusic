// Copyright (c) 2017, Outright Mental Inc. (http://outright.io) All Rights Reserved.
package io.xj.core.model.user_role;

import io.xj.core.exception.BusinessException;
import io.xj.core.model.Entity;

import java.math.BigInteger;
import java.util.Objects;

/**
 POJO for persisting data in memory while performing business logic.
 <p>
 Business logic ought to be performed beginning with an instance of this object,
 to implement common methods.
 <p>
 NOTE: There can only be ONE of any getter/setter (with the same # of input params)
 */
public class UserRole extends Entity {
  private UserRoleType type;
  private BigInteger userId;
  private String _type; // to hold value before validation

  @Override
  public void validate() throws BusinessException {
    // throws its own BusinessException on failure
    type = UserRoleType.validate(_type);

    if (Objects.isNull(type)) {
      throw new BusinessException("type is required.");
    }
  }

  public void setTypeEnum(UserRoleType type) {
    this.type = type;
  }

  public void setType(String value) {
    _type = value;
  }

  public UserRoleType getType() {
    return type;
  }

  public BigInteger getUserId() {
    return userId;
  }

  public void setUserId(BigInteger userId) {
    this.userId = userId;
  }
}