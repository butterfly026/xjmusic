// Copyright (c) 2017, XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.core.dao;

import io.xj.core.CoreModule;
import io.xj.core.access.impl.Access;
import io.xj.core.exception.BusinessException;
import io.xj.core.integration.IntegrationTestEntity;
import io.xj.core.model.pattern.PatternType;
import io.xj.core.model.phase_meme.PhaseMeme;
import io.xj.core.model.user_auth.UserAuthType;
import io.xj.core.model.user_role.UserRoleType;
import io.xj.core.transport.JSON;

import com.google.common.collect.ImmutableMap;
import com.google.inject.Guice;
import com.google.inject.Injector;

import org.json.JSONArray;
import org.json.JSONObject;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import java.math.BigInteger;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertNull;

// future test: permissions of different users to readMany vs. create vs. update or delete phase memes
public class PhaseMemeIT {
  private final Injector injector = Guice.createInjector(new CoreModule());
  private PhaseMemeDAO testDAO;

  @Before
  public void setUp() throws Exception {
    IntegrationTestEntity.deleteAll();

    // Account "bananas"
    IntegrationTestEntity.insertAccount(1, "bananas");

    // John has "user" and "admin" roles, belongs to account "bananas", has "google" auth
    IntegrationTestEntity.insertUser(2, "john", "john@email.com", "http://pictures.com/john.gif");
    IntegrationTestEntity.insertUserRole(1, 2, UserRoleType.User);
    IntegrationTestEntity.insertUserRole(2, 2, UserRoleType.Admin);
    IntegrationTestEntity.insertAccountUser(3, 1, 2);
    IntegrationTestEntity.insertUserAuth(102, 2, UserAuthType.Google, "external_access_token_123", "external_refresh_token_123", "22222");
    IntegrationTestEntity.insertUserAccessToken(2, 102, "this-is-my-actual-access-token");

    // Jenny has a "user" role and belongs to account "bananas"
    IntegrationTestEntity.insertUser(3, "jenny", "jenny@email.com", "http://pictures.com/jenny.gif");
    IntegrationTestEntity.insertUserRole(4, 3, UserRoleType.User);
    IntegrationTestEntity.insertAccountUser(5, 1, 3);

    // Bill has a "user" role but no account membership
    IntegrationTestEntity.insertUser(4, "bill", "bill@email.com", "http://pictures.com/bill.gif");
    IntegrationTestEntity.insertUserRole(6, 4, UserRoleType.User);

    // Library "palm tree" has pattern "leaves"
    IntegrationTestEntity.insertLibrary(1, 1, "palm tree");
    IntegrationTestEntity.insertPattern(1, 2, 1, PatternType.Main, "leaves", 0.342, "C#", 120.4);

    // Pattern "leaves" has phase "growth" and phase "decay"
    IntegrationTestEntity.insertPhase(1, 1, 0, 16, "growth", 0.342, "C#", 120.4);
    IntegrationTestEntity.insertPhase(2, 1, 1, 16, "decay", 0.25, "F#", 110.3);

    // Phase "growth" has memes "ants" and "mold"
    IntegrationTestEntity.insertPhaseMeme(1, 1, "Gravel");
    IntegrationTestEntity.insertPhaseMeme(2, 1, "Fuzz");

    // Phase "decay" has meme "peel"
    IntegrationTestEntity.insertPhaseMeme(3, 2, "Peel");

    // Instantiate the test subject
    testDAO = injector.getInstance(PhaseMemeDAO.class);
  }

  @After
  public void tearDown() throws Exception {
    testDAO = null;
  }

  @Test
  public void create() throws Exception {
    Access access = Access.from(ImmutableMap.of(
      "userId", "2",
      "roles", "Artist",
      "accounts", "1"
    ));
    PhaseMeme inputData = new PhaseMeme()
      .setPhaseId(BigInteger.valueOf(1))
      .setName("  !!2gnarLY    ");

    JSONObject result = JSON.objectFrom(testDAO.create(access, inputData));

    assertNotNull(result);
    assertEquals(1, result.get("phaseId"));
    assertEquals("Gnarly", result.get("name"));
  }

  @Test(expected = BusinessException.class)
  public void create_FailsWithoutPhaseID() throws Exception {
    Access access = Access.from(ImmutableMap.of(
      "roles", "Artist",
      "accounts", "1"
    ));
    PhaseMeme inputData = new PhaseMeme()
      .setName("gnarly");

    testDAO.create(access, inputData);
  }

  @Test(expected = BusinessException.class)
  public void create_FailsWithoutName() throws Exception {
    Access access = Access.from(ImmutableMap.of(
      "roles", "Artist",
      "accounts", "1"
    ));
    PhaseMeme inputData = new PhaseMeme()
      .setPhaseId(BigInteger.valueOf(1));

    testDAO.create(access, inputData);
  }

  @Test
  public void readOne() throws Exception {
    Access access = Access.from(ImmutableMap.of(
      "roles", "Artist",
      "accounts", "1"
    ));

    PhaseMeme result = testDAO.readOne(access, BigInteger.valueOf(2));

    assertNotNull(result);
    assertEquals(BigInteger.valueOf(2), result.getId());
    assertEquals(BigInteger.valueOf(1), result.getPhaseId());
    assertEquals("Fuzz", result.getName());
  }

  @Test
  public void readOne_FailsWhenUserIsNotInAccount() throws Exception {
    Access access = Access.from(ImmutableMap.of(
      "roles", "Artist",
      "accounts", "326"
    ));

    PhaseMeme result = testDAO.readOne(access, BigInteger.valueOf(1));

    assertNull(result);
  }

  @Test
  public void readAll() throws Exception {
    Access access = Access.from(ImmutableMap.of(
      "roles", "Artist",
      "accounts", "1"
    ));

    JSONArray result = JSON.arrayOf(testDAO.readAll(access, BigInteger.valueOf(1)));

    assertNotNull(result);
    assertEquals(2, result.length());
    JSONObject result1 = (JSONObject) result.get(0);
    assertEquals("Gravel", result1.get("name"));
    JSONObject result2 = (JSONObject) result.get(1);
    assertEquals("Fuzz", result2.get("name"));
  }

  @Test
  public void readAll_SeesNothingOutsideOfAccount() throws Exception {
    Access access = Access.from(ImmutableMap.of(
      "roles", "Artist",
      "accounts", "345"
    ));

    JSONArray result = JSON.arrayOf(testDAO.readAll(access, BigInteger.valueOf(1)));

    assertNotNull(result);
    assertEquals(0, result.length());
  }

  @Test
  public void delete() throws Exception {
    Access access = Access.from(ImmutableMap.of(
      "roles", "Artist",
      "accounts", "1"
    ));
    testDAO.delete(access, BigInteger.valueOf(1));

    PhaseMeme result = testDAO.readOne(Access.internal(), BigInteger.valueOf(1));
    assertNull(result);
  }

  @Test(expected = BusinessException.class)
  public void delete_failsIfNotInAccount() throws Exception {
    Access access = Access.from(ImmutableMap.of(
      "roles", "Artist",
      "accounts", "2"
    ));

    testDAO.delete(access, BigInteger.valueOf(1));
  }
}
