// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.hub.api;

import com.google.common.collect.ImmutableList;
import com.google.inject.Inject;
import com.typesafe.config.Config;
import io.xj.api.InstrumentAudio;
import io.xj.hub.HubEndpoint;
import io.xj.hub.access.HubAccess;
import io.xj.hub.dao.InstrumentAudioDAO;
import io.xj.lib.jsonapi.JsonapiHttpResponseProvider;
import io.xj.lib.jsonapi.JsonapiPayload;
import io.xj.lib.jsonapi.MediaType;
import io.xj.lib.jsonapi.PayloadDataType;
import io.xj.lib.jsonapi.JsonapiPayloadFactory;

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
import java.util.Collection;
import java.util.Map;
import java.util.Objects;
import java.util.UUID;

/**
 InstrumentAudio endpoint
 */
@Path("api/1/instrument-audios")
public class InstrumentAudioEndpoint extends HubEndpoint {
  private final InstrumentAudioDAO dao;

  /**
   Constructor
   */
  @Inject
  public InstrumentAudioEndpoint(
    InstrumentAudioDAO dao,
    JsonapiHttpResponseProvider response,
    Config config,
    JsonapiPayloadFactory payloadFactory
  ) {
    super(response, config, payloadFactory);
    this.dao = dao;
  }

  /**
   Create new instrumentAudio binding

   @param jsonapiPayload with which to of InstrumentAudio Binding
   @return Response
   */
  @POST
  @Consumes(MediaType.APPLICATION_JSONAPI)
  @RolesAllowed({ARTIST})
  public Response create(JsonapiPayload jsonapiPayload, @Context ContainerRequestContext crc, @QueryParam("cloneId") String cloneId) {
    try {
      HubAccess hubAccess = HubAccess.fromContext(crc);
      var instrumentAudio = payloadFactory.consume(dao().newInstance(), jsonapiPayload);
      InstrumentAudio created;
      if (Objects.nonNull(cloneId))
        created = dao().clone(hubAccess, UUID.fromString(cloneId), instrumentAudio);
      else
        created = dao().create(hubAccess, instrumentAudio);

      return response.create(new JsonapiPayload().setDataOne(payloadFactory.toPayloadObject(created)));

    } catch (Exception e) {
      return response.notAcceptable(e);
    }
  }

  /**
   Generate an Upload policy to upload the corresponding file to 3rd-party storage (e.g. Amazon S3)

   @return application/json response.
   */
  @GET
  @Path("{id}/upload")
  @RolesAllowed(ARTIST)
  public Response uploadOne(@Context ContainerRequestContext crc, @PathParam("id") String id) {
    try {
      Map<String, String> result = dao().authorizeUpload(HubAccess.fromContext(crc), UUID.fromString(id));
      if (null != result) {
        return Response
          .accepted(payloadFactory.serialize(result))
          .type(MediaType.APPLICATION_JSON)
          .build();
      } else {
        return response.notFound(dao.newInstance().getClass(), id);
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
  @RolesAllowed({ARTIST})
  public Response readOne(@Context ContainerRequestContext crc, @PathParam("id") String id) {
    return readOne(crc, dao(), id);
  }

  /**
   Get Bindings in one instrumentAudio.

   @param detailed whether to include events and chords
   @return application/json response.
   */
  @GET
  @RolesAllowed({ARTIST})
  public Response readMany(
    @Context ContainerRequestContext crc,
    @QueryParam("instrumentId") String instrumentId,
    @QueryParam("detailed") Boolean detailed
  ) {
    try {
      JsonapiPayload jsonapiPayload = new JsonapiPayload().setDataType(PayloadDataType.Many);
      Collection<InstrumentAudio> instrumentAudios = dao.readMany(HubAccess.fromContext(crc), ImmutableList.of(UUID.fromString(instrumentId)));

      // add instrumentAudios as plural data in payload
      for (InstrumentAudio instrumentAudio : instrumentAudios)
        jsonapiPayload.addData(payloadFactory.toPayloadObject(instrumentAudio));

      // ok
      return response.ok(jsonapiPayload);

    } catch (Exception e) {
      return response.failure(e);
    }
  }

  /**
   Update one instrumentAudio

   @param jsonapiPayload with which to update InstrumentAudio record.
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
   Delete one InstrumentAudio by instrumentAudioId and bindingId

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
  private InstrumentAudioDAO dao() {
    return dao;
  }

}