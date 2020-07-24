// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.service.hub.dao;

import com.google.common.collect.ImmutableList;
import com.google.common.collect.ImmutableSet;
import com.google.inject.Injector;
import com.typesafe.config.Config;
import io.xj.lib.app.AppConfiguration;
import io.xj.lib.filestore.FileStoreModule;
import io.xj.lib.jsonapi.JsonApiModule;
import io.xj.lib.mixer.MixerModule;
import io.xj.service.hub.IntegrationTestingFixtures;
import io.xj.service.hub.access.HubAccess;
import io.xj.service.hub.access.HubAccessControlModule;
import io.xj.service.hub.entity.Account;
import io.xj.service.hub.entity.AccountUser;
import io.xj.service.hub.entity.Library;
import io.xj.service.hub.entity.User;
import io.xj.service.hub.ingest.HubIngestModule;
import io.xj.service.hub.persistence.HubPersistenceModule;
import io.xj.service.hub.testing.HubIntegrationTestModule;
import io.xj.service.hub.testing.HubIntegrationTestProvider;
import io.xj.service.hub.testing.HubTestConfiguration;
import org.assertj.core.util.Lists;
import org.junit.After;
import org.junit.Before;
import org.junit.Rule;
import org.junit.Test;
import org.junit.rules.ExpectedException;

import java.time.Instant;
import java.util.Collection;

import static org.junit.Assert.*;

public class AccountIT {
  @Rule
  public ExpectedException failure = ExpectedException.none();
  private AccountDAO testDAO;
  private HubIntegrationTestProvider test;
  private IntegrationTestingFixtures fake;

  @Before
  public void setUp() throws Exception {
    Config config = HubTestConfiguration.getDefault();
    Injector injector = AppConfiguration.inject(config, ImmutableSet.of(new HubAccessControlModule(), new DAOModule(), new HubIngestModule(), new HubPersistenceModule(), new MixerModule(), new JsonApiModule(), new FileStoreModule(), new HubIntegrationTestModule()));
    test = injector.getInstance(HubIntegrationTestProvider.class);
    fake = new IntegrationTestingFixtures(test);

    test.reset();

    // Account "bananas"
    fake.account1 = test.insert(Account.create("bananas"));

    // Instantiate the test subject
    testDAO = injector.getInstance(AccountDAO.class);
  }

  @After
  public void tearDown() {
    test.shutdown();
  }

  @Test
  public void create() {
    // future test: AccountDAOImpl of()
  }

  @Test
  public void readOne_asSetToModel() throws Exception {
    HubAccess hubAccess = HubAccess.create(ImmutableList.of(fake.account1), "User");

    Account result = testDAO.readOne(hubAccess, fake.account1.getId());

    assertNotNull(result);
    assertEquals(fake.account1.getId(), result.getId());
    assertEquals("bananas", result.getName());
  }

  @Test
  public void readMany() throws Exception {
    HubAccess hubAccess = HubAccess.create(ImmutableList.of(fake.account1), "User");

    Collection<Account> results = testDAO.readMany(hubAccess, Lists.newArrayList());

    assertNotNull(results);
    assertEquals(1L, results.size());

    Account result0 = results.iterator().next();
    assertEquals("bananas", result0.getName());
  }

  @Test
  public void update() throws Exception {
    HubAccess hubAccess = HubAccess.create(ImmutableList.of(fake.account1), "Admin");
    Account entity = Account.create().setName("jammers");

    testDAO.update(hubAccess, fake.account1.getId(), entity);

    Account result = testDAO.readOne(HubAccess.internal(), fake.account1.getId());
    assertNotNull(result);
    assertEquals("jammers", result.getName());
  }

  @Test
  public void update_failsIfNotAdmin() throws Exception {
    HubAccess hubAccess = HubAccess.create(ImmutableList.of(fake.account1), "User");
    Account entity = Account.create().setName("jammers");

    failure.expect(DAOException.class);
    failure.expectMessage("top-level hubAccess is required");

    testDAO.update(hubAccess, fake.account1.getId(), entity);
  }

  @Test
  public void delete() throws Exception {
    HubAccess hubAccess = HubAccess.create(ImmutableList.of(fake.account1), "Admin");

    testDAO.destroy(hubAccess, fake.account1.getId());

    try {
      testDAO.readOne(HubAccess.internal(), fake.account1.getId());
      fail();
    } catch (DAOException e) {
      assertTrue("Record should not exist", e.getMessage().contains("does not exist"));
    }
  }

  @Test
  public void delete_failsIfNotAdmin() throws Exception {
    failure.expect(DAOException.class);
    failure.expectMessage("top-level hubAccess is required");
    HubAccess hubAccess = HubAccess.create(ImmutableList.of(fake.account1), "User");

    testDAO.destroy(hubAccess, fake.account1.getId());
  }

  @Test
  public void delete_failsIfHasLibrary() throws Exception {
    HubAccess hubAccess = HubAccess.create(ImmutableList.of(fake.account1), "Admin");
    test.insert(Library.create(fake.account1, "Testing", Instant.now()));

    failure.expect(DAOException.class);
    failure.expectMessage("Found Library in Account");

    testDAO.destroy(hubAccess, fake.account1.getId());
  }

  @Test
  public void delete_failsIfHasAccountUser() throws Exception {
    HubAccess hubAccess = HubAccess.create(ImmutableList.of(fake.account1), "Admin");
    fake.user1 = test.insert(User.create("jim", "jim@jim.com", "http://www.jim.com/jim.png"));
    test.insert(AccountUser.create(fake.account1, fake.user1));

    failure.expect(DAOException.class);
    failure.expectMessage("Found User in Account");

    testDAO.destroy(hubAccess, fake.account1.getId());
  }

}