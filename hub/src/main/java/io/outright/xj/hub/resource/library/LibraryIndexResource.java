// Copyright Outright Mental, Inc. All Rights Reserved.
package io.outright.xj.hub.resource.library;

import io.outright.xj.core.CoreModule;
import io.outright.xj.core.app.access.AccessControl;
import io.outright.xj.core.app.config.Exposure;
import io.outright.xj.core.app.server.HttpResponseProvider;
import io.outright.xj.core.dao.LibraryDAO;
import io.outright.xj.core.model.Entity;
import io.outright.xj.core.model.library.Library;
import io.outright.xj.core.model.library.LibraryWrapper;
import io.outright.xj.core.model.role.Role;
import io.outright.xj.core.transport.JSON;

import com.google.inject.Guice;
import com.google.inject.Injector;
import org.jooq.types.ULong;
import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.annotation.security.RolesAllowed;
import javax.jws.WebResult;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.QueryParam;
import javax.ws.rs.container.ContainerRequestContext;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.io.IOException;

/**
 * Libraries
 */
@Path("libraries")
public class LibraryIndexResource {
  private static final Injector injector = Guice.createInjector(new CoreModule());
  private static Logger log = LoggerFactory.getLogger(LibraryIndexResource.class);
  private final LibraryDAO libraryDAO = injector.getInstance(LibraryDAO.class);
  private final HttpResponseProvider httpResponseProvider = injector.getInstance(HttpResponseProvider.class);

  @QueryParam("account")
  String accountId;

  /**
   * Get all libraries.
   *
   * @return application/json response.
   */
  @GET
  @WebResult
  @RolesAllowed({Role.USER})
  public Response readAll(@Context ContainerRequestContext crc) throws IOException {
    AccessControl access = AccessControl.fromContext(crc);

    if (accountId == null || accountId.length() == 0) {
      return httpResponseProvider.notAcceptable("Account id is required");
    }

    try {
      JSONArray result = libraryDAO.readAllIn(access, ULong.valueOf(accountId));
      if (result != null) {
        return Response
          .accepted(JSON.wrap(Library.KEY_MANY, result).toString())
          .type(MediaType.APPLICATION_JSON)
          .build();
      } else {
        return Response.noContent().build();
      }

    } catch (Exception e) {
      log.error("Exception", e);
      return httpResponseProvider.failure(e);
    }
  }

  /**
   * Create new library
   *
   * @param data with which to update Library record.
   * @return Response
   */
  @POST
  @Consumes(MediaType.APPLICATION_JSON)
  @RolesAllowed({Role.ADMIN})
  public Response create(LibraryWrapper data, @Context ContainerRequestContext crc) {
    AccessControl access = AccessControl.fromContext(crc);
    try {
      JSONObject newEntity = libraryDAO.create(access, data);
      return Response
        .created(Exposure.apiURI(Library.KEY_MANY + "/" + newEntity.get(Entity.KEY_ID)))
        .entity(JSON.wrap(Library.KEY_ONE, newEntity).toString())
        .build();

    } catch (Exception e) {
      return httpResponseProvider.failureToCreate(e);
    }
  }

}