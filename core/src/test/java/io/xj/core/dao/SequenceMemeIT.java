// Copyright (c) 2018, XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.core.dao;

import io.xj.core.CoreModule;
import io.xj.core.access.impl.Access;
import io.xj.core.exception.BusinessException;
import io.xj.core.integration.IntegrationTestEntity;
import io.xj.core.model.sequence.SequenceState;
import io.xj.core.model.sequence.SequenceType;
import io.xj.core.model.sequence_meme.SequenceMeme;
import io.xj.core.model.user_auth.UserAuthType;
import io.xj.core.model.user_role.UserRoleType;
import io.xj.core.transport.JSON;

import com.google.common.collect.ImmutableList;
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

// future test: permissions of different users to readMany vs. create vs. update or delete sequence memes
public class SequenceMemeIT {
  private final Injector injector = Guice.createInjector(new CoreModule());
  private SequenceMemeDAO testDAO;

  @Before
  public void setUp() throws Exception {
    IntegrationTestEntity.reset();

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

    // Library "palm tree" has sequence "leaves", sequence "coconuts" and sequence "bananas"
    IntegrationTestEntity.insertLibrary(1, 1, "palm tree");
    IntegrationTestEntity.insertSequence(1, 2, 1, SequenceType.Main, SequenceState.Published, "leaves", 0.342, "C#", 120.4);
    IntegrationTestEntity.insertSequence(2, 2, 1, SequenceType.Main, SequenceState.Published, "coconuts", 0.25, "F#", 110.3);
    IntegrationTestEntity.insertSequence(3, 2, 1, SequenceType.Main, SequenceState.Published, "bananas", 0.27, "Gb", 100.6);

    // Sequence "leaves" has memes "ants" and "mold"
    IntegrationTestEntity.insertSequenceMeme(1, 1, "Ants");
    IntegrationTestEntity.insertSequenceMeme(2, 1, "Mold");

    // Sequence "bananas" has meme "peel"
    IntegrationTestEntity.insertSequenceMeme(3, 3, "Peel");

    // Instantiate the test subject
    testDAO = injector.getInstance(SequenceMemeDAO.class);
  }

  @After
  public void tearDown() throws Exception {
    testDAO = null;
  }

  @Test
  public void create() throws Exception {
    Access access = new Access(ImmutableMap.of(
      "userId", "2",
      "roles", "Artist",
      "accounts", "1"
    ));
    SequenceMeme inputData = new SequenceMeme()
      .setSequenceId(BigInteger.valueOf(1L))
      .setName("  !!2gnarLY    ");

    JSONObject result = JSON.objectFrom(testDAO.create(access, inputData));

    assertNotNull(result);
    assertEquals(1, result.get("sequenceId"));
    assertEquals("Gnarly", result.get("name"));
  }

  @Test(expected = BusinessException.class)
  public void create_FailsWithoutSequenceID() throws Exception {
    Access access = new Access(ImmutableMap.of(
      "roles", "Artist",
      "accounts", "1"
    ));
    SequenceMeme inputData = new SequenceMeme()
      .setName("gnarly");

    testDAO.create(access, inputData);
  }

  @Test(expected = BusinessException.class)
  public void create_FailsWithoutName() throws Exception {
    Access access = new Access(ImmutableMap.of(
      "roles", "Artist",
      "accounts", "1"
    ));
    SequenceMeme inputData = new SequenceMeme()
      .setSequenceId(BigInteger.valueOf(1L));

    testDAO.create(access, inputData);
  }

  @Test
  public void readOne() throws Exception {
    Access access = new Access(ImmutableMap.of(
      "roles", "Artist",
      "accounts", "1"
    ));

    SequenceMeme result = testDAO.readOne(access, BigInteger.valueOf(2L));

    assertNotNull(result);
    assertEquals(BigInteger.valueOf(2L), result.getId());
    assertEquals(BigInteger.valueOf(1L), result.getSequenceId());
    assertEquals("Mold", result.getName());
  }

  @Test
  public void readOne_FailsWhenUserIsNotInAccount() throws Exception {
    Access access = new Access(ImmutableMap.of(
      "roles", "Artist",
      "accounts", "326"
    ));

    SequenceMeme result = testDAO.readOne(access, BigInteger.valueOf(1L));

    assertNull(result);
  }

  @Test
  public void readAll() throws Exception {
    Access access = new Access(ImmutableMap.of(
      "roles", "Artist",
      "accounts", "1"
    ));

    JSONArray result = JSON.arrayOf(testDAO.readAll(access, ImmutableList.of(BigInteger.valueOf(1L))));

    assertNotNull(result);
    assertEquals(2L, (long) result.length());
    JSONObject result1 = (JSONObject) result.get(0);
    assertEquals("Ants", result1.get("name"));
    JSONObject result2 = (JSONObject) result.get(1);
    assertEquals("Mold", result2.get("name"));
  }

  @Test
  public void readAll_SeesNothingOutsideOfAccount() throws Exception {
    Access access = new Access(ImmutableMap.of(
      "roles", "Artist",
      "accounts", "345"
    ));

    JSONArray result = JSON.arrayOf(testDAO.readAll(access, ImmutableList.of(BigInteger.valueOf(1L))));

    assertNotNull(result);
    assertEquals(0L, (long) result.length());
  }

  @Test
  public void delete() throws Exception {
    Access access = new Access(ImmutableMap.of(
      "roles", "Artist",
      "accounts", "1"
    ));
    testDAO.destroy(access, BigInteger.valueOf(1L));

    SequenceMeme result = testDAO.readOne(Access.internal(),BigInteger.valueOf(1L));
    assertNull(result);
  }
}