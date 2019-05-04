//  Copyright (c) 2019, XJ Music Inc. (https://xj.io) All Rights Reserved.

package io.xj.craft;

import io.xj.core.fabricator.Fabricator;
import io.xj.craft.exception.CraftException;

public class CraftImpl {
  private Fabricator fabricator;

  /**
   Create a new CraftException prefixed with a segment id

   @param message to include in exception
   @return CraftException to throw
   */
  public CraftException exception(String message) {
    return new CraftException(formatLog(message));
  }

  /**
   Create a new CraftException prefixed with a segment id, including sub-exception

   @param message to include in exception
   @param e       Exception to include in exception
   @return CraftException to throw
   */
  public CraftException exception(String message, Exception e) {
    return new CraftException(formatLog(message), e);
  }

  /**
   Format a message with the segmentId as prefix

   @param message to format
   @return formatted message with segmentId as prefix
   */
  public String formatLog(String message) {
    return String.format("[segId=%s] %s", getFabricator().getSegment().getId(), message);
  }


  /**
   Get the fabricator

   @return Fabricator
   */
  public Fabricator getFabricator() {
    return fabricator;
  }

  /**
   YES i know this is a final method
   in order to set the fabricator gia Guice injection during construction of things that extend CraftImpl

   @param fabricator to set, once per instance
   */
  public final void setFabricator(Fabricator fabricator) {
    this.fabricator = fabricator;
  }
}
