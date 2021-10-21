// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.hub.dao;

import io.xj.hub.access.HubAccess;
import io.xj.hub.enums.UserAuthType;
import io.xj.hub.tables.pojos.User;
import io.xj.hub.tables.pojos.UserAuth;
import io.xj.hub.tables.pojos.UserAuthToken;
import io.xj.lib.util.ValueException;

import java.util.UUID;

public interface UserDAO extends DAO<User> {

  /**
   Authenticates a User using external credentials:
   <p>
   1. Select existing UserAuth by type + account
   <p>
   a. If user_auth exists for this account,
   retrieve its user record and return the user
   <p>
   b. if no user_auth exists for this account,
   of a new user and user_auth record
   (storing access_token and refresh_token),
   and return the user

   @param authType             of external auth
   @param account              identifier in external system
   @param externalAccessToken  for OAuth2 access
   @param externalRefreshToken for refreshing OAuth2 access
   @param name                 to call user
   @param avatarUrl            to display for user
   @param email                to contact user
   @return access token
   */
  String authenticate(UserAuthType authType, String account, String externalAccessToken, String externalRefreshToken, String name, String avatarUrl, String email) throws DAOException;

  /**
   (ADMIN ONLY)
   Destroy all access tokens for a specified User@param userId to destroy all access tokens for.
   */
  void destroyAllTokens(UUID userId) throws DAOException;

  /**
   (ADMIN ONLY)
   Update a specified User's roles, and destroy all their tokens.@param userId of specific User to update.

   @param entity for the updated User.
   */
  void updateUserRolesAndDestroyTokens(HubAccess hubAccess, UUID userId, User entity) throws DAOException, ValueException;

  /**
   (ADMIN ONLY) read one user hubAccess token

   @param hubAccess   control
   @param accessToken to read
   @return model
   */
  UserAuthToken readOneAuthToken(HubAccess hubAccess, String accessToken) throws DAOException;

  /**
   (ADMIN ONLY) read one user auth

   @param hubAccess  control
   @param userAuthId to read
   @return model
   */
  UserAuth readOneAuth(HubAccess hubAccess, UUID userAuthId) throws DAOException;
}
