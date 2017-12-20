// Copyright (c) 2017, XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.hub.resource.chain;

import io.xj.core.CoreModule;
import io.xj.core.access.impl.Access;
import io.xj.core.dao.ChainDAO;
import io.xj.core.model.chain.Chain;
import io.xj.core.model.chain.ChainWrapper;
import io.xj.core.model.user_role.UserRoleType;
import io.xj.core.server.HttpResponseProvider;

import com.google.inject.Guice;
import com.google.inject.Injector;

import javax.annotation.security.RolesAllowed;
import javax.jws.WebResult;
import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.container.ContainerRequestContext;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.io.IOException;
import java.math.BigInteger;
import java.util.Objects;

/**
 Chain record
 */
@Path("chains/{id}")
public class ChainOneResource {
  private static final Injector injector = Guice.createInjector(new CoreModule());
  private final ChainDAO chainDAO = injector.getInstance(ChainDAO.class);
  private final HttpResponseProvider response = injector.getInstance(HttpResponseProvider.class);

  @PathParam("id")
  String id;

  /**
   Get one chain.

   @return application/json response.
   */
  @GET
  @WebResult
  @RolesAllowed(UserRoleType.USER)
  public Response readOne(@Context ContainerRequestContext crc) throws IOException {
    if (Objects.isNull(id) || id.isEmpty())
      return response.notAcceptable("Chain id is required");

    try {
      return response.readOne(
        Chain.KEY_ONE,
        chainDAO.readOne(
          Access.fromContext(crc),
          new BigInteger(id)));

    } catch (Exception e) {
      return response.failure(e);
    }
  }

  /**
   Update one chain

   @param data with which to update Chain record.
   @return Response
   */
  @PUT
  @Consumes(MediaType.APPLICATION_JSON)
  @RolesAllowed(UserRoleType.ARTIST)
  public Response update(ChainWrapper data, @Context ContainerRequestContext crc) {
    try {
      chainDAO.update(Access.fromContext(crc), new BigInteger(id), data.getChain());
      return Response.accepted("{}").build();

    } catch (Exception e) {
      return response.failureToUpdate(e);
    }
  }

  /**
   Delete one chain
   <p>
   [#294] Eraseworker finds Links and Audio in deleted state and actually deletes the records, child entities and S3 objects
   Hub DELETE /chains/# is actually a state update to ERASE
   Hub cannot invoke chain destroy chainDAO method!

   @return Response
   */
  @DELETE
  @RolesAllowed(UserRoleType.ARTIST)
  public Response erase(@Context ContainerRequestContext crc) {
    try {
      chainDAO.erase(Access.fromContext(crc), new BigInteger(id));
      return Response.accepted("{}").build();

    } catch (Exception e) {
      return response.failure(e);
    }
  }

}