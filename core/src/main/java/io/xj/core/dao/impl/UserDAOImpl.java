// Copyright (c) 2017, XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.core.dao.impl;

import io.xj.core.access.AccessControlProvider;
import io.xj.core.access.impl.Access;
import io.xj.core.dao.UserDAO;
import io.xj.core.exception.AccessException;
import io.xj.core.exception.BusinessException;
import io.xj.core.exception.DatabaseException;
import io.xj.core.model.account_user.AccountUser;
import io.xj.core.model.user.User;
import io.xj.core.model.user_access_token.UserAccessToken;
import io.xj.core.model.user_auth.UserAuth;
import io.xj.core.model.user_auth.UserAuthType;
import io.xj.core.model.user_role.UserRole;
import io.xj.core.model.user_role.UserRoleType;
import io.xj.core.persistence.sql.SQLDatabaseProvider;
import io.xj.core.persistence.sql.impl.SQLConnection;
import io.xj.core.tables.records.UserAccessTokenRecord;
import io.xj.core.tables.records.UserAuthRecord;
import io.xj.core.tables.records.UserRecord;
import io.xj.core.tables.records.UserRoleRecord;
import io.xj.core.transport.CSV;

import org.jooq.DSLContext;
import org.jooq.Field;
import org.jooq.Result;
import org.jooq.SelectSelectStep;
import org.jooq.types.ULong;

import com.google.api.client.util.Maps;
import com.google.common.collect.Lists;
import com.google.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.annotation.Nullable;
import java.math.BigInteger;
import java.util.Collection;
import java.util.Map;
import java.util.Objects;

import static io.xj.core.Tables.ACCOUNT_USER;
import static io.xj.core.Tables.USER;
import static io.xj.core.Tables.USER_ACCESS_TOKEN;
import static io.xj.core.Tables.USER_AUTH;
import static io.xj.core.Tables.USER_ROLE;
import static org.jooq.impl.DSL.groupConcat;

/**
 NOTE: THIS IS AN IRREGULAR D.A.O.
 <p>
 Conceptually, because being a User is a dependency of all other DAOs.
 */
public class UserDAOImpl extends DAOImpl implements UserDAO {
  private static final Logger log = LoggerFactory.getLogger(UserDAOImpl.class);

  private final AccessControlProvider accessControlProvider;

  @Inject
  public UserDAOImpl(
    SQLDatabaseProvider dbProvider,
    AccessControlProvider accessControlProvider
  ) {
    this.dbProvider = dbProvider;
    this.accessControlProvider = accessControlProvider;
  }

  @Override
  public String authenticate(UserAuthType authType, String account, String externalAccessToken, String externalRefreshToken, String name, String avatarUrl, String email) throws AccessException, DatabaseException, BusinessException {
    SQLConnection tx = dbProvider.getConnection(true);

    Collection<AccountUser> accounts;
    Collection<UserRole> roles;
    UserAuth userAuth = readOneAuth(tx.getContext(), authType, account);
    if (Objects.nonNull(userAuth)) {
      accounts = fetchAccounts(tx.getContext(), ULong.valueOf(userAuth.getUserId()));
      roles = fetchRoles(tx.getContext(), ULong.valueOf(userAuth.getUserId()));
    } else {
      try {
        UserRecord user = newUser(tx.getContext(), name, avatarUrl, email);
        accounts = Lists.newArrayList();
        roles = newRoles(tx.getContext(), user.getId());
        userAuth = newUserAuth(tx.getContext(), user.getId(), authType, account, externalAccessToken, externalRefreshToken);
      } catch (Exception e) {
        throw tx.failure(new AccessException(e));
      }
    }

    String accessToken = accessControlProvider.create(userAuth, accounts, roles);
    try {
      newUserAccessTokenRecord(tx.getContext(),
        ULong.valueOf(userAuth.getUserId()),
        ULong.valueOf(userAuth.getId()),
        accessToken
      );
    } catch (Exception e) {
      throw tx.failure(new AccessException(e));
    }

    try {
      return tx.success(accessToken);
    } catch (DatabaseException e) {
      throw tx.failure(new AccessException(e));
    }
  }

