// Copyright (c) 2018, XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.core.dao;

import io.xj.core.CoreModule;
import io.xj.core.access.impl.Access;
import io.xj.core.exception.BusinessException;
import io.xj.core.integration.IntegrationTestEntity;
import io.xj.core.model.chain.ChainState;
import io.xj.core.model.chain.ChainType;
import io.xj.core.model.instrument.InstrumentType;
import io.xj.core.model.segment.SegmentState;
import io.xj.core.model.sequence.SequenceState;
import io.xj.core.model.sequence.SequenceType;
import io.xj.core.model.pattern.PatternState;
import io.xj.core.model.pattern.PatternType;
import io.xj.core.model.user_role.UserRoleType;
import io.xj.core.model.voice.Voice;
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
import java.sql.Timestamp;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertNull;

// future test: permissions of different users to readMany vs. create vs. update or delete sequences
public class VoiceIT {
  private final Injector injector = Guice.createInjector(new CoreModule());
  private VoiceDAO testDAO;

  @Before
  public void setUp() throws Exception {
    IntegrationTestEntity.reset();

    // Account "bananas"
    IntegrationTestEntity.insertAccount(1, "bananas");

    // John has "user" and "admin" roles, belongs to account "bananas", has "google" auth
    IntegrationTestEntity.insertUser(2, "john", "john@email.com", "http://pictures.com/john.gif");
    IntegrationTestEntity.insertUserRole(1, 2, UserRoleType.Admin);

    // Library "palm tree" has sequence "leaves" and sequence "coconuts"
    IntegrationTestEntity.insertLibrary(1, 1, "palm tree");
    IntegrationTestEntity.insertSequence(1, 2, 1, SequenceType.Main, SequenceState.Published, "leaves", 0.342, "C#", 110.286);

    // Sequence "leaves" has patterns "Ants" and "Caterpillars"
    IntegrationTestEntity.insertPatternAndSequencePattern(1, 1, PatternType.Main, PatternState.Published, 0, 16, "Ants", 0.583, "D minor", 120.0);
    IntegrationTestEntity.insertPatternAndSequencePattern(2, 1, PatternType.Main, PatternState.Published, 1, 16, "Caterpillars", 0.583, "E major", 140.0);

    // Pattern "Ants" has Voices "Head" and "Body"
    IntegrationTestEntity.insertVoice(1, 1, InstrumentType.Percussive, "This is a percussive voice");
    IntegrationTestEntity.insertVoice(2, 1, InstrumentType.Melodic, "This is melodious");
    IntegrationTestEntity.insertVoice(3, 1, InstrumentType.Harmonic, "This is harmonious");
    IntegrationTestEntity.insertVoice(4, 1, InstrumentType.Vocal, "This is a vocal voice");

    // Instantiate the test subject
    testDAO = injector.getInstance(VoiceDAO.class);
  }

  @After
  public void tearDown() throws Exception {
    testDAO = null;
  }

  @Test
  public void create() throws Exception {
    Access access = new Access(ImmutableMap.of(
      "roles", "Artist",
      "accounts", "1"
    ));
    Voice inputData = new Voice()
      .setSequenceId(BigInteger.valueOf(1L))
      .setType("Harmonic")
      .setDescription("This is harmonious");

    Voice result = testDAO.create(access, inputData);

    assertNotNull(result);
    assertEquals(InstrumentType.Harmonic, result.getType());
    assertEquals("This is harmonious", result.getDescription());
    assertEquals(BigInteger.valueOf(1L), result.getSequenceId());
  }

  @Test(expected = BusinessException.class)
  public void create_FailsWithoutSequenceID() throws Exception {
    Access access = new Access(ImmutableMap.of(
      "roles", "Artist",
      "accounts", "1"
    ));
    Voice inputData = new Voice()
      .setType("Harmonic")
      .setDescription("This is harmonious");

    testDAO.create(access, inputData);
  }

  @Test(expected = BusinessException.class)
  public void create_FailsWithoutType() throws Exception {
    Access access = new Access(ImmutableMap.of(
      "roles", "Artist",
      "accounts", "1"
    ));
    Voice inputData = new Voice()
      .setSequenceId(BigInteger.valueOf(2L))
      .setDescription("This is harmonious");

    testDAO.create(access, inputData);
  }

