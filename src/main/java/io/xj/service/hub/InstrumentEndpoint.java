// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.service.hub;

import com.google.common.collect.ImmutableList;
import com.google.inject.Injector;
import io.xj.core.access.Access;
import io.xj.core.app.AppResource;
import io.xj.core.dao.InstrumentDAO;
import io.xj.core.model.Instrument;
import io.xj.core.model.UserRoleType;
import io.xj.core.payload.MediaType;
import io.xj.core.payload.Payload;

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
import java.util.Objects;
import java.util.UUID;

/**
 Instruments
 */
@Path("instruments")
public class InstrumentEndpoint extends AppResource {
  private InstrumentDAO dao;


  /**
   The constructor's @javax.inject.Inject binding is for HK2, Jersey's injection system,
   which injects the inner com.google.inject.Injector for Guice-bound classes
   */
  @Inject
  public InstrumentEndpoint(
    Injector injector
  ) {
    super(injector);
    dao = injector.getInstance(InstrumentDAO.class);
  }

  /**
   Get all instruments.

   @return application/json response.
   */
  @GET
  @RolesAllowed(UserRoleType.USER)
  public Response readAll(
    @Context ContainerRequestContext crc,
    @QueryParam("accountId") String accountId,
    @QueryParam("libraryId") String libraryId
  ) {
    if (null != libraryId && !libraryId.isEmpty()) {
      return readAllInLibrary(Access.fromContext(crc), libraryId);
    } else if (null != accountId && !accountId.isEmpty()) {
      return readAllInAccount(Access.fromContext(crc), accountId);
    } else {
      return readAll(Access.fromContext(crc));
    }
  }

  /**
   read all instruments in account

   @param access    control
   @param accountId account in which to read instruments
   @return all instruments in account
   */
  private Response readAllInAccount(Access access, String accountId) {
    try {
      return response.ok(
        new Payload().setDataEntities(
          dao().readAllInAccount(access, UUID.fromString(accountId))));

    } catch (Exception e) {
      return response.failure(e);
    }
  }

  /**
   read all instruments in library

   @param access    control
   @param libraryId library in which to read instruments
   @return all instruments in library
   */
  private Response readAllInLibrary(Access access, String libraryId) {
    try {
      return response.ok(
        new Payload().setDataEntities(
          dao().readMany(access, ImmutableList.of(UUID.fromString(libraryId)))));

    } catch (Exception e) {
      return response.failure(e);
    }
  }

  /**
   read all instruments in account

   @param access control
   @return all instruments
   */
  private Response readAll(Access access) {
    try {
      return response.ok(
        new Payload().setDataEntities(
          dao().readAll(access)));

    } catch (Exception e) {
      return response.failure(e);
    }
  }


  /**
   Create new instrument

   @param payload with which to update Instrument record.
   @return Response
   */
  @POST
  @Consumes(MediaType.APPLICATION_JSON_API)
  @RolesAllowed(UserRoleType.ARTIST)
  public Response create(Payload payload, @Context ContainerRequestContext crc, @QueryParam("cloneId") String cloneId) {

    try {
      Instrument instrument = dao().newInstance().consume(payload);
      Instrument created;
      if (Objects.nonNull(cloneId))
        created = dao().clone(
          Access.fromContext(crc),
          UUID.fromString(cloneId),
          instrument);
      else
        created = dao().create(
          Access.fromContext(crc),
          instrument);

      return response.create(new Payload().setDataEntity(created));

    } catch (Exception e) {
      return response.failureToCreate(e);
    }
  }


  /**
   Get one instrument.

   @return application/json response.
   */
  @GET
  @Path("{id}")
  @RolesAllowed(UserRoleType.USER)
  public Response readOne(@Context ContainerRequestContext crc, @PathParam("id") String id) {
    return readOne(crc, dao(), id);
  }

  /**
   Update one instrument

   @param payload with which to update Instrument record.
   @return Response
   */
  @PATCH
  @Path("{id}")
  @Consumes(MediaType.APPLICATION_JSON_API)
  @RolesAllowed(UserRoleType.ARTIST)
  public Response update(Payload payload, @Context ContainerRequestContext crc, @PathParam("id") String id) {
    return update(crc, dao(), id, payload);
  }

  /**
   Delete one instrument

   @return Response
   */
  @DELETE
  @Path("{id}")
  @RolesAllowed(UserRoleType.ADMIN)
  public Response delete(@Context ContainerRequestContext crc, @PathParam("id") String id) {
    return delete(crc, dao(), id);
  }

  /**
   Get DAO of injector

   @return DAO
   */
  private InstrumentDAO dao() {
    return dao;
  }
}