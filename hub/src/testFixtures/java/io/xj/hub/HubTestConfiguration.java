//  Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.

package io.xj.hub;import com.typesafe.config.Config;
import com.typesafe.config.ConfigFactory;
import io.xj.lib.app.AppConfiguration;

/**
 App test configuration utility
 */
public class HubTestConfiguration {

  /**
   Get default configuration for tests

   @return default configuration for tests
   */
  public static Config getDefault() {
    return AppConfiguration.getDefault().resolve();
  }

}