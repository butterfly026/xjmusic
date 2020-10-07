// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.service.hub.api;

import com.google.inject.Inject;
import com.typesafe.config.Config;
import io.xj.lib.entity.Entity;
import io.xj.lib.jsonapi.HttpResponseProvider;
import io.xj.lib.jsonapi.MediaType;
import io.xj.lib.jsonapi.Payload;
import io.xj.lib.jsonapi.PayloadFactory;
import io.xj.lib.jsonapi.PayloadObject;
import io.xj.service.hub.HubEndpoint;
import io.xj.service.hub.access.HubAccess;
import io.xj.service.hub.dao.DAOCloner;
import io.xj.service.hub.dao.ProgramSequenceDAO;
import io.xj.service.hub.entity.ProgramSequence;
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
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.UUID;

/**
 ProgramSequence endpoint
 */
@Path("program-sequences")
public class ProgramSequenceEndpoint extends HubEndpoint {
  private final ProgramSequenceDAO dao;

  /**
   Constructor
   */
  @Inject
  public ProgramSequenceEndpoint(
    ProgramSequenceDAO dao,
    HttpResponseProvider response,
    Config config,
    PayloadFactory payloadFactory
  ) {
    super(response, config, payloadFactory);
    this.dao = dao;
  }

  /**
   Create new programSequence binding

   @param payload with which to of ProgramSequence Binding
   @return Response
   */
  @POST
  @Consumes(MediaType.APPLICATION_JSONAPI)
  @RolesAllowed({UserRoleType.ARTIST})
  public Response create(
    Payload payload,
    @Context ContainerRequestContext crc,
    @QueryParam("cloneId") String cloneId
  ) {
    try {
      HubAccess hubAccess = HubAccess.fromContext(crc);
      ProgramSequence programSequence = payloadFactory.consume(dao().newInstance(), payload);
      Payload responsePayload = new Payload();
      if (Objects.nonNull(cloneId)) {
        DAOCloner<ProgramSequence> cloner = dao().clone(hubAccess, UUID.fromString(cloneId), programSequence);
        responsePayload.setDataOne(payloadFactory.toPayloadObject(cloner.getClone()));
        List<PayloadObject> list = new ArrayList<>();
        for (Entity entity : cloner.getChildClones()) {
          PayloadObject payloadObject = payloadFactory.toPayloadObject(entity);
          list.add(payloadObject);
        }
        responsePayload.setIncluded(list);
      } else {
        responsePayload.setDataOne(payloadFactory.toPayloadObject(dao().create(hubAccess, programSequence)));
      }

      return response.create(responsePayload);

    } catch (Exception e) {
      return response.notAcceptable(e);
    }
  }

  /**
   Get one ProgramSequence by id

   @return application/json response.
   */
  @GET
  @Path("{id}")
  @RolesAllowed({UserRoleType.ARTIST})
  public Response readOne(@Context ContainerRequestContext crc, @PathParam("id") String id) {
    return readOne(crc, dao(), id);
  }

  /**
   Get Bindings in one programSequence.

   @return application/json response.
   */
  @GET
  @RolesAllowed({UserRoleType.ARTIST})
  public Response readMany(@Context ContainerRequestContext crc, @QueryParam("programId") String programId) {
    return readMany(crc, dao(), programId);
  }

  /**
   Update one ProgramSequence

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
   Delete one ProgramSequence by programSequenceId and bindingId

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
  private ProgramSequenceDAO dao() {
    return dao;
  }

}
