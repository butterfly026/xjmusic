// Copyright (c) 2018, XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.hub.resource.chain_sequence;

import com.google.common.collect.ImmutableList;

import io.xj.core.access.impl.Access;
import io.xj.core.dao.ChainSequenceDAO;
import io.xj.core.model.chain_sequence.ChainSequence;
import io.xj.core.model.chain_sequence.ChainSequenceWrapper;
import io.xj.core.model.user_role.UserRoleType;
import io.xj.core.transport.HttpResponseProvider;
import io.xj.hub.HubResource;

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
import java.math.BigInteger;
import java.util.Objects;

/**
 Chain Sequence record
 */
@Path("chain-sequences")
public class ChainSequenceIndexResource extends HubResource {
  private final ChainSequenceDAO chainSequenceDAO = injector.getInstance(ChainSequenceDAO.class);
  private final HttpResponseProvider response = injector.getInstance(HttpResponseProvider.class);

  @QueryParam("chainId")
  String chainId;

  /**
   Get Sequences in one chain.

   @return application/json response.
   */
  @GET
  @WebResult
  @RolesAllowed(UserRoleType.USER)
  public Response readAll(@Context ContainerRequestContext crc) throws IOException {
    if (Objects.isNull(chainId) || chainId.isEmpty()) {
      return response.notAcceptable("Chain id is required");
    }

    try {
      return response.readMany(
        ChainSequence.KEY_MANY,
        chainSequenceDAO.readAll(
          Access.fromContext(crc),
          ImmutableList.of(new BigInteger(chainId))));

    } catch (Exception e) {
      return response.failure(e);
    }
  }

  /**
   Create new chain sequence

   @param data with which to update Chain record.
   @return Response
   */
  @POST
  @Consumes(MediaType.APPLICATION_JSON)
  @RolesAllowed({UserRoleType.ARTIST, UserRoleType.ENGINEER, UserRoleType.ADMIN})
  public Response create(ChainSequenceWrapper data, @Context ContainerRequestContext crc) {
    try {
      return response.create(
        ChainSequence.KEY_MANY,
        ChainSequence.KEY_ONE,
        chainSequenceDAO.create(
          Access.fromContext(crc),
          data.getChainSequence()));

    } catch (Exception e) {
      return response.failureToCreate(e);
    }
  }

}