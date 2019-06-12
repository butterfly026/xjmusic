// Copyright (c) 2018, XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.hub.resource.program;

import io.xj.core.access.impl.Access;
import io.xj.core.dao.ProgramDAO;
import io.xj.core.model.payload.MediaType;
import io.xj.core.model.payload.Payload;
import io.xj.core.model.user.role.UserRoleType;
import io.xj.hub.HubResource;

import javax.annotation.security.RolesAllowed;
import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.PATCH;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.container.ContainerRequestContext;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.Response;
import java.math.BigInteger;

/**
 Program record
 */
@Path("programs/{id}")
// TODO don't necessarily include all sub-entities--- only do so on request, and probably not at all for the index resources
public class ProgramOneResource extends HubResource {

  @PathParam("id")
  String id;

  /**
   Get one program.

   @return application/json response.
   */
  @GET
  @RolesAllowed(UserRoleType.USER)
  public Response readOne(@Context ContainerRequestContext crc) {
    return readOne(crc, dao(), id);
  }

  /**
   Update one program

   @param payload with which to update Program record.
   @return Response
   */
  @PATCH
  @Consumes(MediaType.APPLICATION_JSON_API)
  @RolesAllowed(UserRoleType.ARTIST)
  public Response update(Payload payload, @Context ContainerRequestContext crc) {
    return update(crc, dao(), id, payload);
  }

  /**
   Delete one program

   @return Response
   */
  @DELETE
  @RolesAllowed(UserRoleType.ADMIN)
  public Response erase(@Context ContainerRequestContext crc) {
    try {
      dao().erase(Access.fromContext(crc), new BigInteger(id));
      return response.noContent();

    } catch (Exception e) {
      return response.failure(e);
    }
  }

  /**
   Get DAO from injector

   @return DAO
   */
  private ProgramDAO dao() {
    return injector.getInstance(ProgramDAO.class);
  }
}
