//  Copyright (c) 2020, XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.core.app;

import io.xj.core.payload.Payload;

/**
 App heartbeat pulse
 */
@FunctionalInterface
public interface Heartbeat {

  /**
   Do heartbeat pulse

   @return payload object containing report data
   @throws Exception if unable to pulse heart
   */
  Payload pulse() throws Exception;

}