  @Override
  public User readOne(Access access, BigInteger userId) throws Exception {
    SQLConnection tx = dbProvider.getConnection();
    try {
      return tx.success(readOne(tx.getContext(), access, ULong.valueOf(userId)));
    } catch (Exception e) {
      throw tx.failure(e);
    }
  }

  @Nullable
  public Collection<User> readAll(Access access) throws Exception {
    SQLConnection tx = dbProvider.getConnection();
    try {
      return tx.success(readAll(tx.getContext(), access));
    } catch (Exception e) {
      throw tx.failure(e);
    }
  }

  @Override
  public UserAccessToken readOneAccessToken(Access access, String accessToken) throws Exception {
    SQLConnection tx = dbProvider.getConnection();
    try {
      return tx.success(readOneAccessToken(tx.getContext(), access, accessToken));
    } catch (Exception e) {
      throw tx.failure(e);
    }
  }

  @Override
  public UserAuth readOneAuth(Access access, BigInteger userAuthId) throws Exception {
    SQLConnection tx = dbProvider.getConnection();
    try {
      return tx.success(readOneAuth(tx.getContext(), access, ULong.valueOf(userAuthId)));
    } catch (Exception e) {
      throw tx.failure(e);
    }
  }

  @Override
  public UserRole readOneRole(Access access, BigInteger userId, UserRoleType type) throws Exception {
    SQLConnection tx = dbProvider.getConnection();
    try {
      return tx.success(readOneRole(tx.getContext(), access, ULong.valueOf(userId), type));
    } catch (Exception e) {
      throw tx.failure(e);
    }
  }


  @Override
  public void destroyAllTokens(BigInteger userId) throws Exception {
    SQLConnection tx = dbProvider.getConnection();
    try {
      destroyAllTokens(tx.getContext(), ULong.valueOf(userId));
      tx.success();
    } catch (Exception e) {
      throw tx.failure(e);
    }
  }

  @Override
  public void updateUserRolesAndDestroyTokens(Access access, BigInteger userId, User entity) throws Exception {
    SQLConnection tx = dbProvider.getConnection();

    try {
      requireTopLevel(access);
      updateUserRoles(tx.getContext(), ULong.valueOf(userId), entity);
      destroyAllTokens(tx.getContext(), ULong.valueOf(userId));
      tx.success();
    } catch (Exception e) {
      throw tx.failure(e);
    }
  }

  /**
   This is used to select many User records
   with a virtual column containing a CSV of its role types

   @param db context
   @return jOOQ select step
   */
  private static SelectSelectStep<?> select(DSLContext db) {
    return db.select(
      USER.ID,
      USER.NAME,
      USER.AVATAR_URL,
      USER.EMAIL,
      USER.CREATED_AT,
      USER.UPDATED_AT,
      USER_ROLE.USER_ID,
      groupConcat(USER_ROLE.TYPE, ",").as(User.KEY_ROLES)
    );
  }

  /**
   New UserAccessToken record

   @param db          context
   @param userId      user record id
   @param userAuthId  userAuth record id
   @param accessToken for user access to this system
   @throws Exception if anything goes wrong
   */
  private static void newUserAccessTokenRecord(DSLContext db, ULong userId, ULong userAuthId, String accessToken) throws Exception {
    UserAccessTokenRecord userAccessToken = db.insertInto(USER_ACCESS_TOKEN,
      USER_ACCESS_TOKEN.USER_ID,
      USER_ACCESS_TOKEN.USER_AUTH_ID,
      USER_ACCESS_TOKEN.ACCESS_TOKEN
    ).values(
      userId,
      userAuthId,
      accessToken
    ).returning(
      USER_ACCESS_TOKEN.ID,
      USER_ACCESS_TOKEN.USER_ID,
      USER_ACCESS_TOKEN.USER_AUTH_ID,
      USER_ACCESS_TOKEN.ACCESS_TOKEN
    ).fetchOne();
    if (Objects.isNull(userAccessToken)) {
      throw new DatabaseException("Failed to create new UserAccessToken record.");
    }

    log.info("Created new UserAccessToken, id:{}, userId:{}, userAuthId:{}, accessToken:{}", userAccessToken.getId(), userAccessToken.getUserId(), userAccessToken.getUserAuthId(), userAccessToken.getAccessToken());
  }

