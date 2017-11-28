// Copyright (c) 2017, Outright Mental Inc. (http://outright.io) All Rights Reserved.
package io.xj.core.app.access;

import io.xj.core.CoreModule;
import io.xj.core.app.access.impl.AccessControlProviderImpl;
import io.xj.core.database.redis.RedisDatabaseProvider;
import io.xj.core.model.role.Role;
import io.xj.core.tables.records.AccountUserRecord;
import io.xj.core.tables.records.UserAuthRecord;
import io.xj.core.tables.records.UserRoleRecord;
import io.xj.core.util.token.TokenGenerator;

import org.jooq.types.ULong;

import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.jackson2.JacksonFactory;
import com.google.inject.AbstractModule;
import com.google.inject.Guice;
import com.google.inject.Injector;
import com.google.inject.util.Modules;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.Mock;
import org.mockito.runners.MockitoJUnitRunner;
import redis.clients.jedis.Jedis;

import javax.ws.rs.core.Cookie;
import java.util.Collection;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.Map;

import static org.junit.Assert.assertEquals;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@RunWith(MockitoJUnitRunner.class)
public class JSONOutputProviderImplTest {
  @Mock private TokenGenerator tokenGenerator;
  @Mock private RedisDatabaseProvider redisDatabaseProvider;
  @Mock private Jedis redisConnection;
  private Injector injector;
  private AccessControlProvider accessControlProvider;
  private UserAuthRecord userAuth;
  private Collection<AccountUserRecord> accounts;
  private Collection<UserRoleRecord> roles;

  @Before
  public void setUp() throws Exception {
    System.setProperty("access.token.domain", "com.manuts");
    System.setProperty("access.token.path", "/deez");
    System.setProperty("access.token.max.age", "60");
    System.setProperty("access.token.name", "access_token_jammy");
    createInjector();
    accessControlProvider = injector.getInstance(AccessControlProvider.class);

    userAuth = new UserAuthRecord();
    userAuth.setUserId(ULong.valueOf(5609877));
    userAuth.setId(ULong.valueOf(12363));

    accounts = new LinkedList<>();
    AccountUserRecord accountRole1 = new AccountUserRecord();
    accountRole1.setAccountId(ULong.valueOf(790809874));
    AccountUserRecord accountRole2 = new AccountUserRecord();
    accountRole2.setAccountId(ULong.valueOf(90888932));
    accounts.add(accountRole1);
    accounts.add(accountRole2);

    roles = new LinkedList<>();
    UserRoleRecord role1 = new UserRoleRecord();
    role1.setType(Role.USER);
    UserRoleRecord role2 = new UserRoleRecord();
    role2.setType(Role.ARTIST);
    roles.add(role1);
    roles.add(role2);
  }

  @After
  public void tearDown() throws Exception {
    userAuth = null;
    accounts = null;
    roles = null;
    System.clearProperty("access.token.domain");
    System.clearProperty("access.token.path");
    System.clearProperty("access.token.max.age");
    System.clearProperty("access.token.name");
  }

  @Test
  public void create() throws Exception {
    when(redisDatabaseProvider.getClient())
      .thenReturn(redisConnection);
    when(tokenGenerator.generate())
      .thenReturn("token123");

    accessControlProvider.create(userAuth, accounts, roles);

    Map<String, String> expectUserAccess = new HashMap<>();
    expectUserAccess.put("userId", "5609877");
    expectUserAccess.put("userAuthId", "12363");
    expectUserAccess.put("roles", "user,artist");
    expectUserAccess.put("accounts", "790809874,90888932");
    verify(redisConnection).hmset("token123", expectUserAccess);
  }

  @Test
  public void newCookie() throws Exception {
    Cookie cookie = accessControlProvider.newCookie("12345");

    assertEquals("access_token_jammy", cookie.getName());
    assertEquals("com.manuts", cookie.getDomain());
    assertEquals("/deez", cookie.getPath());
    assertEquals("12345", cookie.getValue());
  }

  @Test
  public void expire() throws Exception {

  }

  @Test
  public void get() throws Exception {

  }

  private void createInjector() {
    injector = Guice.createInjector(Modules.override(new CoreModule()).with(
      new AbstractModule() {
        @Override
        public void configure() {
          bind(TokenGenerator.class).toInstance(tokenGenerator);
          bind(RedisDatabaseProvider.class).toInstance(redisDatabaseProvider);
          bind(AccessControlProvider.class).to(AccessControlProviderImpl.class);
          bind(JsonFactory.class).to(JacksonFactory.class);
        }
      }));
  }

}