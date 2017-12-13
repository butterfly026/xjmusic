// Copyright (c) 2017, Outright Mental Inc. (http://outright.io) All Rights Reserved.
package io.xj.hub.resource.chain_pattern;

import io.xj.core.CoreModule;
import io.xj.core.access.impl.Access;
import io.xj.core.server.HttpResponseProvider;
import io.xj.core.dao.ChainPatternDAO;
import io.xj.core.model.chain_pattern.ChainPattern;
import io.xj.core.model.role.Role;

import org.jooq.types.ULong;

import com.google.inject.Guice;
import com.google.inject.Injector;

import javax.annotation.security.RolesAllowed;
import javax.jws.WebResult;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.container.ContainerRequestContext;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.Response;
import java.io.IOException;

/**
 Chain Pattern record
 */
@Path("chain-patterns/{id}")
public class ChainPatternRecordResource {
  private static final Injector injector = Guice.createInjector(new CoreModule());
  private final ChainPatternDAO DAO = injector.getInstance(ChainPatternDAO.class);
  private final HttpResponseProvider response = injector.getInstance(HttpResponseProvider.class);

  @PathParam("id")
  String id;

  /**
   Get one ChainPattern by id

   @return application/json response.
   */
  @GET
  @WebResult
  @RolesAllowed({Role.USER})
  public Response readOne(@Context ContainerRequestContext crc) throws IOException {
    try {
      return response.readOne(
        ChainPattern.KEY_ONE,
        DAO.readOne(
          Access.fromContext(crc),
          ULong.valueOf(id)));

    } catch (Exception e) {
      return response.failure(e);
    }
  }

  /**
   Delete one ChainPattern

   @return application/json response.
   */
  @DELETE
  @RolesAllowed({Role.ARTIST,Role.ENGINEER,Role.ADMIN})
  public Response delete(@Context ContainerRequestContext crc) {
    try {
      DAO.delete(Access.fromContext(crc), ULong.valueOf(id));
      return Response.accepted("{}").build();
    } catch (Exception e) {
      return response.failure(e);
    }
  }

}