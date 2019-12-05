// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.core.cache.audio.impl;

import java.util.concurrent.atomic.AtomicInteger;

public enum ItemNumber {
  ONE;

  private static final Integer NEXT_DELTA = 1;
  private final AtomicInteger atomicInteger;

  ItemNumber() {
    atomicInteger = new AtomicInteger();
  }

  private Integer addAndGet() {
    return atomicInteger.addAndGet(NEXT_DELTA);
  }

  public static Integer next() {
    return ONE.addAndGet();
  }

}
