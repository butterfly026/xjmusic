// Copyright (c) 2020, XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.core.dao.account;

import com.google.common.collect.ImmutableList;
import com.google.inject.Injector;
import com.typesafe.config.Config;
import io.xj.core.CoreModule;
import io.xj.core.IntegrationTestingFixtures;
import io.xj.core.access.Access;
import io.xj.core.app.AppConfiguration;
import io.xj.core.dao.AccountDAO;
import io.xj.core.exception.CoreException;
import io.xj.core.model.Account;
import io.xj.core.model.AccountUser;
import io.xj.core.model.Chain;
import io.xj.core.model.ChainState;
import io.xj.core.model.ChainType;
import io.xj.core.model.Library;
import io.xj.core.model.User;
import io.xj.core.testing.AppTestConfiguration;
import io.xj.core.testing.Assert;
import io.xj.core.testing.IntegrationTestProvider;
import io.xj.core.testing.InternalResources;
import org.assertj.core.util.Lists;
import org.junit.After;
import org.junit.Before;
import org.junit.Rule;
import org.junit.Test;
import org.junit.rules.ExpectedException;

import java.time.Instant;
import java.util.Collection;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

public class AccountIT {
  @Rule
  public ExpectedException failure = ExpectedException.none();
  private AccountDAO testDAO;
  private IntegrationTestProvider test;
  private IntegrationTestingFixtures fake;

  @Before
  public void setUp() throws Exception {
    Config config = AppTestConfiguration.getDefault();
    Injector injector = AppConfiguration.inject(config, ImmutableList.of(new CoreModule()));
    test = injector.getInstance(IntegrationTestProvider.class);
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
    Access access = Access.create(ImmutableList.of(fake.account1), "User");

    Account result = testDAO.readOne(access, fake.account1.getId());

    assertNotNull(result);
    assertEquals(fake.account1.getId(), result.getId());
    assertEquals("bananas", result.getName());
  }

  @Test
  public void readAll() throws Exception {
    Access access = Access.create(ImmutableList.of(fake.account1), "User");

    Collection<Account> results = testDAO.readMany(access, Lists.newArrayList());

    assertNotNull(results);
    assertEquals(1L, results.size());

    Account result0 = results.iterator().next();
    assertEquals("bananas", result0.getName());
  }

  @Test
  public void update() throws Exception {
    Access access = Access.create(ImmutableList.of(fake.account1), "Admin");
    Account entity = Account.create().setName("jammers");

    testDAO.update(access, fake.account1.getId(), entity);

    Account result = testDAO.readOne(Access.internal(), fake.account1.getId());
    assertNotNull(result);
    assertEquals("jammers", result.getName());
  }

  @Test
  public void update_failsIfNotAdmin() throws Exception {
    Access access = Access.create(ImmutableList.of(fake.account1), "User");
    Account entity = Account.create().setName("jammers");

    failure.expect(CoreException.class);
    failure.expectMessage("top-level access is required");

    testDAO.update(access, fake.account1.getId(), entity);
  }

  @Test
  public void delete() throws Exception {
    Access access = Access.create(ImmutableList.of(fake.account1), "Admin");

    testDAO.destroy(access, fake.account1.getId());

    Assert.assertNotExist(testDAO, fake.account1.getId());
  }

  @Test
  public void delete_failsIfNotAdmin() throws Exception {
    failure.expect(CoreException.class);
    failure.expectMessage("top-level access is required");
    Access access = Access.create(ImmutableList.of(fake.account1), "User");

    testDAO.destroy(access, fake.account1.getId());
  }

  @Test
  public void delete_failsIfHasChain() throws Exception {
    Access access = Access.create(ImmutableList.of(fake.account1), "Admin");
    test.insert(Chain.create(fake.account1, "Test", ChainType.Preview, ChainState.Draft, Instant.parse("2009-08-12T12:17:02.527142Z"), Instant.parse("2009-08-12T12:17:02.527142Z"), null));

    failure.expect(CoreException.class);
    failure.expectMessage("Found Chain in Account");

    testDAO.destroy(access, fake.account1.getId());
  }

  @Test
  public void delete_failsIfHasLibrary() throws Exception {
    Access access = Access.create(ImmutableList.of(fake.account1), "Admin");
    test.insert(Library.create(fake.account1, "Testing", InternalResources.now()));

    failure.expect(CoreException.class);
    failure.expectMessage("Found Library in Account");

    testDAO.destroy(access, fake.account1.getId());
  }

  @Test
  public void delete_failsIfHasAccountUser() throws Exception {
    Access access = Access.create(ImmutableList.of(fake.account1), "Admin");
    fake.user1 = test.insert(User.create("jim", "jim@jim.com", "http://www.jim.com/jim.png"));
    test.insert(AccountUser.create(fake.account1, fake.user1));

    failure.expect(CoreException.class);
    failure.expectMessage("Found User in Account");

    testDAO.destroy(access, fake.account1.getId());
  }

}