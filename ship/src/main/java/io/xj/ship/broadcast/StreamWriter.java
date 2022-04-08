// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.

package io.xj.ship.broadcast;

import io.xj.ship.ShipException;

/**
 Ship service can be used to write N seconds to local .WAV file https://www.pivotaltracker.com/story/show/181082015
 */
public interface StreamWriter {

  /**
   Publish a media segment to the output

   @param samples of audio to append
   */
  double[][] append(double[][] samples) throws ShipException;

  /**
   Close the writer and release resources
   */
  void close();

  /**
   @return true if the writer is enabled and done writing
   */
  boolean enabledAndDoneWithOutput();
}