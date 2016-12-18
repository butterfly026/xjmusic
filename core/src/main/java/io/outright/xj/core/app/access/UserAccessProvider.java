// Copyright Outright Mental, Inc. All Rights Reserved.
package io.outright.xj.core.app.access;

import io.outright.xj.core.app.exception.AccessException;
import io.outright.xj.core.tables.records.AccountUserRecord;
import io.outright.xj.core.tables.records.UserAuthRecord;
import io.outright.xj.core.tables.records.UserRoleRecord;

import javax.ws.rs.core.NewCookie;
import java.util.Collection;

public interface UserAccessProvider {
  /**
   * Create a token to grant a user access to resources.
   *
   * @param userAuthRecord to create a token for.
   * @param userRoleRecords roles that this user has access to.
   * @param userAccountRecords accounts that this user has access to.
   * @return access token
   */
  String create(UserAuthRecord userAuthRecord, Collection<AccountUserRecord> userAccountRecords, Collection<UserRoleRecord> userRoleRecords) throws AccessException;

  /**
   * Expire an access token.
   *
   * @param token to expire.
   */
  void expire(String token);

  /**
   * Fetch a token to determine if it is valid,
   * and what user it grants access to.
   *
   * @param token to fetch.
   * @return User who is granted access by this token
   */
  UserAccess get(String token) throws AccessException;

  /**
   * Create a new cookie to set access token.
   *
   * @param accessToken to set a cookie for.
   * @return new cookie to set access token.
   */
  NewCookie newCookie(String accessToken);
}
