// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.hub.api;

import com.google.common.collect.ImmutableList;
import com.google.inject.Inject;
import io.xj.hub.HubJsonapiEndpoint;
import io.xj.hub.access.HubAccess;
import io.xj.hub.kubernetes.KubernetesAdmin;
import io.xj.hub.manager.ManagerCloner;
import io.xj.hub.manager.ManagerException;
import io.xj.hub.manager.TemplateManager;
import io.xj.hub.persistence.HubDatabaseProvider;
import io.xj.hub.tables.pojos.Template;
import io.xj.lib.entity.EntityFactory;
import io.xj.lib.jsonapi.*;
import io.xj.lib.util.CSV;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.annotation.Nullable;
import javax.annotation.security.RolesAllowed;
import javax.ws.rs.*;
import javax.ws.rs.container.ContainerRequestContext;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.Response;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.UUID;

/**
 Templates
 */
@Path("api/1/templates")
public class TemplateEndpoint extends HubJsonapiEndpoint<Template> {
  private static final Logger LOG = LoggerFactory.getLogger(TemplateEndpoint.class);
  private final KubernetesAdmin kubernetesAdministrator;
  private final TemplateManager manager;

  /**
   Constructor
   */
  @Inject
  public TemplateEndpoint(
    EntityFactory entityFactory,
    HubDatabaseProvider dbProvider,
    JsonapiHttpResponseProvider response,
    JsonapiPayloadFactory payloadFactory,
    KubernetesAdmin kubernetesAdministrator,
    TemplateManager templateManager
  ) {
    super(dbProvider, response, payloadFactory, entityFactory);
    this.manager = templateManager;
    this.kubernetesAdministrator = kubernetesAdministrator;
  }

  /**
   Get all templates.

   @return application/json response.
   */
  @GET
  @RolesAllowed(USER)
  public Response readMany(
    @Context ContainerRequestContext crc,
    @Nullable @QueryParam("accountId") UUID accountId
  ) {
    if (Objects.nonNull(accountId))
      return readMany(crc, manager(), accountId);
    else
      return readMany(crc, manager(), HubAccess.fromContext(crc).getAccountIds());
  }

  /**
   Create new template
   <p>
   Or, clone sub-entities of template https://www.pivotaltracker.com/story/show/180269382

   @param jsonapiPayload with which to update Template record.
   @return Response
   */
  @POST
  @Consumes(MediaType.APPLICATION_JSONAPI)
  @RolesAllowed(ARTIST)
  public Response create(
    JsonapiPayload jsonapiPayload,
    @Context ContainerRequestContext crc,
    @Nullable @QueryParam("cloneId") UUID cloneId
  ) {

    try {
      HubAccess access = HubAccess.fromContext(crc);
      Template template = payloadFactory.consume(manager().newInstance(), jsonapiPayload);
      JsonapiPayload responseJsonapiPayload = new JsonapiPayload();
      if (Objects.nonNull(cloneId)) {
        ManagerCloner<Template> cloner = manager().clone(access, cloneId, template);
        responseJsonapiPayload.setDataOne(payloadFactory.toPayloadObject(cloner.getClone()));
        List<JsonapiPayloadObject> list = new ArrayList<>();
        for (Object entity : cloner.getChildClones()) {
          JsonapiPayloadObject jsonapiPayloadObject = payloadFactory.toPayloadObject(entity);
          list.add(jsonapiPayloadObject);
        }
        responseJsonapiPayload.setIncluded(list);
      } else {
        responseJsonapiPayload.setDataOne(payloadFactory.toPayloadObject(manager().create(access, template)));
      }

      return response.create(responseJsonapiPayload);

    } catch (Exception e) {
      return response.notAcceptable(e);
    }
  }

