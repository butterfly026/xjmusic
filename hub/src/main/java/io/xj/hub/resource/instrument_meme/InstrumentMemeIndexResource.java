// Copyright (c) 2017, Outright Mental Inc. (http://outright.io) All Rights Reserved.
package io.xj.hub.resource.instrument_meme;

import io.xj.core.CoreModule;
import io.xj.core.app.access.impl.Access;
import io.xj.core.app.server.HttpResponseProvider;
import io.xj.core.dao.InstrumentMemeDAO;
import io.xj.core.model.instrument_meme.InstrumentMeme;
import io.xj.core.model.instrument_meme.InstrumentMemeWrapper;
import io.xj.core.model.role.Role;

import org.jooq.types.ULong;

import com.google.inject.Guice;
import com.google.inject.Injector;

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
 Instrument record
 */
@Path("instrument-memes")
public class InstrumentMemeIndexResource {
  private static final Injector injector = Guice.createInjector(new CoreModule());
  private final InstrumentMemeDAO DAO = injector.getInstance(InstrumentMemeDAO.class);
  private final HttpResponseProvider response = injector.getInstance(HttpResponseProvider.class);

  @QueryParam("instrumentId")
  String instrumentId;

  /**
   Get Memes in one instrument.

   @return application/json response.
   */
  @GET
  @WebResult
  @RolesAllowed({Role.ARTIST})
  public Response readAll(@Context ContainerRequestContext crc) throws IOException {

    if (instrumentId == null || instrumentId.length() == 0) {
      return response.notAcceptable("Instrument id is required");
    }

    try {
      return response.readMany(
        InstrumentMeme.KEY_MANY,
        DAO.readAll(
          Access.fromContext(crc),
          ULong.valueOf(instrumentId)));

    } catch (Exception e) {
      return response.failure(e);
    }
  }

  /**
   Create new instrument meme

   @param data with which to update Instrument record.
   @return Response
   */
  @POST
  @Consumes(MediaType.APPLICATION_JSON)
  @RolesAllowed({Role.ARTIST})
  public Response create(InstrumentMemeWrapper data, @Context ContainerRequestContext crc) {
    try {
      return response.create(
        InstrumentMeme.KEY_MANY,
        InstrumentMeme.KEY_ONE,
        DAO.create(
          Access.fromContext(crc),
          data.getInstrumentMeme()));

    } catch (Exception e) {
      return response.failureToCreate(e);
    }
  }

}