  @Test
  public void readOne() throws Exception {
    Access access = new Access(ImmutableMap.of(
      "roles", "Artist",
      "accounts", "1"
    ));

    Voice result = testDAO.readOne(access, BigInteger.valueOf(2L));

    assertNotNull(result);
    assertEquals(BigInteger.valueOf(2L), result.getId());
    assertEquals(BigInteger.valueOf(1L), result.getSequenceId());
    assertEquals(InstrumentType.Melodic, result.getType());
    assertEquals("This is melodious", result.getDescription());
  }

  @Test
  public void readOne_FailsWhenUserIsNotInAccount() throws Exception {
    Access access = new Access(ImmutableMap.of(
      "roles", "Artist",
      "accounts", "326"
    ));

    Voice result = testDAO.readOne(access, BigInteger.valueOf(1L));

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
    assertEquals(4L, (long) result.length());
    JSONObject result1 = (JSONObject) result.get(0);
    assertEquals("This is a percussive voice", result1.get("description"));
    JSONObject result2 = (JSONObject) result.get(1);
    assertEquals("This is melodious", result2.get("description"));
    JSONObject result3 = (JSONObject) result.get(2);
    assertEquals("This is harmonious", result3.get("description"));
    JSONObject result4 = (JSONObject) result.get(3);
    assertEquals("This is a vocal voice", result4.get("description"));
  }

  @Test
  public void readAll_SeesNothingOutsideOfLibrary() throws Exception {
    Access access = new Access(ImmutableMap.of(
      "roles", "Artist",
      "accounts", "345"
    ));

    JSONArray result = JSON.arrayOf(testDAO.readAll(access, ImmutableList.of(BigInteger.valueOf(1L))));

    assertNotNull(result);
    assertEquals(0L, (long) result.length());
  }

  @Test(expected = BusinessException.class)
  public void update_FailsWithoutPatternID() throws Exception {
    Access access = new Access(ImmutableMap.of(
      "roles", "Artist",
      "accounts", "1"
    ));
    Voice inputData = new Voice()
      .setType("Harmonic")
      .setDescription("This is harmonious");

    testDAO.update(access, BigInteger.valueOf(3L), inputData);
  }

  @Test(expected = BusinessException.class)
  public void update_FailsWithoutType() throws Exception {
    Access access = new Access(ImmutableMap.of(
      "roles", "Artist",
      "accounts", "1"
    ));
    Voice inputData = new Voice()
      .setSequenceId(BigInteger.valueOf(2L))
      .setDescription("This is harmonious");

    testDAO.update(access, BigInteger.valueOf(3L), inputData);
  }

  @Test(expected = BusinessException.class)
  public void update_FailsUpdatingToNonexistentPattern() throws Exception {
    Access access = new Access(ImmutableMap.of(
      "roles", "Artist",
      "accounts", "1"
    ));
    Voice inputData = new Voice()
      .setSequenceId(BigInteger.valueOf(7L))
      .setType("Melodic")
      .setDescription("This is melodious");

    try {
      testDAO.update(access, BigInteger.valueOf(3L), inputData);

    } catch (Exception e) {
      Voice result = testDAO.readOne(Access.internal(), BigInteger.valueOf(3L));
      assertNotNull(result);
      assertEquals(InstrumentType.Harmonic, result.getType());
      assertEquals("This is harmonious", result.getDescription());
      assertEquals(BigInteger.valueOf(1L), result.getSequenceId());
      throw e;
    }
  }

  @Test
  public void update() throws Exception {
    Access access = new Access(ImmutableMap.of(
      "roles", "Artist",
      "accounts", "1"
    ));
    Voice inputData = new Voice()
      .setSequenceId(BigInteger.valueOf(1L))
      .setType("Melodic")
      .setDescription("This is melodious; Yoza!");

    testDAO.update(access, BigInteger.valueOf(1L), inputData);

    Voice result = testDAO.readOne(Access.internal(), BigInteger.valueOf(1L));
    assertNotNull(result);
    assertEquals("This is melodious; Yoza!", result.getDescription());
    assertEquals(InstrumentType.Melodic, result.getType());
    assertEquals(BigInteger.valueOf(1L), result.getSequenceId());
  }

  // future test: DAO cannot update Sequence to a User or Library not owned by current session

