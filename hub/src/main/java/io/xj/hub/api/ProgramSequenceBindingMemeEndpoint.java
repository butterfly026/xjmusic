// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.hub.api;

import com.google.inject.Inject;
import com.typesafe.config.Config;
import io.xj.hub.dao.ProgramSequenceBindingMemeDAO;
import io.xj.lib.jsonapi.JsonapiHttpResponseProvider;
import io.xj.lib.jsonapi.MediaType;
import io.xj.lib.jsonapi.JsonapiPayload;
import io.xj.lib.jsonapi.JsonapiPayloadFactory;
import io.xj.hub.HubEndpoint;

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
 ProgramSequenceBindingMeme endpoint
 */
@Path("api/1/program-sequence-binding-memes")
public class ProgramSequenceBindingMemeEndpoint extends HubEndpoint {
  private final ProgramSequenceBindingMemeDAO dao;

  /**
   Constructor
   */
  @Inject
  public ProgramSequenceBindingMemeEndpoint(
    ProgramSequenceBindingMemeDAO dao,
    JsonapiHttpResponseProvider response,
    Config config,
    JsonapiPayloadFactory payloadFactory
  ) {
    super(response, config, payloadFactory);
    this.dao = dao;
  }

  /**
   Create new programSequence bindingMeme

   @param jsonapiPayload with which to of ProgramSequence BindingMeme
   @return Response
   */
  @POST
  @Consumes(MediaType.APPLICATION_JSONAPI)
  @RolesAllowed({ARTIST})
  public Response create(JsonapiPayload jsonapiPayload, @Context ContainerRequestContext crc) {
    return create(crc, dao(), jsonapiPayload);
  }

  /**
   Get one ProgramSequenceBindingMeme by id

   @return application/json response.
   */
  @GET
  @Path("{id}")
  @RolesAllowed({ARTIST})
  public Response readOne(@Context ContainerRequestContext crc, @PathParam("id") String id) {
    return readOne(crc, dao(), id);
  }

  /**
   Get BindingMemes in one programSequence.

   @return application/json response.
   */
  @GET
  @RolesAllowed({ARTIST})
  public Response readMany(@Context ContainerRequestContext crc, @QueryParam("programSequenceBindingId") String programSequenceBindingId) {
    return readMany(crc, dao(), programSequenceBindingId);
  }

  /**
   Update one ProgramSequenceBindingMeme

   @param jsonapiPayload with which to update record.
   @return Response
   */
  @PATCH
  @Path("{id}")
  @Consumes(MediaType.APPLICATION_JSONAPI)
  @RolesAllowed(ARTIST)
  public Response update(JsonapiPayload jsonapiPayload, @Context ContainerRequestContext crc, @PathParam("id") String id) {
    return update(crc, dao(), id, jsonapiPayload);
  }

  /**
   Delete one ProgramSequenceBindingMeme by programSequenceId and bindingMemeId

   @return application/json response.
   */
  @DELETE
  @Path("{id}")
  @RolesAllowed({ARTIST})
  public Response delete(@Context ContainerRequestContext crc, @PathParam("id") String id) {
    return delete(crc, dao(), id);
  }

  /**
   Get DAO of injector

   @return DAO
   */
  private ProgramSequenceBindingMemeDAO dao() {
    return dao;
  }

}