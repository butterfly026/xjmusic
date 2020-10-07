// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.service.hub.api;

import com.google.common.collect.ImmutableSet;
import com.google.inject.Inject;
import com.typesafe.config.Config;
import io.xj.lib.jsonapi.HttpResponseProvider;
import io.xj.lib.jsonapi.Payload;
import io.xj.lib.jsonapi.PayloadFactory;
import io.xj.service.hub.HubEndpoint;
import io.xj.service.hub.HubException;
import io.xj.service.hub.access.HubAccess;
import io.xj.service.hub.digest.Digest;
import io.xj.service.hub.digest.DigestCacheProvider;
import io.xj.service.hub.digest.DigestType;
import io.xj.service.hub.entity.UserRoleType;
import io.xj.service.hub.ingest.HubIngest;
import io.xj.service.hub.ingest.HubIngestCacheProvider;

import javax.annotation.security.RolesAllowed;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.QueryParam;
import javax.ws.rs.container.ContainerRequestContext;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.Response;
import java.util.Objects;
import java.util.UUID;

/**
 Digest
 <p>
 [#154234716] Architect wants ingest of library contents, to modularize graph mathematics used during craft, and provide the Artist with useful insight for developing the library.
 */
@Path("digest")
public class DigestEndpoint extends HubEndpoint {
  private final HubIngestCacheProvider ingestProvider;
  private final DigestCacheProvider digestProvider;

  /**
   Constructor
   */
  @Inject
  public DigestEndpoint(
    HttpResponseProvider response,
    Config config,
    PayloadFactory payloadFactory,
    HubIngestCacheProvider ingestProvider,
    DigestCacheProvider digestProvider
  ) {
    super(response, config, payloadFactory);
    this.ingestProvider = ingestProvider;
    this.digestProvider = digestProvider;
  }

  /**
   Perform any type of digest

   @return application/json response.
   */
  @GET
  @RolesAllowed({UserRoleType.ARTIST, UserRoleType.ENGINEER})
  public Response digest(
    @Context ContainerRequestContext crc,
    @QueryParam("type") String typeString,
    @QueryParam("libraryId") String libraryIdString
  ) {

    if (Objects.isNull(libraryIdString) || libraryIdString.isEmpty()) {
      return response.notAcceptable("Must specify `libraryId` create digest.");
    }

    if (Objects.isNull(typeString) || typeString.isEmpty()) {
      return response.notAcceptable("Must specify `type` create digest.");
    }

    DigestType digestType;
    try {
      digestType = DigestType.validate(typeString);
    } catch (Exception e) {
      return response.failure(e);
    }

    try {
      UUID libraryId = UUID.fromString(libraryIdString);
      Payload payload = new Payload();
      payload.setDataOne(evaluate(
        HubAccess.fromContext(crc),
        digestType, libraryId
      ).getPayloadObject());
      return response.ok(payload);

    } catch (Exception e) {
      return response.failure(e);
    }
  }

  /**
   Perform any type of digest

   @param hubAccess control
   @param type      of ingest
   @param targetId  of entity
   @return ingest
   */
  private Digest evaluate(HubAccess hubAccess, DigestType type, UUID targetId) throws Exception {
    HubIngest ingest = ingestProvider.ingest(hubAccess, ImmutableSet.of(targetId), ImmutableSet.of(targetId), ImmutableSet.of(targetId));
    switch (type) {

      case DigestHash:
        return digestProvider.hash(ingest);

      case DigestMeme:
        return digestProvider.meme(ingest);

      case DigestChordProgression:
        return digestProvider.chordProgression(ingest);

      case DigestChordMarkov:
        return digestProvider.chordMarkov(ingest);

      case DigestSequenceStyle:
        return digestProvider.sequenceStyle(ingest);

      default:
        throw new HubException(String.format("Invalid type: %s", type));
    }
  }
}