  /**
   If no user_auth isNonNull for this account,
   create a new user and user_auth record
   (storing access_token and refresh_token),
   and return the user

   @param db        context of authentication request
   @param name      to call new user
   @param avatarUrl to display for new user
   @param email     to contact new user
   @return new User record, including actual id
   */
  private static UserRecord newUser(DSLContext db, String name, String avatarUrl, String email) throws Exception {
    UserRecord user = db.insertInto(USER, USER.NAME, USER.AVATAR_URL, USER.EMAIL)
      .values(name, avatarUrl, email)
      .returning(USER.ID, USER.NAME, USER.AVATAR_URL, USER.EMAIL)
      .fetchOne();
    if (Objects.isNull(user)) {
      throw new DatabaseException("Failed to create new User record.");
    }

    log.info("Created new User, id:{}, name:{}, email:{}", user.getId(), user.getName(), user.getEmail());
    return user;
  }

  /**
   Create a new default set of UserRoleRecord for an existing new User id.

   @param db     context of authentication request
   @param userId of new User.
   @return collection of new UserRole records, including actual id
   */
  private static Collection<UserRole> newRoles(DSLContext db, ULong userId) throws Exception {
    UserRoleRecord userRole1 = db.insertInto(USER_ROLE, USER_ROLE.USER_ID, USER_ROLE.TYPE)
      .values(userId, UserRoleType.User.toString())
      .returning(USER_ROLE.ID, USER_ROLE.USER_ID, USER_ROLE.TYPE)
      .fetchOne();
    if (Objects.isNull(userRole1)) {
      throw new DatabaseException("Failed to create new UserRole record.");
    }

    log.info("Created new UserRole, id:{}, userId:{}, type:{}", userRole1.getId(), userRole1.getUserId(), userRole1.getType());
    Collection<UserRole> roles = Lists.newArrayList();
    roles.add(modelFrom(userRole1, UserRole.class));
    return roles;
  }

  /**
   If user_auth isNonNull for this account,
   retrieve its user record and return the user

   @param db                   context of authentication request
   @param userId               of User that this auth record belongs to
   @param authType             of external auth
   @param account              identifier in external system
   @param externalAccessToken  for OAuth2 access
   @param externalRefreshToken for refreshing OAuth2 access
   @return new UserAuth record, including actual id
   */
  private static UserAuth newUserAuth(DSLContext db, ULong userId, UserAuthType authType, String account, String externalAccessToken, String externalRefreshToken) throws Exception {
    UserAuthRecord userAuth = db.insertInto(USER_AUTH, USER_AUTH.USER_ID, USER_AUTH.TYPE, USER_AUTH.EXTERNAL_ACCOUNT, USER_AUTH.EXTERNAL_ACCESS_TOKEN, USER_AUTH.EXTERNAL_REFRESH_TOKEN)
      .values(userId, authType.toString(), account, externalAccessToken, externalRefreshToken)
      .returning(USER_AUTH.ID, USER_AUTH.USER_ID, USER_AUTH.TYPE, USER_AUTH.EXTERNAL_ACCOUNT, USER_AUTH.EXTERNAL_ACCESS_TOKEN, USER_AUTH.EXTERNAL_REFRESH_TOKEN)
      .fetchOne();
    if (Objects.isNull(userAuth)) {
      throw new DatabaseException("Failed to create new UserAuth record.");
    }

    log.info("Created new UserAuth, id:{}, userId:{}, type:{}, account:{}", userAuth.getId(), userAuth.getUserId(), userAuth.getType(), userAuth.getExternalAccount());
    return modelFrom(userAuth, UserAuth.class);
  }

  /**
   Select existing Account-User memberships by User id.

   @param db     context of database access.
   @param userId of existing User.
   @return collection of AccountUserRecord.
   */
  private static Collection<AccountUser> fetchAccounts(DSLContext db, ULong userId) throws BusinessException {
    return modelsFrom(db.selectFrom(ACCOUNT_USER)
      .where(ACCOUNT_USER.USER_ID.equal(userId))
      .fetch(), AccountUser.class);
  }

  /**
   Select existing User roles by User id.

   @param db     context of database access.
   @param userId of existing User.
   @return collection of UserRoleRecord.
   */
  private static Collection<UserRole> fetchRoles(DSLContext db, ULong userId) throws BusinessException {
    return modelsFrom(db.selectFrom(USER_ROLE)
      .where(USER_ROLE.USER_ID.equal(userId))
      .fetch(), UserRole.class);
  }


