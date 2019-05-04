// Copyright (c) 2018, XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.hub.resource.config;

import io.xj.core.config.API;
import io.xj.core.config.Exposure;
import io.xj.core.exception.CoreException;
import io.xj.core.transport.GsonProvider;
import io.xj.hub.HubResource;

import javax.annotation.security.PermitAll;
import javax.jws.WebResult;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.container.ContainerRequestContext;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

/**
 Current platform configuration
 */
@Path("config")
public class ConfigResource extends HubResource {

  /**
   Get current platform configuration (PUBLIC)

   @return application/json response.
   */
  @GET
  @WebResult
  @PermitAll
  public static Response getConfig(@Context ContainerRequestContext crc) throws CoreException {
    return Response
      .accepted(gsonProvider.wrap(Exposure.CONFIG, API.getConfig()))
      .type(MediaType.APPLICATION_JSON)
      .build();
  }
}
