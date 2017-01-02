// Copyright (c) 2016, Outright Mental Inc. (http://outright.io) All Rights Reserved.
package io.outright.xj.core.app.server;

import org.glassfish.grizzly.http.server.HttpServer;
import org.glassfish.jersey.server.ResourceConfig;

import java.net.URI;

public interface HttpServerProvider {
  void configure(URI uri, ResourceConfig config);
  HttpServer get();
}