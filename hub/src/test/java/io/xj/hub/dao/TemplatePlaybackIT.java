// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.hub.dao;

import com.google.common.collect.ImmutableList;
import com.google.common.collect.ImmutableSet;
import com.google.inject.AbstractModule;
import com.google.inject.Guice;
import com.google.inject.util.Modules;
import com.typesafe.config.Config;
import io.xj.api.Account;
import io.xj.api.AccountUser;
import io.xj.api.Template;
import io.xj.api.TemplatePlayback;
import io.xj.api.TemplateType;
import io.xj.api.User;
import io.xj.api.UserRole;
import io.xj.api.UserRoleType;
import io.xj.hub.HubIntegrationTestModule;
import io.xj.hub.HubIntegrationTestProvider;
import io.xj.hub.HubTestConfiguration;
import io.xj.hub.IntegrationTestingFixtures;
import io.xj.hub.access.HubAccess;
import io.xj.hub.access.HubAccessControlModule;
import io.xj.hub.ingest.HubIngestModule;
import io.xj.hub.persistence.HubPersistenceModule;
import io.xj.lib.app.Environment;
import io.xj.lib.filestore.FileStoreModule;
import io.xj.lib.jsonapi.JsonapiModule;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.junit.MockitoJUnitRunner;

import java.time.Instant;
import java.util.Collection;
import java.util.Date;
import java.util.UUID;

import static io.xj.hub.IntegrationTestingFixtures.buildTemplate;
import static io.xj.hub.IntegrationTestingFixtures.buildTemplatePlayback;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertThrows;
import static org.junit.Assert.assertTrue;
import static org.junit.Assert.fail;

// future test: permissions of different users to readMany vs. of vs. update or delete templatePlaybacks

// FUTURE: any test that

@RunWith(MockitoJUnitRunner.class)
public class TemplatePlaybackIT {
  private TemplatePlaybackDAO testDAO;
  private HubIntegrationTestProvider test;
  private IntegrationTestingFixtures fake;
  private TemplatePlayback templatePlayback201;

  @Before
  public void setUp() throws Exception {
    Config config = HubTestConfiguration.getDefault();
    var env = Environment.getDefault();
    var injector = Guice.createInjector(Modules.override(ImmutableSet.of(new HubAccessControlModule(), new DAOModule(), new HubIngestModule(), new HubPersistenceModule(), new JsonapiModule(), new FileStoreModule(), new HubIntegrationTestModule())).with(new AbstractModule() {
      @Override
      protected void configure() {
        bind(Config.class).toInstance(config);
        bind(Environment.class).toInstance(env);
      }
    }));
    test = injector.getInstance(HubIntegrationTestProvider.class);
    fake = new IntegrationTestingFixtures(test);

    test.reset();

    // Account "bananas"
    fake.account1 = test.insert(new Account()
      .id(UUID.randomUUID())
      .name("bananas"));
    // John has "user" and "admin" roles, belongs to account "bananas", has "google" auth
    fake.user2 = test.insert(new User()
      .id(UUID.randomUUID())
      .name("john")
      .email("john@email.com")
      .avatarUrl("http://pictures.com/john.gif"));
    test.insert(new UserRole()
      .id(UUID.randomUUID())
      .userId(fake.user2.getId())
      .type(UserRoleType.ADMIN));

    // Jenny has a "user" role and belongs to account "bananas"
    fake.user3 = test.insert(new User()
      .id(UUID.randomUUID())
      .name("jenny")
      .email("jenny@email.com")
      .avatarUrl("http://pictures.com/jenny.gif"));
    test.insert(new UserRole()
      .id(UUID.randomUUID())
      .userId(fake.user2.getId())
      .type(UserRoleType.USER));
    test.insert(new AccountUser()
      .id(UUID.randomUUID())
      .accountId(fake.account1.getId())
      .userId(fake.user3.getId()));

    // Template "sandwich" has templatePlayback "jams" and templatePlayback "buns"
    fake.template1 = test.insert(new Template()
      .id(UUID.randomUUID())
      .type(TemplateType.PREVIEW)
      .accountId(fake.account1.getId())
      .name("sandwich"));
    test.insert(buildTemplate(fake.account1, "Test Template", UUID.randomUUID().toString()).type(TemplateType.PREVIEW));
    templatePlayback201 = test.insert(buildTemplatePlayback(fake.template1, fake.user2));

    // Instantiate the test subject
    testDAO = injector.getInstance(TemplatePlaybackDAO.class);
  }

  @After
  public void tearDown() {
    test.shutdown();
  }

  @Test
  public void create_alwaysTakesUserFromHubAccess() throws Exception {
    HubAccess hubAccess = HubAccess.create(fake.user2, ImmutableList.of(fake.account1), "Artist");
    TemplatePlayback subject = buildTemplatePlayback(fake.template1, fake.user3); // user will be overridden by hub access user id

    TemplatePlayback result = testDAO.create(hubAccess, subject);

    assertNotNull(result);
    assertEquals(fake.template1.getId(), result.getTemplateId());
    assertEquals(fake.user2.getId(), result.getUserId());
  }

