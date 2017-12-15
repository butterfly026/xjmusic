// Copyright (c) 2017, XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.core.access.impl;

import io.xj.core.access.AccessLogFilterProvider;
import io.xj.core.app.App;
import io.xj.core.config.Config;
import io.xj.core.logger.FileLogger;
import org.glassfish.jersey.filter.LoggingFilter;
import org.glassfish.jersey.server.ResourceConfig;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;

public class AccessLogFilterProviderImpl implements AccessLogFilterProvider {
  private static LoggingFilter instance;
  private final Logger log = LoggerFactory.getLogger(AccessLogFilterProviderImpl.class);
  private final String pathToWriteAccessLog = Config.logAccessFilename();
  private final Integer maxSizeEntitiesInAccessLog = Config.logAccessEntitiesMaxsize();
  private final Boolean showEntitiesInAccessLog = Config.logAccessEntitiesAll();

  @Override
  public void registerTo(ResourceConfig resourceConfig) {
    try {
      if (maxSizeEntitiesInAccessLog > 0) {
        setup(pathToWriteAccessLog, maxSizeEntitiesInAccessLog);
      } else {
        setup(pathToWriteAccessLog, showEntitiesInAccessLog);
      }
      resourceConfig.register(instance);
      log.info("Writing access log to {}", pathToWriteAccessLog);
    } catch (IOException e) {
      log.warn("Failed to registerTo access log writer:" + e.toString());
    }
  }

  private void setup(String path, int maxEntitySize) throws IOException {
    instance = new LoggingFilter(FileLogger.getLogger(App.class, path), maxEntitySize);
  }

  private void setup(String path, boolean printEntity) throws IOException {
    instance = new LoggingFilter(FileLogger.getLogger(App.class, path), printEntity);
  }
}
