// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.hub.access;

import com.google.common.collect.ImmutableMap;
import com.google.common.collect.ImmutableSet;
import com.google.common.collect.Lists;
import com.google.inject.AbstractModule;
import com.google.inject.Guice;
import com.google.inject.util.Modules;
import com.typesafe.config.Config;
import io.xj.api.AccountUser;
import io.xj.api.UserAuth;
import io.xj.api.UserAuthType;
import io.xj.api.UserRole;
import io.xj.api.UserRoleType;
import io.xj.hub.dao.DAOModule;
import io.xj.hub.ingest.HubIngestModule;
import io.xj.hub.persistence.HubPersistenceModule;
import io.xj.hub.HubIntegrationTestModule;
import io.xj.hub.HubIntegrationTestProvider;
import io.xj.hub.HubTestConfiguration;
import io.xj.lib.app.Environment;
import io.xj.lib.filestore.FileStoreModule;
import io.xj.lib.jsonapi.JsonapiModule;
import org.junit.After;
import org.junit.Before;
import org.junit.Rule;
import org.junit.Test;
import org.junit.rules.ExpectedException;
import org.junit.runner.RunWith;
import org.mockito.junit.MockitoJUnitRunner;

import java.util.Collection;
import java.util.UUID;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;

@RunWith(MockitoJUnitRunner.class)
public class HubAccessControlIT {

  private static final int STRESS_TEST_ITERATIONS = 100;
  @Rule
  public ExpectedException failure = ExpectedException.none();
  HubAccessControlProvider hubAccessControlProvider;
  private HubIntegrationTestProvider test;

  @Before
  public void setUp() throws Exception {
    Config config = HubTestConfiguration.getDefault();
    var env = Environment.from(ImmutableMap.of(
      "REDIS_SESSION_NAMESPACE", "xj_session_test"
    ));

    var injector = Guice.createInjector(Modules.override(ImmutableSet.of(new HubAccessControlModule(), new DAOModule(), new HubIngestModule(), new HubPersistenceModule(), new FileStoreModule(), new JsonapiModule(), new HubIntegrationTestModule())).with(new AbstractModule() {
      @Override
      protected void configure() {
        bind(Config.class).toInstance(config);
        bind(Environment.class).toInstance(env);
      }
    }));

    test = injector.getInstance(HubIntegrationTestProvider.class);

    test.reset();

    hubAccessControlProvider = injector.getInstance(HubAccessControlProvider.class);
  }

  @After
  public void tearDown() {
    test.shutdown();
  }

  @Test
  public void get() throws Exception {
    // user auth
    UserAuth userAuth = new UserAuth();
    UUID userAuthId = UUID.randomUUID();
    userAuth.id(userAuthId);
    UUID userId = UUID.randomUUID();
    userAuth.userId(userId);
    userAuth.type(UserAuthType.GOOGLE);
    userAuth.externalAccount("google");
    userAuth.externalAccessToken("google-token");
    // user role
    UserRole userRole = new UserRole();
    userRole.userId(userId);
    userRole.type(UserRoleType.USER);
    // account user
    AccountUser accountUser = new AccountUser();
    accountUser.userId(userId);
    UUID accountId = UUID.randomUUID();
    accountUser.accountId(accountId);
    // access control provider
    Collection<AccountUser> accounts = Lists.newArrayList(accountUser);
    Collection<UserRole> roles = Lists.newArrayList(userRole);
    String TEST_TOKEN = hubAccessControlProvider.create(userAuth, accounts, roles);

    // now stress test
    for (int i = 0; STRESS_TEST_ITERATIONS > i; i++) {
      HubAccess result = hubAccessControlProvider.get(TEST_TOKEN);
      assertTrue("Result is valid", result.isValid());
    }
  }

  @Test
  public void computeKey() {
    assertEquals("xj_session_test:*", hubAccessControlProvider.computeKey("*"));
  }

}