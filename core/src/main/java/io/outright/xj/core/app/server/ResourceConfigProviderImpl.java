// Copyright (c) 2016, Outright Mental Inc. (http://outright.io) All Rights Reserved.
package io.outright.xj.core.app.server;

import org.glassfish.jersey.server.ResourceConfig;

public class ResourceConfigProviderImpl implements ResourceConfigProvider {
  @Override
  public ResourceConfig get(final String... packages) {
    final ResourceConfig resourceConfig = new ResourceConfig().packages(packages);

    return resourceConfig;
  }
}
