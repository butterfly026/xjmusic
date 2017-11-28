// Copyright (c) 2017, Outright Mental Inc. (http://outright.io) All Rights Reserved.
package io.xj.core.app.resource;

import io.xj.core.CoreModule;
import io.xj.core.app.config.Exposure;
import io.xj.core.app.stats.StatsProvider;
import io.xj.core.model.role.Role;
import io.xj.core.transport.JSON;

import com.google.inject.Guice;
import com.google.inject.Injector;

import javax.annotation.security.PermitAll;
import javax.annotation.security.RolesAllowed;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

/**
 Get platform stats
 */
@Path("stats")
public class StatsResource {

  private static final Injector injector = Guice.createInjector(new CoreModule());
  private final StatsProvider statsProvider = injector.getInstance(StatsProvider.class);

  /**
   Method handling HTTP GET requests. The returned object will be sent
   to the client as "text/plain" media type.

   @return String that will be returned as a text/plain response.
   */
  @GET
  @Context
  @PermitAll
  public Response status() {
    return Response
      .accepted(JSON.wrap(Exposure.KEY_STATUS, statsProvider.getJSON()).toString())
      .type(MediaType.APPLICATION_JSON)
      .build();
  }
}