  @Test
  public void delete() throws Exception {
    Access access = new Access(ImmutableMap.of(
      "roles", "Artist",
      "accounts", "1"
    ));

    testDAO.destroy(access, BigInteger.valueOf(1L));

    Voice result = testDAO.readOne(Access.internal(), BigInteger.valueOf(1L));
    assertNull(result);
  }

  /**
   [#153539566] Artist should be able to delete sequence voice, even after chosen in Arrangement and Pick
   */
  @Test
  public void delete_afterChosenInArrangement() throws Exception {
    IntegrationTestEntity.insertInstrument(9, 1, 2, "jams", InstrumentType.Percussive, 0.6);
    IntegrationTestEntity.insertAudio(1, 9, "Published", "Kick", "https://static.xj.io/instrument/percussion/808/kick1.wav", 0.01, 2.123, 120.0, 440.0);
    IntegrationTestEntity.insertChain(1, 1, "Test Print #1", ChainType.Production, ChainState.Ready, Timestamp.valueOf("2014-08-12 12:17:02.527142"), Timestamp.valueOf("2014-09-11 12:17:01.047563"), null);
    IntegrationTestEntity.insertSegment(1, 1, 0, SegmentState.Dubbed, Timestamp.valueOf("2017-02-14 12:01:00.000001"), Timestamp.valueOf("2017-02-14 12:01:32.000001"), "D major", 64, 0.73, 120.0, "chain-1-segment-97898asdf7892.wav", new JSONObject());
    IntegrationTestEntity.insertChoice(7, 1, 1, SequenceType.Macro, 2, -5);
    IntegrationTestEntity.insertArrangement(1, 7, 1, 9);
    Access access = new Access(ImmutableMap.of(
      "roles", "Artist",
      "accounts", "1"
    ));

    testDAO.destroy(access, BigInteger.valueOf(1L));

    Voice result = testDAO.readOne(Access.internal(), BigInteger.valueOf(1L));
    assertNull(result);
  }

  @Test(expected = BusinessException.class)
  public void delete_failsIfNotInAccount() throws Exception {
    Access access = new Access(ImmutableMap.of(
      "roles", "Artist",
      "accounts", "2"
    ));

    testDAO.destroy(access, BigInteger.valueOf(1L));
  }

  @Test
  public void delete_SuccessEvenIfSequenceHasChildren_andWasUsedInProduction() throws Exception {
    Access access = new Access(ImmutableMap.of(
      "userId", "2",
      "roles", "Artist",
      "accounts", "1"
    ));
    IntegrationTestEntity.insertPatternEvent(21, 1, 1, 0.42, 0.41, "HEAVY", "C", 0.7, 0.98);
    IntegrationTestEntity.insertPatternEvent(22, 1, 1, 2.42, 0.41, "HEAVY", "C", 0.7, 0.98);
    IntegrationTestEntity.insertChain(1, 1, "Test Print #1", ChainType.Production, ChainState.Ready, Timestamp.valueOf("2014-08-12 12:17:02.527142"), Timestamp.valueOf("2014-09-11 12:17:01.047563"), null);
    IntegrationTestEntity.insertSegment(1, 1, 0, SegmentState.Dubbed, Timestamp.valueOf("2017-02-14 12:01:00.000001"), Timestamp.valueOf("2017-02-14 12:01:32.000001"), "D major", 64, 0.73, 120.0, "chain-1-segment-97898asdf7892.wav", new JSONObject());
    IntegrationTestEntity.insertInstrument(9, 1, 2, "jams", InstrumentType.Percussive, 0.6);
    IntegrationTestEntity.insertChoice(1, 1, 1, SequenceType.Main, 0, -5);
    IntegrationTestEntity.insertArrangement(1, 1, 1, 9);

    testDAO.destroy(access, BigInteger.valueOf(1L));

    // Assert total annihilation
    assertNull(testDAO.readOne(Access.internal(), BigInteger.valueOf(1L)));
    assertNull(injector.getInstance(PatternEventDAO.class).readOne(Access.internal(), BigInteger.valueOf(21L)));
    assertNull(injector.getInstance(PatternEventDAO.class).readOne(Access.internal(), BigInteger.valueOf(21L)));
  }

  // future test: VoiceDAO cannot delete record unless user has account access

}