  /**
   Read one record

   @param db     context
   @param access control
   @param userId to readMany
   @return user
   */
  private static User readOne(DSLContext db, Access access, ULong userId) throws BusinessException {
    if (access.isTopLevel()) {
      return modelFrom(select(db)
        .from(USER_ROLE)
        .join(USER).on(USER.ID.eq(USER_ROLE.USER_ID))
        .where(USER_ROLE.USER_ID.equal(userId))
        .groupBy(USER_ROLE.USER_ID)
        .fetchOne(), User.class);
    } else if (!access.getAccountIds().isEmpty()) {
      return modelFrom(select(db)
        .from(USER_ROLE)
        .join(USER).on(USER.ID.eq(USER_ROLE.USER_ID))
        .join(ACCOUNT_USER).on(ACCOUNT_USER.USER_ID.eq(USER_ROLE.USER_ID))
        .where(USER_ROLE.USER_ID.equal(userId))
        .and(ACCOUNT_USER.ACCOUNT_ID.in(access.getAccountIds()))
        .groupBy(USER_ROLE.USER_ID)
        .fetchOne(), User.class);
    } else if (ULong.valueOf(access.getUserId()).equals(userId)) {
      return modelFrom(select(db)
        .from(USER_ROLE)
        .join(USER).on(USER.ID.eq(USER_ROLE.USER_ID))
        .where(USER_ROLE.USER_ID.equal(userId))
        .groupBy(USER_ROLE.USER_ID)
        .fetchOne(), User.class);
    } else {
      return null;
    }
  }

  /**
   Read all records

   @param db     context
   @param access control
   @return array of records
   */
  private static Collection<User> readAll(DSLContext db, Access access) throws BusinessException {
    if (access.isTopLevel()) {
      return modelsFrom(select(db)
        .from(USER_ROLE)
        .join(USER).on(USER.ID.eq(USER_ROLE.USER_ID))
        .groupBy(USER_ROLE.USER_ID)
        .fetch(), User.class);
    } else if (!access.getAccountIds().isEmpty()) {
      return modelsFrom(select(db)
        .from(USER_ROLE)
        .join(USER).on(USER.ID.eq(USER_ROLE.USER_ID))
        .join(ACCOUNT_USER).on(ACCOUNT_USER.USER_ID.eq(USER_ROLE.USER_ID))
        .where(ACCOUNT_USER.ACCOUNT_ID.in(access.getAccountIds()))
        .groupBy(USER.ID)
        .fetch(), User.class);
    } else {
      return modelsFrom(select(db)
        .from(USER_ROLE)
        .join(USER).on(USER.ID.eq(USER_ROLE.USER_ID))
        .where(USER_ROLE.USER_ID.eq(ULong.valueOf(access.getUserId())))
        .groupBy(USER.ID)
        .fetch(), User.class);
    }
  }


  /**
   Read one user access token

   @param db          context
   @param access      control
   @param accessToken to read
   @return user access token
   */
  private static UserAccessToken readOneAccessToken(DSLContext db, Access access, String accessToken) throws BusinessException {
    requireTopLevel(access);

    return modelFrom(db.select(USER_ACCESS_TOKEN.fields())
      .from(USER_ACCESS_TOKEN)
      .where(USER_ACCESS_TOKEN.ACCESS_TOKEN.equal(accessToken))
      .fetchOne(), UserAccessToken.class);
  }

  /**
   Read one user auth

   @param db         context
   @param access     control
   @param userAuthId to read
   @return user auth
   */
  private static UserAuth readOneAuth(DSLContext db, Access access, ULong userAuthId) throws BusinessException {
    requireTopLevel(access);

    return modelFrom(db.select(USER_AUTH.fields())
      .from(USER_AUTH)
      .where(USER_AUTH.ID.equal(userAuthId))
      .fetchOne(), UserAuth.class);
  }

