// Copyright (c) 2018, XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.core.model.pattern_event;

/**
 Wrapper for use as POJO for decoding messages received by JAX-RS resources
 a.k.a. JSON input will be stored into an entity inside this object
 */
public class PatternEventWrapper {
  private PatternEvent patternEvent;

  public PatternEvent getPatternEvent() {
    return patternEvent;
  }

  public PatternEventWrapper setPatternEvent(PatternEvent patternEvent) {
    this.patternEvent = patternEvent;
    return this;
  }
}
