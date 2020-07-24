// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.service.hub.api;

import com.google.common.collect.ImmutableList;
import com.google.inject.Injector;
import io.xj.lib.entity.Entity;
import io.xj.lib.jsonapi.MediaType;
import io.xj.lib.jsonapi.Payload;
import io.xj.lib.jsonapi.PayloadDataType;
import io.xj.service.hub.HubEndpoint;
import io.xj.service.hub.access.HubAccess;
import io.xj.service.hub.dao.InstrumentAudioChordDAO;
import io.xj.service.hub.dao.InstrumentAudioDAO;
import io.xj.service.hub.dao.InstrumentAudioEventDAO;
import io.xj.service.hub.entity.InstrumentAudio;
import io.xj.service.hub.entity.UserRoleType;

import javax.annotation.security.RolesAllowed;
import javax.inject.Inject;
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
import java.util.Collection;
import java.util.Map;
import java.util.Objects;
import java.util.Set;
import java.util.UUID;

/**
 InstrumentAudio endpoint
 */
@Path("instrument-audios")
public class InstrumentAudioEndpoint extends HubEndpoint {
  private final InstrumentAudioEventDAO instrumentAudioEventDAO;
  private final InstrumentAudioChordDAO instrumentAudioChordDAO;
  private final InstrumentAudioDAO dao;

  /**
   The constructor's @javax.inject.Inject binding is for HK2, Jersey's injection system,
   which injects the inner com.google.inject.Injector for Guice-bound classes
   */
  @Inject
  public InstrumentAudioEndpoint(
    Injector injector
  ) {
    super(injector);
    dao = injector.getInstance(InstrumentAudioDAO.class);
    this.instrumentAudioEventDAO = injector.getInstance(InstrumentAudioEventDAO.class);
    this.instrumentAudioChordDAO = injector.getInstance(InstrumentAudioChordDAO.class);
  }

  /**
   Create new instrumentAudio binding

   @param payload with which to of InstrumentAudio Binding
   @return Response
   */
  @POST
  @Consumes(MediaType.APPLICATION_JSONAPI)
  @RolesAllowed({UserRoleType.ARTIST})
  public Response create(Payload payload, @Context ContainerRequestContext crc, @QueryParam("cloneId") String cloneId) {
    try {
      HubAccess hubAccess = HubAccess.fromContext(crc);
      InstrumentAudio instrumentAudio = payloadFactory.consume(dao().newInstance(), payload);
      InstrumentAudio created;
      if (Objects.nonNull(cloneId))
        created = dao().clone(hubAccess, UUID.fromString(cloneId), instrumentAudio);
      else
        created = dao().create(hubAccess, instrumentAudio);

      return response.create(new Payload().setDataOne(payloadFactory.toPayloadObject(created)));

    } catch (Exception e) {
      return response.failureToCreate(e);
    }
  }

  /**
   Generate an Upload policy to upload the corresponding file to 3rd-party storage (e.g. Amazon S3)

   @return application/json response.
   */
  @GET
  @Path("{id}/upload")
  @RolesAllowed(UserRoleType.ARTIST)
  public Response uploadOne(@Context ContainerRequestContext crc, @PathParam("id") String id) {
    try {
      Map<String, String> result = dao().authorizeUpload(HubAccess.fromContext(crc), UUID.fromString(id));
      if (null != result) {
        return Response
          .accepted(payloadFactory.serialize(result))
          .type(MediaType.APPLICATION_JSON)
          .build();
      } else {
        return response.notFound(dao.newInstance().setId(UUID.fromString(id)));
      }


    } catch (Exception e) {
      return response.failure(e);
    }
  }

  /**
   Get one InstrumentAudio by id

   @return application/json response.
   */
  @GET
  @Path("{id}")
  @RolesAllowed({UserRoleType.ARTIST})
  public Response readOne(@Context ContainerRequestContext crc, @PathParam("id") String id) {
    return readOne(crc, dao(), id);
  }

  /**
   Get Bindings in one instrumentAudio.

   @param detailed whether to include events and chords
   @return application/json response.
   */
  @GET
  @RolesAllowed({UserRoleType.ARTIST})
  public Response readMany(
    @Context ContainerRequestContext crc,
    @QueryParam("instrumentId") String instrumentId,
    @QueryParam("detailed") Boolean detailed
  ) {
    try {
      HubAccess hubAccess = HubAccess.fromContext(crc);
      Payload payload = new Payload().setDataType(PayloadDataType.Many);
      Collection<InstrumentAudio> instrumentAudios = dao.readMany(HubAccess.fromContext(crc), ImmutableList.of(UUID.fromString(instrumentId)));
      Set<UUID> instrumentAudioIds = Entity.idsOf(instrumentAudios);

      // add instrumentAudios as plural data in payload
      for (InstrumentAudio instrumentAudio : instrumentAudios)
        payload.addData(payloadFactory.toPayloadObject(instrumentAudio));

      // if included, seek and add events to payload
      if (Objects.nonNull(detailed) && detailed)
        payload.addAllToIncluded(payloadFactory.toPayloadObjects(
          instrumentAudioEventDAO.readMany(hubAccess, instrumentAudioIds)));

      // if included, seek and add chords to payload
      if (Objects.nonNull(detailed) && detailed)
        payload.addAllToIncluded(payloadFactory.toPayloadObjects(
          instrumentAudioChordDAO.readMany(hubAccess, instrumentAudioIds)));

      // ok
      return response.ok(payload);

    } catch (Exception e) {
      return response.failure(e);
    }
  }

  /**
   Update one instrumentAudio

   @param payload with which to update InstrumentAudio record.
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
   Delete one InstrumentAudio by instrumentAudioId and bindingId

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
  private InstrumentAudioDAO dao() {
    return dao;
  }

}