  /**
   Read one user role

   @param db     context
   @param access control
   @param userId having role
   @param type   of role
   @return user role
   */
  private static UserRole readOneRole(DSLContext db, Access access, ULong userId, UserRoleType type) throws BusinessException {
    requireTopLevel(access);

    return modelFrom(db.select(USER_ROLE.fields())
      .from(USER_ROLE)
      .where(USER_ROLE.USER_ID.eq(userId))
      .and(USER_ROLE.TYPE.eq(type.toString()))
      .fetchOne(), UserRole.class);
  }

  /**
   Select existing UserAuth by type + account
   <p>
   NOTE: DON'T REQUIRE ANY ACCESS

   @param db              context of authentication request
   @param authType        of external auth
   @param externalAccount identifier in external system
   @return UserAuth, or null
   */
  private static UserAuth readOneAuth(DSLContext db, UserAuthType authType, String externalAccount) throws BusinessException {
    return modelFrom(db.selectFrom(USER_AUTH)
      .where(USER_AUTH.TYPE.equal(authType.toString()))
      .and(USER_AUTH.EXTERNAL_ACCOUNT.equal(externalAccount))
      .fetchOne(), UserAuth.class);
  }


  /**
   Update all roles for a specified User, by providing a list of roles to grant;
   all other roles will be denied to this User.

   @param db     context.
   @param userId specific User to update.
   @param entity to update with
   */
  private static void updateUserRoles(DSLContext db, ULong userId, User entity) throws BusinessException {
    entity.validate();

    // Prepare key entity
    String userIdString = String.valueOf(userId);
    Collection<String> newRoles = CSV.split(entity.getRoles());

    // First check all provided roles for validity.
    for (String checkRole : newRoles) {
      UserRoleType.validate(checkRole);
    }

    // Iterate through all rows; each will produce either an INSERT WHERE NOT EXISTS or a DELETE IF EXISTS.
    for (String role : UserRoleType.stringValues()) {
      if (newRoles.contains(role)) {
        db.execute("INSERT INTO `user_role` (`user_id`, `type`) " +
          "SELECT " + userIdString + ", \"" + role + "\" FROM dual " +
          "WHERE NOT EXISTS (" +
          "SELECT `id` FROM `user_role` " +
          "WHERE `user_id`=" + userIdString + " " +
          "AND `type`=\"" + role + "\"" +
          ");");
      } else {
        db.deleteFrom(USER_ROLE)
          .where(USER_ROLE.USER_ID.eq(userId))
          .and(USER_ROLE.TYPE.eq(role))
          .execute();
      }
    }
  }

  /**
   Destroy all access tokens for a specified User

   @param userId to destroy all access tokens for.
   */
  private void destroyAllTokens(DSLContext db, ULong userId) throws Exception {
    Result<UserAccessTokenRecord> userAccessTokens = db.selectFrom(USER_ACCESS_TOKEN)
      .where(USER_ACCESS_TOKEN.USER_ID.eq(userId))
      .fetch();
    for (UserAccessTokenRecord userAccessToken : userAccessTokens) {
      destroyToken(db, userAccessToken);
    }
  }

  /**
   Destroy an access token, first in Redis, then (if successful) in SQL.

   @param db              context
   @param userAccessToken record of user access token to destroy
   */
  private void destroyToken(DSLContext db, UserAccessTokenRecord userAccessToken) throws Exception {
    accessControlProvider.expire(userAccessToken.getAccessToken());
    db.deleteFrom(USER_ACCESS_TOKEN)
      .where(USER_ACCESS_TOKEN.ID.eq(userAccessToken.getId()))
      .execute();
    log.info("Deleted UserAccessToken, id:{}, userId:{}, userAuthId:{}, accessToken:{}", userAccessToken.getId(), userAccessToken.getUserId(), userAccessToken.getUserAuthId(), userAccessToken.getAccessToken());
  }

  /**
   Only certain (writable) fields are mapped back to jOOQ records--
   Read-only fields are excluded from here.

   @param entity to source values from
   @return values mapped to record fields
   */
  public static Map<Field, Object> fieldValueMap(User entity) {
    Map<Field, Object> fieldValues = Maps.newHashMap();
    fieldValues.put(USER.NAME, entity.getName());
    fieldValues.put(USER.AVATAR_URL, entity.getAvatarUrl());
    fieldValues.put(USER.EMAIL, entity.getEmail());
    return fieldValues;
  }

}
