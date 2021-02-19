// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.lib.app;

import com.google.inject.Inject;

import javax.annotation.security.PermitAll;
import javax.inject.Singleton;
import javax.ws.rs.GET;
import javax.ws.rs.Path;

/**
 Health resource.
 */
@Path("api/1/-/health")
@Singleton
public class TestAppHealthEndpoint {

  @Inject
  public TestAppHealthEndpoint() {
  }

  @GET
  @PermitAll
  public String index() {
    return "ok";
  }
}
