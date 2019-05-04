// Copyright (c) 2018, XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.core.resource;

import com.google.inject.Guice;
import com.google.inject.Injector;
import io.xj.core.CoreModule;
import io.xj.core.config.Exposure;
import io.xj.core.transport.GsonProvider;
import io.xj.core.transport.StatsProvider;

import javax.annotation.security.PermitAll;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

/**
 This resource (along with everything in this `core/resource` package)
 is imported by all JAX-RS resources (e.g. in the Hub or Worker app),
 and results in an /stats platform stats route made available in all apps.
 <p>
 Due to Jersey JAX-RS implementing an HK2 injection vector,
 we cannot use Guice injection at the class level.
 That's why it appears inside this class as a manual inject.getInstance(...for each class...)
 <p>
 FUTURE: determine a more testable injection vector
 */
@Path("stats")
public class StatsResource {
  private static final Injector injector = Guice.createInjector(new CoreModule());
  private final StatsProvider statsProvider = injector.getInstance(StatsProvider.class);
  private final GsonProvider gsonProvider = injector.getInstance(GsonProvider.class);

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
      .accepted(gsonProvider.wrap(Exposure.STATS, statsProvider.getJSON()))
      .type(MediaType.APPLICATION_JSON)
      .build();
  }
}
