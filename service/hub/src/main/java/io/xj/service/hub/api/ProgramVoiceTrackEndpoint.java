// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.service.hub.api;

import com.google.inject.Inject;
import com.typesafe.config.Config;
import io.xj.lib.jsonapi.HttpResponseProvider;
import io.xj.lib.jsonapi.MediaType;
import io.xj.lib.jsonapi.Payload;
import io.xj.lib.jsonapi.PayloadFactory;
import io.xj.service.hub.HubEndpoint;
import io.xj.service.hub.dao.ProgramVoiceTrackDAO;
import io.xj.service.hub.entity.UserRoleType;

import javax.annotation.security.RolesAllowed;
import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.PATCH;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.QueryParam;
import javax.ws.rs.container.ContainerRequestContext;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.Response;

/**
 ProgramVoiceTrack endpoint
 */
@Path("program-voice-tracks")
public class ProgramVoiceTrackEndpoint extends HubEndpoint {
  private final ProgramVoiceTrackDAO dao;

  /**
   Constructor
   */
  @Inject
  public ProgramVoiceTrackEndpoint(
    ProgramVoiceTrackDAO dao,
    HttpResponseProvider response,
    Config config,
    PayloadFactory payloadFactory
  ) {
    super(response, config, payloadFactory);
    this.dao = dao;
  }

  /**
   Create new programVoiceTrack binding

   @param payload with which to of ProgramVoiceTrack Binding
   @return Response
   */
  @POST
  @Consumes(MediaType.APPLICATION_JSONAPI)
  @RolesAllowed({UserRoleType.ARTIST})
  public Response create(Payload payload, @Context ContainerRequestContext crc) {
    return create(crc, dao(), payload);
  }

  /**
   Get one ProgramVoiceTrack by id

   @return application/json response.
   */
  @GET
  @Path("{id}")
  @RolesAllowed({UserRoleType.ARTIST})
  public Response readOne(@Context ContainerRequestContext crc, @PathParam("id") String id) {
    return readOne(crc, dao(), id);
  }

  /**
   Get Bindings in one programVoiceTrack.

   @return application/json response.
   */
  @GET
  @RolesAllowed({UserRoleType.ARTIST})
  public Response readMany(@Context ContainerRequestContext crc, @QueryParam("programVoiceId") String programVoiceId) {
    return readMany(crc, dao(), programVoiceId);
  }

  /**
   Update one ProgramVoiceTrack

   @param payload with which to update record.
   @return Response
   */
  @PATCH
  @Path("{id}")
  @Consumes(MediaType.APPLICATION_JSONAPI)
  @RolesAllowed(UserRoleType.ARTIST)
  public Response update(Payload payload, @Context ContainerRequestContext crc, @PathParam("id") String id) {
    return update(crc, dao(), id, payload);
  }

  /**
   Delete one ProgramVoiceTrack by programVoiceTrackId and bindingId

   @return application/json response.
   */
  @DELETE
  @Path("{id}")
  @RolesAllowed({UserRoleType.ARTIST})
  public Response delete(@Context ContainerRequestContext crc, @PathParam("id") String id) {
    return delete(crc, dao(), id);
  }

  /**
   Get DAO of injector

   @return DAO
   */
  private ProgramVoiceTrackDAO dao() {
    return dao;
  }

}
