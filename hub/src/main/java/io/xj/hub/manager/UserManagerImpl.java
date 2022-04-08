// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.hub.manager;

import com.google.common.collect.Lists;
import com.google.common.collect.Sets;
import com.google.inject.Inject;
import io.xj.hub.access.HubAccess;
import io.xj.hub.access.HubAccessControlProvider;
import io.xj.hub.access.HubAccessException;
import io.xj.hub.enums.UserAuthType;
import io.xj.hub.enums.UserRoleType;
import io.xj.hub.persistence.HubDatabaseProvider;
import io.xj.hub.persistence.HubPersistenceServiceImpl;
import io.xj.hub.tables.pojos.AccountUser;
import io.xj.hub.tables.pojos.User;
import io.xj.hub.tables.pojos.UserAuth;
import io.xj.hub.tables.pojos.UserAuthToken;
import io.xj.hub.tables.records.UserAuthRecord;
import io.xj.hub.tables.records.UserAuthTokenRecord;
import io.xj.hub.tables.records.UserRecord;
import io.xj.lib.entity.EntityFactory;
import io.xj.lib.util.CSV;
import io.xj.lib.util.ValueException;
import io.xj.lib.util.Values;
import org.jooq.DSLContext;
import org.jooq.Result;
import org.jooq.SelectSelectStep;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.annotation.Nullable;
import java.util.Collection;
import java.util.Objects;
import java.util.Set;
import java.util.UUID;
import java.util.stream.Collectors;

import static io.xj.hub.Tables.*;

public class UserManagerImpl extends HubPersistenceServiceImpl<User> implements UserManager {
  private static final Logger log = LoggerFactory.getLogger(UserManagerImpl.class);
  private final HubAccessControlProvider hubAccessControlProvider;

