// Copyright (c) 2017, Outright Mental Inc. (http://outright.io) All Rights Reserved.
package io.xj.core.model.user_access_token;

import io.xj.core.exception.BusinessException;
import io.xj.core.model.Entity;

import java.math.BigInteger;

public class UserAccessToken extends Entity {

  private BigInteger userAuthId;
  private BigInteger userId;

  /**
   Validate data.

   @throws BusinessException if invalid.
   */
  @Override
  public void validate() throws BusinessException {

  }

  public BigInteger getUserAuthId() {
    return userAuthId;
  }

  public void setUserAuthId(BigInteger userAuthId) {
    this.userAuthId = userAuthId;
  }

  public BigInteger getUserId() {
    return userId;
  }

  public void setUserId(BigInteger userId) {
    this.userId = userId;
  }
}