  @Test
  public void create_withoutSpecifyingUser() throws Exception {
    HubAccess hubAccess = HubAccess.create(fake.user2, ImmutableList.of(fake.account1), "Artist");
    TemplatePlayback subject = new TemplatePlayback()
      .id(UUID.randomUUID())
      .templateId(fake.template1.getId());

    TemplatePlayback result = testDAO.create(hubAccess, subject);

    assertNotNull(result);
    assertEquals(fake.template1.getId(), result.getTemplateId());
    assertEquals(fake.user2.getId(), result.getUserId());
  }

  @Test
  public void create_cannotPlaybackProductionChain() throws Exception {
    HubAccess hubAccess = HubAccess.create(fake.user2, ImmutableList.of(fake.account1), "Artist");
    var template5 = test.insert(buildTemplate(fake.account1, "test", UUID.randomUUID().toString()).type(TemplateType.PRODUCTION));
    TemplatePlayback subject = buildTemplatePlayback(template5, fake.user3); // user will be overridden by hub access user id

    var e = assertThrows(DAOException.class, () -> testDAO.create(hubAccess, subject));
    assertEquals("Preview-type Template is required", e.getMessage());
  }

  @Test
  public void update_notAllowed() throws Exception {
    HubAccess hubAccess = HubAccess.create(fake.user2, ImmutableList.of(fake.account1), "Artist");
    TemplatePlayback subject = test.insert(buildTemplatePlayback(fake.template1, fake.user2));

    assertThrows(DAOException.class, () -> testDAO.update(hubAccess, subject.getId(), subject));
  }

  @Test
  public void create_archivesExistingForUser() throws Exception {
    HubAccess hubAccess = HubAccess.create(fake.user2, ImmutableList.of(fake.account1), "Artist");
    var priorTemplate = test.insert(buildTemplate(fake.account1, "Prior", UUID.randomUUID().toString()).type(TemplateType.PREVIEW));
    var priorPlayback = test.insert(buildTemplatePlayback(priorTemplate, fake.user2));
    var subject = buildTemplatePlayback(fake.template1, fake.user2);

    testDAO.create(hubAccess, subject);

    assertThrows(DAOException.class, () -> testDAO.readOne(hubAccess, priorPlayback.getId()));
  }

  @Test
  public void readOne() throws Exception {
    HubAccess hubAccess = HubAccess.create(ImmutableList.of(fake.account1), "User");

    TemplatePlayback result = testDAO.readOne(hubAccess, templatePlayback201.getId());

    assertNotNull(result);
    assertEquals(templatePlayback201.getId(), result.getId());
    assertEquals(fake.user2.getId(), result.getUserId());
  }

  @Test
  public void readOneForUser() throws Exception {
    HubAccess hubAccess = HubAccess.create(fake.user2, ImmutableList.of(fake.account1), "User");

    var result = testDAO.readOneForUser(hubAccess, fake.user2.getId());

    assertTrue(result.isPresent());
    assertEquals(templatePlayback201.getId(), result.get().getId());
    assertEquals(fake.user2.getId(), result.get().getUserId());
  }

  @Test
  public void readOne_FailsWhenUserIsNotInTemplate() {
    HubAccess hubAccess = HubAccess.create(ImmutableList.of(new Account()
      .id(UUID.randomUUID())
    ), "User");

    var e = assertThrows(DAOException.class, () -> testDAO.readOne(hubAccess, templatePlayback201.getId()));
    assertEquals("Record does not exist", e.getMessage());
  }

  // future test: readManyInAccount vs readManyInLibraries, positive and negative cases

  @Test
  public void readMany() throws Exception {
    HubAccess hubAccess = HubAccess.create(ImmutableList.of(fake.account1), "Admin");

    Collection<TemplatePlayback> result = testDAO.readMany(hubAccess, ImmutableList.of(fake.template1.getId()));

    assertEquals(1L, result.size());
  }

  @Test
  public void readAll() throws Exception {
    HubAccess hubAccess = HubAccess.create(ImmutableList.of(fake.account1), "Admin");
    test.insert(buildTemplatePlayback(fake.template1, fake.user3));

    Collection<TemplatePlayback> result = testDAO.readAll(hubAccess);

    assertEquals(2L, result.size());
  }

  @Test
  public void readAll_noneOlderThanThreshold() throws Exception {
    HubAccess hubAccess = HubAccess.create(ImmutableList.of(fake.account1), "Admin");
    test.insert(buildTemplatePlayback(fake.template1, fake.user3).createdAt(Date.from(Instant.now().minusSeconds(60 * 60 * 12))));

    Collection<TemplatePlayback> result = testDAO.readAll(hubAccess);

    assertEquals(1L, result.size());
  }

  @Test
  public void readMany_SeesNothingOutsideOfTemplate() throws Exception {
    HubAccess hubAccess = HubAccess.create(ImmutableList.of(new Account()
      .id(UUID.randomUUID())), "User");

    Collection<TemplatePlayback> result = testDAO.readMany(hubAccess, ImmutableList.of(fake.template1.getId()));

    assertEquals(0L, result.size());
  }

  @Test
  public void destroy() throws Exception {
    HubAccess hubAccess = HubAccess.create("Admin");
    TemplatePlayback templatePlayback251 = buildTemplatePlayback(fake.template1, fake.user2);

    testDAO.destroy(hubAccess, templatePlayback251.getId());

    try {
      testDAO.readOne(HubAccess.internal(), templatePlayback251.getId());
      fail();
    } catch (DAOException e) {
      assertTrue("Record should not exist", e.getMessage().contains("does not exist"));
    }
  }

}