  @Inject
  public UserManagerImpl(
    EntityFactory entityFactory,
    HubDatabaseProvider dbProvider,
    HubAccessControlProvider hubAccessControlProvider
  ) {
    super(entityFactory, dbProvider);
    this.hubAccessControlProvider = hubAccessControlProvider;
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
      USER.ROLES
    );
  }

  /**
   of UserAuthToken record

   @param db          context
   @param userId      user record id
   @param userAuthId  userAuth record id
   @param accessToken for user access to this system
   @throws ManagerException if anything goes wrong
   */
  private static void newUserAuthTokenRecord(DSLContext db, UUID userId, UUID userAuthId, String accessToken) throws ManagerException {
    UserAuthTokenRecord userAccessToken = db.insertInto(USER_AUTH_TOKEN,
      USER_AUTH_TOKEN.USER_ID,
      USER_AUTH_TOKEN.USER_AUTH_ID,
      USER_AUTH_TOKEN.ACCESS_TOKEN
    ).values(
      userId,
      userAuthId,
      accessToken
    ).returning(
      USER_AUTH_TOKEN.ID,
      USER_AUTH_TOKEN.USER_ID,
      USER_AUTH_TOKEN.USER_AUTH_ID,
      USER_AUTH_TOKEN.ACCESS_TOKEN
    ).fetchOne();
    if (Objects.isNull(userAccessToken)) {
      throw new ManagerException("Failed to create new UserAuthToken record.");
    }

    log.info("Created new userAuthTokenId={}, userId={}, userAuthId={}, accessToken={}", userAccessToken.getId(), userAccessToken.getUserId(), userAccessToken.getUserAuthId(), userAccessToken.getAccessToken());
  }

  /**
   If no user_auth isNonNull for this account,
   of a new user and user_auth record
   (storing access_token and refresh_token),
   and return the user

   @param db        context of authentication request
   @param name      to call new user
   @param avatarUrl to display for new user
   @param email     to contact new user
   @return new User record, including actual id
   */
  private User newUser(DSLContext db, String name, String avatarUrl, String email) throws ManagerException {
    UserRecord user = db.insertInto(USER, USER.NAME, USER.AVATAR_URL, USER.EMAIL)
      .values(name, avatarUrl, email)
      .returning(USER.ID, USER.NAME, USER.AVATAR_URL, USER.EMAIL)
      .fetchOne();
    if (Objects.isNull(user)) {
      throw new ManagerException("Failed to create new User record.");
    }

    log.info("Created new User, id={}, name={}, email={}", user.getId(), user.getName(), user.getEmail());
    return modelFrom(user);
  }

  /**
   Select existing AccountUser memberships by User id.

   @param db     context of database access.
   @param userId of existing User.
   @return collection of AccountUserRecord.
   */
  private Collection<AccountUser> fetchAccounts(DSLContext db, UUID userId) throws ManagerException {
    return modelsFrom(AccountUser.class, db.selectFrom(ACCOUNT_USER)
      .where(ACCOUNT_USER.USER_ID.equal(userId))
      .fetch());
  }

  /**
   Select existing user by id

   @param db context
   @param id of user
   @return user
   @throws ManagerException on failure
   */
  private User fetchUser(DSLContext db, UUID id) throws ManagerException {
    return modelFrom(User.class, select(db)
      .from(USER)
      .where(USER.ID.eq(id))
      .fetchOne());
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
  private UserAuth readOneAuth(DSLContext db, UserAuthType authType, String externalAccount) throws ManagerException {
    return modelFrom(UserAuth.class, db.selectFrom(USER_AUTH)
      .where(USER_AUTH.TYPE.equal(authType))
      .and(USER_AUTH.EXTERNAL_ACCOUNT.equal(externalAccount))
      .fetchOne());
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
  private UserAuth newUserAuth(DSLContext db, String userId, UserAuthType authType, String account, String externalAccessToken, String externalRefreshToken) throws ManagerException {
    UserAuthRecord userAuth = db.insertInto(USER_AUTH, USER_AUTH.USER_ID, USER_AUTH.TYPE, USER_AUTH.EXTERNAL_ACCOUNT, USER_AUTH.EXTERNAL_ACCESS_TOKEN, USER_AUTH.EXTERNAL_REFRESH_TOKEN)
      .values(UUID.fromString(userId), authType, account, externalAccessToken, externalRefreshToken)
      .returning(USER_AUTH.ID, USER_AUTH.USER_ID, USER_AUTH.TYPE, USER_AUTH.EXTERNAL_ACCOUNT, USER_AUTH.EXTERNAL_ACCESS_TOKEN, USER_AUTH.EXTERNAL_REFRESH_TOKEN)
      .fetchOne();
    if (Objects.isNull(userAuth)) {
      throw new ManagerException("Failed to create new UserAuth record.");
    }

    log.info("Created new UserAuth, id={}, userId={}, type={}, account={}", userAuth.getId(), userAuth.getUserId(), userAuth.getType(), userAuth.getExternalAccount());
    return modelFrom(UserAuth.class, userAuth);
  }

  @Override
  public String authenticate(UserAuthType authType, String account, String externalAccessToken, String externalRefreshToken, String name, String avatarUrl, String email) throws ManagerException {
    DSLContext db = dbProvider.getDSL();
    Collection<AccountUser> accounts;
    UserAuth userAuth;
    User user;

    // attempt to find existing user
    try {
      userAuth = readOneAuth(db, authType, account);
      user = fetchUser(db, userAuth.getUserId());
      accounts = fetchAccounts(db, userAuth.getUserId());

    } catch (ManagerException ignored) {
      // no user exists; create one
      try {
        user = newUser(db, name, avatarUrl, email);
        accounts = Lists.newArrayList();
        userAuth = newUserAuth(db, user.getId().toString(), authType, account, externalAccessToken, externalRefreshToken);
      } catch (Exception e) {
        throw new ManagerException("SQL Exception", e);
      }
    }

    try {
      String accessToken = hubAccessControlProvider.create(user, userAuth, accounts);
      newUserAuthTokenRecord(db,
        userAuth.getUserId(),
        userAuth.getId(),
        accessToken);
      return accessToken;

    } catch (HubAccessException e) {
      throw new ManagerException("Cannot authenticate!", e);
    }
  }

  @Override
  public User create(HubAccess access, User entity) throws ManagerException {
    throw new ManagerException("Not allowed to create a User record (must implement 'authenticate' method).");

  }

  @Override
  public User readOne(HubAccess access, UUID id) throws ManagerException {
    DSLContext db = dbProvider.getDSL();
    if (access.isTopLevel()) {
      return modelFrom(User.class, select(db)
        .from(USER)
        .where(USER.ID.eq(id))
        .fetchOne());
    } else if (!access.getAccountIds().isEmpty()) {
      return modelFrom(User.class, db.select(USER.fields())
        .from(USER)
        .join(ACCOUNT_USER).on(ACCOUNT_USER.USER_ID.eq(id))
        .where(USER.ID.eq(id))
        .and(ACCOUNT_USER.ACCOUNT_ID.in(access.getAccountIds()))
        .limit(1)
        .fetchOne());
    } else {
      if (Objects.equals(access.getUserId(), id)) {
        return modelFrom(User.class, select(db)
          .from(USER)
          .where(USER.ID.eq(id))
          .fetchOne());
      } else {
        throw new ManagerException("Not found");
      }
    }
  }

  @Override
  @Nullable
  public Collection<User> readMany(HubAccess access, Collection<UUID> parentIds) throws ManagerException {
    DSLContext db = dbProvider.getDSL();
    if (access.isTopLevel()) {
      return modelsFrom(User.class, select(db)
        .from(USER)
        .fetch());

    } else if (!access.getAccountIds().isEmpty()) {
      return modelsFrom(User.class, select(db)
        .from(USER)
        .join(ACCOUNT_USER).on(ACCOUNT_USER.USER_ID.eq(USER.ID))
        .where(ACCOUNT_USER.ACCOUNT_ID.in(access.getAccountIds()))
        .groupBy(USER.ID)
        .fetch());

    } else return modelsFrom(User.class, select(db)
      .from(USER)
      .where(USER.ID.eq(Objects.requireNonNull(access.getUserId())))
      .groupBy(USER.ID)
      .fetch());
  }

  @Override
  public User update(HubAccess access, UUID id, User entity) throws ManagerException {
    // FUTURE figure out how to make this all a rollback-able transaction in the new getDataSource() context: dataSource.commit(); and dataSource.setAutoCommit(false);
    requireTopLevel(access);
    validate(entity);// Prepare key entity
    Collection<String> rawRoles = CSV.splitProperSlug(entity.getRoles());

    // First check all provided roles for validity.
    Set<UserRoleType> validRoles = Sets.newHashSet();
    for (String checkRole : rawRoles)
      try {
        validRoles.add(UserRoleType.valueOf(checkRole));
      } catch (NullPointerException | IllegalArgumentException e) {
        throw new ManagerException(e);
      }
    requireAny("At least one valid role", !validRoles.isEmpty());
    entity.setRoles(validRoles.stream()
      .sorted(Enum::compareTo)
      .map(UserRoleType::toString)
      .collect(Collectors.joining(", ")));

    // Update the user record, and destroy all tokens
    DSLContext db = dbProvider.getDSL();
    executeUpdate(db, USER, id, entity);
    destroyAllTokens(db, id);
    return entity;
  }

  @Override
  public void destroy(HubAccess access, UUID id) throws ManagerException {
    throw new ManagerException("Not allowed to destroy User record.");
  }

  @Override
  public User newInstance() {
    return new User();
  }

  @Override
  public UserAuthToken readOneAuthToken(HubAccess access, String accessToken) throws ManagerException {
    requireTopLevel(access);

    return modelFrom(UserAuthToken.class, dbProvider.getDSL().select(USER_AUTH_TOKEN.fields())
      .from(USER_AUTH_TOKEN)
      .where(USER_AUTH_TOKEN.ACCESS_TOKEN.equal(accessToken))
      .fetchOne());
  }

  @Override
  public UserAuth readOneAuth(HubAccess access, UUID userAuthId) throws ManagerException {
    requireTopLevel(access);

    return modelFrom(UserAuth.class, dbProvider.getDSL().select(USER_AUTH.fields())
      .from(USER_AUTH)
      .where(USER_AUTH.ID.equal(userAuthId))
      .fetchOne());
  }

  @Override
  public void destroyAllTokens(UUID userId) throws ManagerException {
    destroyAllTokens(dbProvider.getDSL(), userId);
  }

  /**
   Destroy all access tokens for a specified User

   @param userId to destroy all access tokens for.
   */
  private void destroyAllTokens(DSLContext db, UUID userId) throws ManagerException {
    Result<UserAuthTokenRecord> userAccessTokens = db.selectFrom(USER_AUTH_TOKEN)
      .where(USER_AUTH_TOKEN.USER_ID.eq(userId))
      .fetch();
    for (UserAuthTokenRecord userAccessToken : userAccessTokens) {
      destroyToken(db, userAccessToken);
    }
  }

  /**
   Destroy an access token, first in Redis, then (if successful) in SQL.

   @param db              context
   @param userAccessToken record of user access token to destroy
   */
  private void destroyToken(DSLContext db, UserAuthTokenRecord userAccessToken) throws ManagerException {
    try {
      hubAccessControlProvider.expire(userAccessToken.getAccessToken());
      db.deleteFrom(USER_AUTH_TOKEN)
        .where(USER_AUTH_TOKEN.ID.eq(userAccessToken.getId()))
        .execute();
      log.info("Deleted UserAuthToken, id={}, userId={}, userAuthId={}, accessToken={}", userAccessToken.getId(), userAccessToken.getUserId(), userAccessToken.getUserAuthId(), userAccessToken.getAccessToken());
    } catch (HubAccessException e) {
      throw new ManagerException("Cannot destroy token!", e);
    }
  }

  /**
   Validate a User record

   @param record to validate
   @throws ManagerException if invalid
   */
  public void validate(User record) throws ManagerException {
    try {
      Values.require(record.getRoles(), "User roles");

    } catch (ValueException e) {
      throw new ManagerException(e);
    }
  }

}