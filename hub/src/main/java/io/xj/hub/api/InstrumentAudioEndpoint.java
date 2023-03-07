// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.hub.api;

import com.google.common.collect.ImmutableList;
import com.google.common.collect.ImmutableMap;
import io.xj.hub.HubJsonapiEndpoint;
import io.xj.hub.access.HubAccess;
import io.xj.hub.manager.InstrumentAudioManager;
import io.xj.hub.persistence.HubSqlStoreProvider;
import io.xj.hub.tables.pojos.InstrumentAudio;
import io.xj.lib.entity.EntityFactory;
import io.xj.lib.jsonapi.JsonapiResponseProvider;
import io.xj.lib.jsonapi.JsonapiPayload;
import io.xj.lib.jsonapi.JsonapiPayloadFactory;
import io.xj.lib.jsonapi.PayloadDataType;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;

import javax.annotation.Nullable;
import javax.annotation.security.RolesAllowed;
import javax.ws.rs.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Collection;
import java.util.Map;
import java.util.Objects;
import java.util.UUID;

/**
 * InstrumentAudio endpoint
 */
@Path("api/1/instrument-audios")
public class InstrumentAudioEndpoint extends HubJsonapiEndpoint {
  private final InstrumentAudioManager manager;

  /**
   * Constructor
   */
  public InstrumentAudioEndpoint(
    InstrumentAudioManager manager,
    HubSqlStoreProvider sqlStoreProvider,
    JsonapiResponseProvider response,
    JsonapiPayloadFactory payloadFactory,
    EntityFactory entityFactory
  ) {
    super(sqlStoreProvider, response, payloadFactory, entityFactory);
    this.manager = manager;
  }

  /**
   * Create new instrumentAudio binding
   *
   * @param jsonapiPayload with which to of InstrumentAudio Binding
   * @return ResponseEntity
   */
  @POST
  @Consumes(MediaType.APPLICATION_JSON_VALUE)
  @RolesAllowed(ARTIST)
  public ResponseEntity<JsonapiPayload> create(
    JsonapiPayload jsonapiPayload,
    HttpServletRequest req, HttpServletResponse res,
    @Nullable @QueryParam("cloneId") UUID cloneId
  ) {
    try {
      HubAccess access = HubAccess.fromRequest(req);
      var instrumentAudio = payloadFactory.consume(manager().newInstance(), jsonapiPayload);
      InstrumentAudio created;
      if (Objects.nonNull(cloneId))
        created = manager().clone(access, cloneId, instrumentAudio);
      else
        created = manager().create(access, instrumentAudio);

      return responseProvider.create(new JsonapiPayload().setDataOne(payloadFactory.toPayloadObject(created)));

    } catch (Exception e) {
      return responseProvider.notAcceptable(e);
    }
  }

  /**
   * Generate an Upload policy to upload the corresponding file to 3rd-party storage (e.g. Amazon S3)
   *
   * @return application/json response.
   */
  @GET
  @Path("{id}/upload")
  @RolesAllowed(ARTIST)
  public ResponseEntity<Map<String, String>> uploadOne(HttpServletRequest req, HttpServletResponse res, @PathParam("id") UUID id, @QueryParam("extension") String extension) {
    try {
      Map<String, String> result = manager().authorizeUpload(HubAccess.fromRequest(req), id, extension);
      if (null != result) {
        return ResponseEntity
          .accepted()
          .contentType(MediaType.APPLICATION_JSON)
          .body(result);
      } else {
        return ResponseEntity.notFound().build();
      }


    } catch (Exception e) {
      return ResponseEntity.internalServerError().body(ImmutableMap.of("error", e.getMessage()));
    }
  }

  /**
   * Get one InstrumentAudio by id
   *
   * @return application/json response.
   */
  @GET
  @Path("{id}")
  @RolesAllowed(ARTIST)
  public ResponseEntity<JsonapiPayload> readOne(HttpServletRequest req, @PathParam("id") UUID id) {
    return readOne(req, manager(), id);
  }

  /**
   * Get Bindings in one instrumentAudio.
   *
   * @param detailed whether to include events and chords
   * @return application/json response.
   */
  @GET
  @RolesAllowed(ARTIST)
  public ResponseEntity<JsonapiPayload> readMany(
    HttpServletRequest req, HttpServletResponse res,
    @QueryParam("instrumentId") String instrumentId,
    @QueryParam("detailed") Boolean detailed
  ) {
    try {
      JsonapiPayload jsonapiPayload = new JsonapiPayload().setDataType(PayloadDataType.Many);
      Collection<InstrumentAudio> instrumentAudios = manager.readMany(HubAccess.fromRequest(req), ImmutableList.of(UUID.fromString(instrumentId)));

      // add instrumentAudios as plural data in payload
      for (InstrumentAudio instrumentAudio : instrumentAudios)
        jsonapiPayload.addData(payloadFactory.toPayloadObject(instrumentAudio));

      // ok
      return responseProvider.ok(jsonapiPayload);

    } catch (Exception e) {
      return responseProvider.failure(e);
    }
  }

  /**
   * Update one instrumentAudio
   *
   * @param jsonapiPayload with which to update InstrumentAudio record.
   * @return ResponseEntity
   */
  @PATCH
  @Path("{id}")
  @Consumes(MediaType.APPLICATION_JSON_VALUE)
  @RolesAllowed(ARTIST)
  public ResponseEntity<JsonapiPayload> update(JsonapiPayload jsonapiPayload, HttpServletRequest req, @PathParam("id") UUID id) {
    return update(req, manager(), id, jsonapiPayload);
  }

  /**
   * Delete one InstrumentAudio by instrumentAudioId and bindingId
   *
   * @return application/json response.
   */
  @DELETE
  @Path("{id}")
  @RolesAllowed(ARTIST)
  public ResponseEntity<JsonapiPayload> delete(HttpServletRequest req, @PathParam("id") UUID id) {
    return delete(req, manager(), id);
  }

  /**
   * Get Manager of injector
   *
   * @return Manager
   */
  private InstrumentAudioManager manager() {
    return manager;
  }

}
