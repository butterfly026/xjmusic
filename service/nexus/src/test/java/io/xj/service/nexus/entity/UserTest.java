// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.service.nexus.entity;

import io.xj.lib.util.ValueException;
import io.xj.service.hub.entity.User;
import org.junit.Rule;
import org.junit.Test;
import org.junit.rules.ExpectedException;

public class UserTest {

  @Rule
  public ExpectedException failure = ExpectedException.none();

  @Test
  public void validate() throws Exception {
    new User()
      .setRoles("User,Artist")
      .setEmail("charneykaye@gmail.com")
      .setAvatarUrl("http://www.google.com/images/charneykaye.jpg")
      .setName("Charney Kaye")
      .validate();
  }

  @Test
  public void validate_withMinimalAttributes() throws Exception {
    new User()
      .setRoles("User,Artist")
      .validate();
  }

  @Test
  public void validate_failsWithoutRoles() throws Exception {
    failure.expect(ValueException.class);
    failure.expectMessage("User roles is required");

    new User()
      .validate();
  }

}