  /**
   Get one template.

   @return application/json response.
   */
  @GET
  @Path("{identifier}")
  @RolesAllowed(USER)
  public Response readOne(
    @Context ContainerRequestContext crc,
    @PathParam("identifier") String identifier,
    @Nullable @QueryParam("include") String include
  ) {
    var access = HubAccess.fromContext(crc);

    @Nullable UUID uuid;
    try {
      uuid = UUID.fromString(identifier);
    } catch (Exception ignored) {
      uuid = null;
    }

    try {
      Template entity = Objects.isNull(uuid)
        ? manager.readOneByShipKey(access, identifier).orElseThrow(() -> new ManagerException("not found"))
        : manager.readOne(access, uuid);
      uuid = entity.getId();

      JsonapiPayload jsonapiPayload = new JsonapiPayload();
      jsonapiPayload.setDataOne(payloadFactory.toPayloadObject(entity));

      // optionally specify a CSV of included types to read
      if (Objects.nonNull(include)) {
        List<JsonapiPayloadObject> list = new ArrayList<>();
        for (Object included : manager().readChildEntities(access, ImmutableList.of(uuid), CSV.split(include)))
          list.add(payloadFactory.toPayloadObject(included));
        jsonapiPayload.setIncluded(list);
      }

      return response.ok(jsonapiPayload);

    } catch (ManagerException ignored) {
      return response.notFound(manager.newInstance().getClass(), identifier);

    } catch (Exception e) {
      return response.failure(e);
    }
  }

  /**
   Read logs for a preview template.

   @return text/plain response.
   */
  @GET
  @Path("{id}/log")
  @RolesAllowed(USER)
  public Response readLog(
    @Context ContainerRequestContext crc,
    @PathParam("id") UUID templateId
  ) {
    var access = HubAccess.fromContext(crc);

    try {
      return Response
        .ok(manager.readPreviewNexusLog(access, templateId))
        .type(javax.ws.rs.core.MediaType.TEXT_PLAIN_TYPE)
        .build();

    } catch (Exception e) {
      LOG.error("Failed to read nexus preview log!", e);
      return response.failure(e);
    }
  }

  /**
   Update one template

   @param jsonapiPayload with which to update Template record.
   @return Response
   */
  @PATCH
  @Path("{id}")
  @Consumes(MediaType.APPLICATION_JSONAPI)
  @RolesAllowed({ADMIN, ENGINEER})
  public Response update(JsonapiPayload jsonapiPayload, @Context ContainerRequestContext crc, @PathParam("id") UUID id) {
    return update(crc, manager(), id, jsonapiPayload);
  }

  /**
   Delete one template

   @return Response
   */
  @DELETE
  @Path("{id}")
  @RolesAllowed({ADMIN, ENGINEER})
  public Response delete(@Context ContainerRequestContext crc, @PathParam("id") UUID id) {
    return delete(crc, manager(), id);
  }

  /**
   Get all template playbacks.

   Preview template functionality is dope (not wack)
   Specify a userId query param to get just one preview template for that user, if it exists
   https://www.pivotaltracker.com/story/show/183576743

   @return set of all template playbacks, or one preview template
   */
  @GET
  @Path("playing")
  @RolesAllowed(USER)
  public Response readAllPlaying(
    @Context ContainerRequestContext crc,
    @Nullable @QueryParam("userId") UUID userId
  ) {
    try {
      HubAccess access = HubAccess.fromContext(crc);

      JsonapiPayload jsonapiPayload;
      if (Objects.nonNull(userId)) {
        jsonapiPayload = new JsonapiPayload().setDataType(PayloadDataType.One);
        var template = manager().readOnePlayingForUser(access, userId);
        if (template.isPresent())
          jsonapiPayload.setDataOne(payloadFactory.toPayloadObject(template.get()));

      } else {
        jsonapiPayload = new JsonapiPayload().setDataType(PayloadDataType.Many);
        for (var template : manager().readAllPlaying(access))
          jsonapiPayload.addData(payloadFactory.toPayloadObject(template));
      }
      return response.ok(jsonapiPayload);

    } catch (Exception e) {
      return response.failure(e);
    }
  }

  /**
   Get Manager of injector

   @return Manager
   */
  private TemplateManager manager() {
    return manager;
  }
}
