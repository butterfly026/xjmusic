// Copyright (c) 2018, XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.hub.resource.account_user;

import com.google.common.collect.ImmutableList;

import io.xj.core.access.impl.Access;
import io.xj.core.dao.AccountUserDAO;
import io.xj.core.model.account_user.AccountUser;
import io.xj.core.model.account_user.AccountUserWrapper;
import io.xj.core.model.user_role.UserRoleType;
import io.xj.core.transport.HttpResponseProvider;
import io.xj.hub.HubResource;

import javax.annotation.security.RolesAllowed;
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
 Account record
 */
@Path("account-users")
public class AccountUserIndexResource extends HubResource {
  private final AccountUserDAO DAO = injector.getInstance(AccountUserDAO.class);
  private final HttpResponseProvider response = injector.getInstance(HttpResponseProvider.class);

  @QueryParam("accountId")
  String accountId;

  /**
   Get Users in one account.

   @return application/json response.
   */
  @GET
  @RolesAllowed({UserRoleType.USER})
  public Response readAll(@Context ContainerRequestContext crc) throws IOException {
    if (Objects.isNull(accountId) || accountId.isEmpty()) {
      return response.notAcceptable("Account id is required");
    }

    try {
      return response.readMany(
        AccountUser.KEY_MANY,
        DAO.readAll(
          Access.fromContext(crc),
          ImmutableList.of(new BigInteger(accountId))));

    } catch (Exception e) {
      return response.failure(e);
    }
  }

  /**
   Create new account user

   @param data with which to update Account record.
   @return Response
   */
  @POST
  @Consumes(MediaType.APPLICATION_JSON)
  @RolesAllowed({UserRoleType.ADMIN})
  public Response create(AccountUserWrapper data, @Context ContainerRequestContext crc) {
    try {
      return response.create(
        AccountUser.KEY_MANY,
        AccountUser.KEY_ONE,
        DAO.create(
          Access.fromContext(crc),
          data.getAccountUser()));

    } catch (Exception e) {
      return response.failureToCreate(e);
    }
  }

}
