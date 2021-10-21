// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.

package io.xj.lib;

import java.util.UUID;

public class Superwidget {
  private UUID id;
  private String name;

  public UUID getId() {
    return id;
  }

  public Superwidget setId(UUID id) {
    this.id = id;
    return this;
  }

  public String getName() {
    return name;
  }

  public Superwidget setName(String name) {
    this.name = name;
    return this;
  }
}
