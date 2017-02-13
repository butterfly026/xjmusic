// Copyright Outright Mental, Inc. All Rights Reserved.
package io.outright.xj.hub.resource.audio_chord;

import io.outright.xj.core.CoreModule;
import io.outright.xj.core.app.access.AccessControl;
import io.outright.xj.core.app.server.HttpResponseProvider;
import io.outright.xj.core.dao.AudioChordDAO;
import io.outright.xj.core.model.audio_chord.AudioChord;
import io.outright.xj.core.model.audio_chord.AudioChordWrapper;
import io.outright.xj.core.model.role.Role;
import io.outright.xj.core.transport.JSON;

import com.google.inject.Guice;
import com.google.inject.Injector;
import org.jooq.types.ULong;
import org.json.JSONObject;

import javax.annotation.security.RolesAllowed;
import javax.jws.WebResult;
import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.container.ContainerRequestContext;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.io.IOException;

/**
 * AudioChord record
 */
@Path("audio-chords/{id}")
public class AudioChordRecordResource {
  private static final Injector injector = Guice.createInjector(new CoreModule());
  //  private static Logger log = LoggerFactory.getLogger(AudioChordRecordResource.class);
  private final AudioChordDAO audioChordDAO = injector.getInstance(AudioChordDAO.class);
  private final HttpResponseProvider httpResponseProvider = injector.getInstance(HttpResponseProvider.class);

  @PathParam("id")
  String id;

  /**
   * Get one audioChord.
   *
   * @return application/json response.
   */
  @GET
  @WebResult
  @RolesAllowed({Role.ARTIST})
  public Response readOne(@Context ContainerRequestContext crc) throws IOException {
    AccessControl access = AccessControl.fromContext(crc);

    try {
      JSONObject result = audioChordDAO.readOne(access, ULong.valueOf(id));
      if (result != null) {
        return Response
          .accepted(JSON.wrap(AudioChord.KEY_ONE, result).toString())
          .type(MediaType.APPLICATION_JSON)
          .build();
      } else {
        return httpResponseProvider.notFound("Audio Chord");
      }

    } catch (Exception e) {
      return httpResponseProvider.failure(e);
    }
  }

  /**
   * Update one audioChord
   *
   * @param data with which to update AudioChord record.
   * @return Response
   */
  @PUT
  @Consumes(MediaType.APPLICATION_JSON)
  @RolesAllowed({Role.ARTIST})
  public Response update(AudioChordWrapper data, @Context ContainerRequestContext crc) {
    AccessControl access = AccessControl.fromContext(crc);
    try {
      audioChordDAO.update(access, ULong.valueOf(id), data);
      return Response.accepted("{}").build();

    } catch (Exception e) {
      return httpResponseProvider.failureToUpdate(e);
    }
  }

  /**
   * Delete one audioChord
   *
   * @return Response
   */
  @DELETE
  @RolesAllowed({Role.ARTIST})
  public Response delete(@Context ContainerRequestContext crc) {
    AccessControl access = AccessControl.fromContext(crc);
    try {
      audioChordDAO.delete(access, ULong.valueOf(id));
      return Response.accepted("{}").build();

    } catch (Exception e) {
      return httpResponseProvider.failure(e);
    }
  }

}