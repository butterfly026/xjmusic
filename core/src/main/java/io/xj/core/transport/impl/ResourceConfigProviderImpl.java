// Copyright (c) 2018, XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.core.transport.impl;

import io.xj.core.transport.ResourceConfigProvider;

import com.fasterxml.jackson.jaxrs.json.JacksonJsonProvider;
import org.glassfish.jersey.server.ResourceConfig;

public class ResourceConfigProviderImpl implements ResourceConfigProvider {
  @Override
  public ResourceConfig get(String... packages) {
    ResourceConfig resourceConfig = new ResourceConfig().packages(packages);
    resourceConfig.register(JacksonJsonProvider.class);

    return resourceConfig;
  }
}