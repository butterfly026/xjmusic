// Copyright (c) 2017, XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.hub.resource.link_chord;

import io.xj.core.CoreModule;
import io.xj.core.access.impl.Access;
import io.xj.core.model.user_role.UserRoleType;
import io.xj.core.server.HttpResponseProvider;
import io.xj.core.dao.LinkChordDAO;
import io.xj.core.model.link_chord.LinkChord;



import com.google.inject.Guice;
import com.google.inject.Injector;

import javax.annotation.security.RolesAllowed;
import javax.jws.WebResult;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.container.ContainerRequestContext;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.Response;
import java.io.IOException;
import java.math.BigInteger;

/**
 LinkChord record
 */
@Path("link-chords/{id}")
public class LinkChordOneResource {
  private static final Injector injector = Guice.createInjector(new CoreModule());
  private final LinkChordDAO linkChordDAO = injector.getInstance(LinkChordDAO.class);
  private final HttpResponseProvider response = injector.getInstance(HttpResponseProvider.class);

  @PathParam("id")
  String id;

  /**
   Get one linkChord.

   @return application/json response.
   */
  @GET
  @WebResult
  @RolesAllowed(UserRoleType.USER)
  public Response readOne(@Context ContainerRequestContext crc) throws IOException {
    try {
      return response.readOne(
        LinkChord.KEY_ONE,
        linkChordDAO.readOne(
          Access.fromContext(crc),
          new BigInteger(id)));

    } catch (Exception e) {
      return response.failure(e);
    }
  }

}