// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.service.hub;

import com.google.inject.Injector;
import io.xj.core.app.AppResource;
import io.xj.core.dao.ProgramVoiceDAO;
import io.xj.core.model.UserRoleType;
import io.xj.core.payload.MediaType;
import io.xj.core.payload.Payload;

import javax.annotation.security.RolesAllowed;
import javax.inject.Inject;
import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.QueryParam;
import javax.ws.rs.container.ContainerRequestContext;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.Response;

/**
 ProgramVoice endpoint
 */
@Path("program-voices")
public class ProgramVoiceEndpoint extends AppResource {
  private ProgramVoiceDAO dao;

  /**
   The constructor's @javax.inject.Inject binding is for HK2, Jersey's injection system,
   which injects the inner com.google.inject.Injector for Guice-bound classes
   */
  @Inject
  public ProgramVoiceEndpoint(
    Injector injector
  ) {
    super(injector);
    dao = injector.getInstance(ProgramVoiceDAO.class);
  }

  /**
   Get Bindings in one programVoice.

   @return application/json response.
   */
  @GET
  @RolesAllowed({UserRoleType.ENGINEER})
  public Response readAll(@Context ContainerRequestContext crc, @QueryParam("programVoiceId") String programVoiceId) {
    return readMany(crc, dao(), programVoiceId);
  }

  /**
   Create new programVoice binding

   @param payload with which to of ProgramVoice Binding
   @return Response
   */
  @POST
  @Consumes(MediaType.APPLICATION_JSON_API)
  @RolesAllowed({UserRoleType.ENGINEER})
  public Response create(Payload payload, @Context ContainerRequestContext crc) {
    return create(crc, dao(), payload);
  }

  /**
   Get one ProgramVoice by id

   @return application/json response.
   */
  @GET
  @Path("{id}")
  @RolesAllowed({UserRoleType.ENGINEER})
  public Response readOne(@Context ContainerRequestContext crc, @PathParam("id") String id) {
    return readOne(crc, dao(), id);
  }

  /**
   Delete one ProgramVoice by programVoiceId and bindingId

   @return application/json response.
   */
  @DELETE
  @Path("{id}")
  @RolesAllowed({UserRoleType.ENGINEER})
  public Response delete(@Context ContainerRequestContext crc, @PathParam("id") String id) {
    return delete(crc, dao(), id);
  }

  /**
   Get DAO of injector

   @return DAO
   */
  private ProgramVoiceDAO dao() {
    return dao;
  }

}
