// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.hub.access;

import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.jackson2.JacksonFactory;
import com.google.common.collect.ImmutableList;
import com.google.common.collect.ImmutableMap;
import com.google.common.collect.ImmutableSet;
import com.google.inject.AbstractModule;
import com.google.inject.Guice;
import com.google.inject.util.Modules;
import com.typesafe.config.Config;
import io.xj.api.Account;
import io.xj.api.AccountUser;
import io.xj.api.User;
import io.xj.api.UserAuth;
import io.xj.api.UserRole;
import io.xj.api.UserRoleType;
import io.xj.hub.dao.DAOModule;
import io.xj.hub.ingest.HubIngestModule;
import io.xj.hub.persistence.HubPersistenceModule;
import io.xj.hub.persistence.HubRedisProvider;
import io.xj.hub.HubTestConfiguration;
import io.xj.lib.app.Environment;
import io.xj.lib.filestore.FileStoreModule;
import io.xj.lib.jsonapi.JsonapiModule;
import io.xj.lib.jsonapi.JsonapiPayloadFactory;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.Mock;
import org.mockito.junit.MockitoJUnitRunner;
import redis.clients.jedis.Jedis;

import javax.ws.rs.core.Cookie;
import java.util.Collection;
import java.util.List;
import java.util.UUID;

import static org.junit.Assert.assertEquals;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@RunWith(MockitoJUnitRunner.class)
public class RedisHubAccessTokenTest {
  @Mock
  HubAccessTokenGenerator hubAccessTokenGenerator;
  @Mock
  HubRedisProvider hubRedisProvider;
  Account account1;
  Account account2;
  @Mock
  private Jedis redisClient;
  private HubAccessControlProvider hubAccessControlProvider;
  private UserAuth userAuth;
  private Collection<AccountUser> accountUsers;
  private Collection<UserRole> roles;
  private User user;
  private JsonapiPayloadFactory payloadFactory;

  @Before
  public void setUp() throws Exception {
    Config config = HubTestConfiguration.getDefault();
    var env = Environment.from(ImmutableMap.of(
      "ACCESS_TOKEN_DOMAIN", "com.coconuts",
      "ACCESS_TOKEN_MAX_AGE_SECONDS", "60",
      "ACCESS_TOKEN_NAME", "access_token_jammy",
      "ACCESS_TOKEN_PATH", "/dough",
      "REDIS_SESSION_NAMESPACE", "xj_session_test"
    ));
    var injector = Guice.createInjector(Modules.override(new HubAccessControlModule(), new DAOModule(), new HubIngestModule(), new HubPersistenceModule(), new JsonapiModule(), new FileStoreModule()).with(
      new AbstractModule() {
        @Override
        public void configure() {
          bind(Config.class).toInstance(config);
          bind(Environment.class).toInstance(env);
          bind(HubAccessTokenGenerator.class).toInstance(hubAccessTokenGenerator);
          bind(HubRedisProvider.class).toInstance(hubRedisProvider);
          bind(HubAccessControlProvider.class).to(HubAccessControlProviderImpl.class);
          bind(JsonFactory.class).to(JacksonFactory.class);
        }
      }));
    hubAccessControlProvider = injector.getInstance(HubAccessControlProvider.class);
    payloadFactory = injector.getInstance(JsonapiPayloadFactory.class);

    user = new User()
      .id(UUID.randomUUID())
      ;
    userAuth = new UserAuth()
      .userId(user.getId())
      .id(UUID.randomUUID())
      ;
    account1 = new Account()
      .id(UUID.randomUUID())
      ;
    account2 = new Account()
      .id(UUID.randomUUID())
      ;

    var accountUser1 = new AccountUser()
      .accountId(account1.getId())
      ;
    var accountUser2 = new AccountUser()
      .accountId(account2.getId())
      ;
    accountUsers = List.of(accountUser1, accountUser2);

    UserRole role1 = new UserRole()
      .type(UserRoleType.USER)
      ;
    UserRole role2 = new UserRole()
      .type(UserRoleType.ARTIST)
      ;
    roles = List.of(role1, role2);
  }

  @After
  public void tearDown() {
    System.clearProperty("access.token.domain");
    System.clearProperty("access.token.path");
    System.clearProperty("access.token.max.age");
    System.clearProperty("access.token.name");
  }

  @Test
  public void create() throws Exception {
    when(hubRedisProvider.getClient())
      .thenReturn(redisClient);
    when(hubAccessTokenGenerator.generate())
      .thenReturn("token123");

    hubAccessControlProvider.create(userAuth, accountUsers, roles);

    HubAccess expectUserAccess = new HubAccess()
      .setUserId(user.getId())
      .setUserAuthId(userAuth.getId())
      .setRoleTypes(ImmutableList.of(UserRoleType.USER, UserRoleType.ARTIST))
      .setAccountIds(ImmutableSet.of(account1.getId(), account2.getId()));
    verify(redisClient).set("xj_session_test:token123", payloadFactory.serialize(expectUserAccess));
  }

  @Test
  public void newCookie() {
    Cookie cookie = hubAccessControlProvider.newCookie("12345");

    assertEquals("access_token_jammy", cookie.getName());
    assertEquals("com.coconuts", cookie.getDomain());
    assertEquals("/dough", cookie.getPath());
    assertEquals("12345", cookie.getValue());
  }

}