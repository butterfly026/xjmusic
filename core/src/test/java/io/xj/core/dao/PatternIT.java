// Copyright (c) 2018, XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.core.dao;

import com.google.common.collect.ImmutableList;
import com.google.common.collect.ImmutableMap;
import com.google.inject.AbstractModule;
import com.google.inject.Guice;
import com.google.inject.Injector;
import com.google.inject.util.Modules;
import io.xj.core.CoreModule;
import io.xj.core.access.impl.Access;
import io.xj.core.exception.CoreException;
import io.xj.core.integration.IntegrationTestEntity;
import io.xj.core.model.instrument.InstrumentType;
import io.xj.core.model.pattern.Pattern;
import io.xj.core.model.pattern.PatternState;
import io.xj.core.model.pattern.PatternType;
import io.xj.core.model.sequence.SequenceState;
import io.xj.core.model.sequence.SequenceType;
import io.xj.core.model.user_role.UserRoleType;
import io.xj.core.work.WorkManager;
import org.junit.Before;
import org.junit.Rule;
import org.junit.Test;
import org.junit.rules.ExpectedException;
import org.junit.runner.RunWith;
import org.mockito.Spy;
import org.mockito.runners.MockitoJUnitRunner;

import java.math.BigInteger;
import java.time.Instant;
import java.util.Collection;
import java.util.Iterator;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertNull;
import static org.junit.Assert.assertTrue;
import static org.mockito.Matchers.any;
import static org.mockito.Matchers.eq;
import static org.mockito.Mockito.verify;

// future test: permissions of different users to readMany vs. create vs. update or destroy patterns
@RunWith(MockitoJUnitRunner.class)
public class PatternIT {
  @Spy
  private final WorkManager workManager = Guice.createInjector(new CoreModule()).getInstance(WorkManager.class);
  @Rule
  public ExpectedException failure = ExpectedException.none();
  private Injector injector;
  private PatternDAO testDAO;

  @Before
  public void setUp() throws Exception {
    IntegrationTestEntity.reset();

    // inject mocks
    createInjector();

    // Account "oranges"
    IntegrationTestEntity.insertAccount(1, "oranges");

    // John has "user" and "admin" roles, belongs to account "oranges", has "google" auth
    IntegrationTestEntity.insertUser(2, "john", "john@email.com", "http://pictures.com/john.gif");
    IntegrationTestEntity.insertUserRole(2, UserRoleType.Admin);

    // Jenny has a "user" role and belongs to account "oranges"
    IntegrationTestEntity.insertUser(3, "jenny", "jenny@email.com", "http://pictures.com/jenny.gif");
    IntegrationTestEntity.insertUserRole(3, UserRoleType.User);
    IntegrationTestEntity.insertAccountUser(1, 3);

    // Library "palm tree" has sequence "leaves" and sequence "coconuts"
    IntegrationTestEntity.insertLibrary(1, 1, "palm tree");
    IntegrationTestEntity.insertSequence(1, 2, 1, SequenceType.Main, SequenceState.Published, "leaves", 0.342, "C#", 110.286);
    IntegrationTestEntity.insertSequence(2, 2, 1, SequenceType.Macro, SequenceState.Published, "coconuts", 8.02, "D", 130.2);

    // Sequence "leaves" has patterns "Ants" and "Caterpillars"
    IntegrationTestEntity.insertPattern(1, 1, PatternType.Main, PatternState.Published, 16, "Ants", 0.583, "D minor", 120.0);
    IntegrationTestEntity.insertSequencePattern(110, 1, 1, 0);
    IntegrationTestEntity.insertPattern(2, 1, PatternType.Main, PatternState.Published, 16, "Caterpillars", 0.583, "E major", 140.0);
    IntegrationTestEntity.insertSequencePattern(211, 1, 2, 1);

    // Instantiate the test subject
    testDAO = injector.getInstance(PatternDAO.class);
  }

  private void createInjector() {
    injector = Guice.createInjector(Modules.override(new CoreModule()).with(
      new AbstractModule() {
        @Override
        public void configure() {
          bind(WorkManager.class).toInstance(workManager);
        }
      }));
  }

  @Test
  public void create() throws Exception {
    Access access = new Access(ImmutableMap.of(
      "roles", "Artist",
      "accounts", "1"
    ));
    Pattern inputData = new Pattern()
      .setDensity(0.42)
      .setKey("G minor 7")
      .setSequenceId(BigInteger.valueOf(2L))
      .setTypeEnum(PatternType.Macro)
      .setName("cannons")
      .setTempo(129.4)
      .setTotal(16);

    Pattern result = testDAO.create(access, inputData);

    assertNotNull(result);
    assertEquals(0.42, result.getDensity(), 0.01);
    assertEquals("G minor 7", result.getKey());
    assertEquals(BigInteger.valueOf(2L), result.getSequenceId());
    assertEquals("cannons", result.getName());
    assertEquals(129.4, result.getTempo(), 0.01);
    assertEquals(Integer.valueOf(16), result.getTotal());
  }

  /**
   [#159669804] Artist wants a step sequencer in order to compose rhythm patterns in a familiar way.
   */
  @Test
  public void create_meterDefault() throws Exception {
    IntegrationTestEntity.insertSequence(27, 2, 1, SequenceType.Rhythm, SequenceState.Published, "beets", 0.342, "D minor", 120);
    Access access = new Access(ImmutableMap.of(
      "roles", "Artist",
      "accounts", "1"
    ));
    Pattern inputData = new Pattern()
      .setDensity(0.42)
      .setKey("G minor 7")
      .setSequenceId(BigInteger.valueOf(27L))
      .setTypeEnum(PatternType.Loop)
      .setName("cannons")
      .setTempo(129.4)
      .setTotal(16);

    Pattern result = testDAO.create(access, inputData);

    assertNotNull(result);
    assertEquals(Integer.valueOf(4), result.getMeterSuper());
    assertEquals(Integer.valueOf(4), result.getMeterSub());
    assertEquals(Integer.valueOf(0), result.getMeterSwing());
  }

  /**
   [#153976073] Artist wants Macro-type Sequence to have Macro-type Pattern
   */
  @Test
  public void create_failsWithWrongTypeForMacroSequence() throws Exception {
    Access access = new Access(ImmutableMap.of(
      "roles", "Artist",
      "accounts", "1"
    ));
    Pattern inputData = new Pattern()
      .setDensity(0.42)
      .setKey("G minor 7")
      .setSequenceId(BigInteger.valueOf(2L))
      .setTypeEnum(PatternType.Loop)
      .setName("cannons")
      .setTempo(129.4)
      .setTotal(16);

    failure.expect(CoreException.class);
    failure.expectMessage("Macro-type Pattern in Macro-type Sequence is required");

    testDAO.create(access, inputData);
  }

  /**
   [#153976073] Artist wants Main-type Sequence to have Main-type Pattern
   */
  @Test
  public void create_failsWithWrongTypeForMainSequence() throws Exception {
    Access access = new Access(ImmutableMap.of(
      "roles", "Artist",
      "accounts", "1"
    ));
    Pattern inputData = new Pattern()
      .setDensity(0.42)
      .setKey("G minor 7")
      .setSequenceId(BigInteger.valueOf(1L))
      .setTypeEnum(PatternType.Loop)
      .setName("cannons")
      .setTempo(129.4)
      .setTotal(16);

    failure.expect(CoreException.class);
    failure.expectMessage("Main-type Pattern in Main-type Sequence is required");

    testDAO.create(access, inputData);
  }

  /**
   [#153976073] Artist wants Rhythm-type Sequence to have Intro-, Loop-, or Outro- type Pattern
   */
  @Test
  public void create_failsWithWrongTypeForRhythmSequence() throws Exception {
    IntegrationTestEntity.insertSequence(51, 2, 1, SequenceType.Rhythm, SequenceState.Published, "tester-b", 0.342, "C#", 110.286);
    Access access = new Access(ImmutableMap.of(
      "roles", "Artist",
      "accounts", "1"
    ));
    Pattern inputData = new Pattern()
      .setDensity(0.42)
      .setKey("G minor 7")
      .setSequenceId(BigInteger.valueOf(51L))
      .setTypeEnum(PatternType.Main)
      .setName("cannons")
      .setTempo(129.4)
      .setTotal(16);

    failure.expect(CoreException.class);
    failure.expectMessage("Pattern of type (Intro,Loop,Outro) in Rhythm-type Sequence is required");

    testDAO.create(access, inputData);
  }

  /**
   [#153976073] Artist wants Detail-type Sequence to have Intro-, Loop-, or Outro- type Pattern
   */
  @Test
  public void create_failsWithWrongTypeForDetailSequence() throws Exception {
    IntegrationTestEntity.insertSequence(51, 2, 1, SequenceType.Detail, SequenceState.Published, "tester-b", 0.342, "C#", 110.286);
    Access access = new Access(ImmutableMap.of(
      "roles", "Artist",
      "accounts", "1"
    ));
    Pattern inputData = new Pattern()
      .setDensity(0.42)
      .setKey("G minor 7")
      .setSequenceId(BigInteger.valueOf(51L))
      .setTypeEnum(PatternType.Main)
      .setName("cannons")
      .setTempo(129.4)
      .setTotal(16);

    failure.expect(CoreException.class);
    failure.expectMessage("Pattern of type (Intro,Loop,Outro) in Detail-type Sequence is required");

    testDAO.create(access, inputData);
  }

  @Test
  public void create_TotalNotRequiredForMacroSequencePattern() throws Exception {
    Access access = new Access(ImmutableMap.of(
      "roles", "Artist",
      "accounts", "1"
    ));
    Pattern inputData = new Pattern()
      .setDensity(0.42)
      .setKey("G minor 7")
      .setSequenceId(BigInteger.valueOf(2L))
      .setTypeEnum(PatternType.Macro)
      .setName("cannons")
      .setTempo(129.4);

    Pattern result = testDAO.create(access, inputData);

    assertNotNull(result);
    assertNull(result.getTotal());
  }

  /**
   [#150279647] Artist wants to create multiple Patterns with the same offset in the same Sequence, in order that XJ randomly select one of the patterns at that offset.
   Reverts legacy [Trello#237] shouldn't be able to create pattern with same offset in sequence
   */
  @Test
  public void create_MultiplePatternsAtSameOffset() throws Exception {
    Access access = new Access(ImmutableMap.of(
      "roles", "Admin"
    ));
    Pattern inputData = new Pattern()
      .setDensity(0.42)
      .setSequenceId(BigInteger.valueOf(1L))
      .setTypeEnum(PatternType.Main)
      .setKey("G minor 7")
      .setName("cannons")
      .setTempo(129.4)
      .setTotal(16);

    Pattern result = testDAO.create(access, inputData);
    assertNotNull(result);
  }

  @Test
  public void create_TotalIsRequiredForNonMacroTypeSequencePattern() throws Exception {
    Access access = new Access(ImmutableMap.of(
      "roles", "Artist",
      "accounts", "1"
    ));
    Pattern inputData = new Pattern()
      .setDensity(0.42)
      .setKey("G minor 7")
      .setSequenceId(BigInteger.valueOf(1L))
      .setTypeEnum(PatternType.Main)
      .setName("cannons")
      .setTempo(129.4);

    failure.expect(CoreException.class);
    failure.expectMessage("for a pattern of a non-macro-type sequence, total (# beats) must be greater than zero");

    testDAO.create(access, inputData);
  }

  @Test
  public void create_TotalMustBeGreaterThanZeroForNonMacroTypeSequencePattern() throws Exception {
    Access access = new Access(ImmutableMap.of(
      "roles", "Artist",
      "accounts", "1"
    ));
    Pattern inputData = new Pattern()
      .setDensity(0.42)
      .setKey("G minor 7")
      .setSequenceId(BigInteger.valueOf(1L))
      .setTypeEnum(PatternType.Main)
      .setName("cannons")
      .setTempo(129.4)
      .setTotal(0);

    failure.expect(CoreException.class);
    failure.expectMessage("for a pattern of a non-macro-type sequence, total (# beats) must be greater than zero");

    testDAO.create(access, inputData);
  }

  @Test
  public void create_NullOptionalFieldsAllowed() throws Exception {
    Access access = new Access(ImmutableMap.of(
      "roles", "Artist",
      "accounts", "1"
    ));
    Pattern inputData = new Pattern()
      .setDensity(null)
      .setKey(null)
      .setSequenceId(BigInteger.valueOf(2L))
      .setTypeEnum(PatternType.Macro)
      .setName(null)
      .setTempo(null)
      .setTotal(16);

    Pattern result = testDAO.create(access, inputData);

    assertNotNull(result);
    assertEquals(BigInteger.valueOf(2L), result.getSequenceId());
    assertNull(result.getDensity());
    assertNull(result.getKey());
    assertNull(result.getName());
    assertNull(result.getTempo());
    assertEquals(Integer.valueOf(16), result.getTotal());
  }

  @Test
  public void create_FailsWithoutSequenceID() throws Exception {
    Access access = new Access(ImmutableMap.of(
      "roles", "Artist",
      "accounts", "1"
    ));
    Pattern inputData = new Pattern()
      .setTypeEnum(PatternType.Macro)
      .setDensity(0.42)
      .setKey("G minor 7")
      .setName("cannons")
      .setTempo(129.4)
      .setTotal(16);

    failure.expect(CoreException.class);
    failure.expectMessage("Sequence ID is required");

    testDAO.create(access, inputData);
  }

  @Test
  public void clone_fromOriginal() throws Exception {
    Access access = new Access(ImmutableMap.of(
      "userId", "2",
      "roles", "User",
      "accounts", "1"
    ));
    Pattern inputData = new Pattern()
      .setSequenceId(BigInteger.valueOf(2L))
      .setTypeEnum(PatternType.Macro)
      .setName("cannons fifty nine");

    Pattern result = testDAO.clone(access, BigInteger.valueOf(1L), inputData);

    assertNotNull(result);
    assertEquals(0.583, result.getDensity(), 0.01);
    assertEquals("D minor", result.getKey());
    assertEquals(BigInteger.valueOf(2L), result.getSequenceId());
    assertEquals("cannons fifty nine", result.getName());
    assertEquals(120.0, result.getTempo(), 0.1);

    // Verify enqueued audio clone jobs
    verify(workManager).doPatternClone(eq(BigInteger.valueOf(1L)), any());
  }

  /**
   [#150279647] Artist wants to create multiple Patterns with the same offset in the same Sequence, in order that XJ randomly select one of the patterns at that offset.
   */
  @Test
  public void clone_fromOriginal_toOffsetOfExistingPattern() throws Exception {
    Access access = new Access(ImmutableMap.of(
      "userId", "2",
      "roles", "User",
      "accounts", "1"
    ));
    Pattern inputData = new Pattern()
      .setSequenceId(BigInteger.valueOf(1L))
      .setTypeEnum(PatternType.Main)
      .setName("cannons fifty nine");

    Pattern result = testDAO.clone(access, BigInteger.valueOf(1L), inputData);

    assertNotNull(result);
  }

  @Test
  public void readOne() throws Exception {
    Access access = new Access(ImmutableMap.of(
      "roles", "Artist",
      "accounts", "1"
    ));

    Pattern result = testDAO.readOne(access, BigInteger.valueOf(2L));

    assertNotNull(result);
    assertEquals(BigInteger.valueOf(2L), result.getId());
    assertEquals(BigInteger.valueOf(1L), result.getSequenceId());
    assertEquals("Caterpillars", result.getName());
  }

  @Test
  public void readOne_FailsWhenUserIsNotInAccount() throws Exception {
    Access access = new Access(ImmutableMap.of(
      "roles", "Artist",
      "accounts", "326"
    ));
    failure.expect(CoreException.class);
    failure.expectMessage("does not exist");

    testDAO.readOne(access, BigInteger.valueOf(1L));
  }

  @Test
  public void readAllAtSequenceOffset_Zero() throws Exception {
    Access access = new Access(ImmutableMap.of(
      "roles", "Artist",
      "accounts", "1"
    ));

    Collection<Pattern> result = testDAO.readAllAtSequenceOffset(access, BigInteger.valueOf(1L), BigInteger.valueOf(0L));

    assertNotNull(result);
    assertEquals(1L, result.size());
    Pattern resultOne = result.iterator().next();
    assertEquals("Ants", resultOne.getName());
  }

  @Test
  public void readAllAtSequenceOffset_One() throws Exception {
    Access access = new Access(ImmutableMap.of(
      "roles", "Artist",
      "accounts", "1"
    ));

    Collection<Pattern> result = testDAO.readAllAtSequenceOffset(access, BigInteger.valueOf(1L), BigInteger.valueOf(1L));

    assertNotNull(result);
    assertEquals(1L, result.size());
    Pattern resultOne = result.iterator().next();
    assertEquals("Caterpillars", resultOne.getName());
  }

  /**
   [#161076729] Artist wants detail and rhythm patterns to require no sequence-pattern bindings, to keep things simple
   */
  @Test
  public void readAllAtSequenceOffset_RhythmPatternsHaveNoSequencePatternBinding() throws Exception {
    IntegrationTestEntity.insertSequence(5, 2, 1, SequenceType.Rhythm, SequenceState.Published, "b-a-N-A-N-a-s", 8.02, "D", 130.2);
    IntegrationTestEntity.insertPattern(12, 5, PatternType.Loop, PatternState.Published, 16, "Antelope", 0.583, "D minor", 120.0);
    IntegrationTestEntity.insertPattern(14, 5, PatternType.Intro, PatternState.Published, 16, "Bear", 0.583, "E major", 140.0);
    IntegrationTestEntity.insertPattern(15, 5, PatternType.Outro, PatternState.Published, 16, "Cat", 0.583, "E major", 140.0);
    Access access = new Access(ImmutableMap.of(
      "roles", "Artist",
      "accounts", "1"
    ));

    Collection<Pattern> result = testDAO.readAllAtSequenceOffset(access, BigInteger.valueOf(5L), BigInteger.valueOf(69L));

    assertNotNull(result);
    assertEquals(3L, result.size());
    Iterator<Pattern> it = result.iterator();
    assertEquals("Cat", it.next().getName());
    assertEquals("Bear", it.next().getName());
    assertEquals("Antelope", it.next().getName());
  }

  /**
   [#161076729] Artist wants detail and rhythm patterns to require no sequence-pattern bindings, to keep things simple
   */
  @Test
  public void readAllAtSequenceOffset_DetailPatternsHaveNoSequencePatternBinding() throws Exception {
    IntegrationTestEntity.insertSequence(5, 2, 1, SequenceType.Detail, SequenceState.Published, "b-a-N-A-N-a-s", 8.02, "D", 130.2);
    IntegrationTestEntity.insertPattern(12, 5, PatternType.Loop, PatternState.Published, 16, "Antelope", 0.583, "D minor", 120.0);
    IntegrationTestEntity.insertPattern(14, 5, PatternType.Intro, PatternState.Published, 16, "Bear", 0.583, "E major", 140.0);
    IntegrationTestEntity.insertPattern(15, 5, PatternType.Outro, PatternState.Published, 16, "Cat", 0.583, "E major", 140.0);
    Access access = new Access(ImmutableMap.of(
      "roles", "Artist",
      "accounts", "1"
    ));

    Collection<Pattern> result = testDAO.readAllAtSequenceOffset(access, BigInteger.valueOf(5L), BigInteger.valueOf(69L));

    assertNotNull(result);
    assertEquals(3L, result.size());
    Iterator<Pattern> it = result.iterator();
    assertEquals("Cat", it.next().getName());
    assertEquals("Bear", it.next().getName());
    assertEquals("Antelope", it.next().getName());
  }

  /**
   [#150279647] Artist wants to create multiple Patterns with the same offset in the same Sequence, in order that XJ randomly select one of the patterns at that offset.
   */
  @Test
  public void readAllAtSequenceOffset_multiplePatternsAtOffset() throws Exception {
    IntegrationTestEntity.insertPattern(5, 1, PatternType.Main, PatternState.Published, 16, "Army Ants", 0.683, "Eb minor", 122.4);
    IntegrationTestEntity.insertSequencePattern(510, 1, 5, 0);
    Access access = new Access(ImmutableMap.of(
      "roles", "Artist",
      "accounts", "1"
    ));

    Collection<Pattern> result = testDAO.readAllAtSequenceOffset(access, BigInteger.valueOf(1L), BigInteger.valueOf(0L));

    assertNotNull(result);
    assertEquals(2L, result.size());
    Iterator<Pattern> it = result.iterator();
    assertEquals("Army Ants", it.next().getName());
    assertEquals("Ants", it.next().getName());
  }


  @Test
  public void readAllAtSequenceOffset_FailsWhenUserIsNotInAccount() throws Exception {
    Access access = new Access(ImmutableMap.of(
      "roles", "Artist",
      "accounts", "143"
    ));

    Collection<Pattern> result = testDAO.readAllAtSequenceOffset(access, BigInteger.valueOf(1L), BigInteger.valueOf(1L));

    assertNotNull(result);
    assertTrue(result.isEmpty());
  }

  @Test
  public void readAll() throws Exception {
    Access access = new Access(ImmutableMap.of(
      "roles", "Artist",
      "accounts", "1"
    ));

    Collection<Pattern> result = testDAO.readAll(access, ImmutableList.of(BigInteger.valueOf(1L)));

    assertEquals(2L, result.size());
    Iterator<Pattern> resultIt = result.iterator();
    assertEquals("Ants", resultIt.next().getName());
    assertEquals("Caterpillars", resultIt.next().getName());
  }

  @Test
  public void readAll_SeesNothingOutsideOfLibrary() throws Exception {
    Access access = new Access(ImmutableMap.of(
      "roles", "Artist",
      "accounts", "345"
    ));

    Collection<Pattern> result = testDAO.readAll(access, ImmutableList.of(BigInteger.valueOf(1L)));

    assertEquals(0L, result.size());
  }

  @Test
  public void readAll_excludesPatternsInEraseState() throws Exception {
    IntegrationTestEntity.insertPattern(27, 1, PatternType.Main, PatternState.Erase, 16, "Ants", 0.583, "D minor", 120.0);
    IntegrationTestEntity.insertSequencePattern(2710, 1, 27, 0);
    Access access = new Access(ImmutableMap.of(
      "roles", "User",
      "accounts", "1"
    ));

    Collection<Pattern> result = testDAO.readAll(access, ImmutableList.of(BigInteger.valueOf(1L)));

    assertEquals(2L, result.size());
    Iterator<Pattern> resultIt = result.iterator();
    assertEquals("Ants", resultIt.next().getName());
    assertEquals("Caterpillars", resultIt.next().getName());
  }

  // future test: DAO cannot update Sequence to a User or Library not owned by current session

  @Test
  public void update() throws Exception {
    Access access = new Access(ImmutableMap.of(
      "roles", "Artist",
      "accounts", "1"
    ));
    Pattern inputData = new Pattern()
      .setSequenceId(BigInteger.valueOf(1L))
      .setTypeEnum(PatternType.Main)
      .setTotal(32)
      .setName(null)
      .setDensity(null)
      .setKey("")
      .setTempo((double) 0);

    testDAO.update(access, BigInteger.valueOf(1L), inputData);

    Pattern result = testDAO.readOne(Access.internal(), BigInteger.valueOf(1L));
    assertNotNull(result);
    assertNull(result.getName());
    assertNull(result.getDensity());
    assertNull(result.getTempo());
    assertNull(result.getKey());
    assertEquals(Integer.valueOf(32), result.getTotal());
    assertEquals(BigInteger.valueOf(1L), result.getSequenceId());
  }

  /**
   [#159669804] Artist wants a step sequencer in order to compose rhythm patterns in a familiar way.
   */
  @Test
  public void update_meter() throws Exception {
    Access access = new Access(ImmutableMap.of(
      "roles", "Artist",
      "accounts", "1"
    ));
    Pattern inputData = new Pattern()
      .setSequenceId(BigInteger.valueOf(1L))
      .setTypeEnum(PatternType.Main)
      .setTotal(32)
      .setName(null)
      .setDensity(null)
      .setKey("")
      .setTempo((double) 0)
      .setMeterSuper(48)
      .setMeterSub(16)
      .setMeterSwing(35);

    testDAO.update(access, BigInteger.valueOf(1L), inputData);

    Pattern result = testDAO.readOne(Access.internal(), BigInteger.valueOf(1L));
    assertNotNull(result);
    assertEquals(Integer.valueOf(48), result.getMeterSuper());
    assertEquals(Integer.valueOf(16), result.getMeterSub());
    assertEquals(Integer.valueOf(35), result.getMeterSwing());
  }

  /**
   [#150279647] Artist wants to create multiple Patterns with the same offset in the same Sequence, in order that XJ randomly select one of the patterns at that offset.
   */
  @Test
  public void update_toOffsetOfExistingPattern() throws Exception {
    Access access = new Access(ImmutableMap.of(
      "roles", "Artist",
      "accounts", "1"
    ));
    Pattern inputData = new Pattern()
      .setSequenceId(BigInteger.valueOf(1L))
      .setTypeEnum(PatternType.Main)
      .setTotal(16)
      .setName("Caterpillars")
      .setDensity(0.583)
      .setKey("E major")
      .setTempo(140.0);

    testDAO.update(access, BigInteger.valueOf(2L), inputData);

    Pattern result = testDAO.readOne(Access.internal(), BigInteger.valueOf(2L));
    assertNotNull(result);
  }

  @Test
  public void update_FailsWithoutSequenceID() throws Exception {
    Access access = new Access(ImmutableMap.of(
      "roles", "Artist",
      "accounts", "1"
    ));
    Pattern inputData = new Pattern()
      .setTypeEnum(PatternType.Macro)
      .setDensity(0.42)
      .setKey("G minor 7")
      .setName("cannons")
      .setTempo(129.4)
      .setTotal(16);

    failure.expect(CoreException.class);
    failure.expectMessage("Sequence ID is required");

    testDAO.update(access, BigInteger.valueOf(1L), inputData);
  }

  @Test
  public void update_TotalNotRequiredForMacroSequencePattern() throws Exception {
    Access access = new Access(ImmutableMap.of(
      "roles", "Artist",
      "accounts", "1"
    ));
    Pattern inputData = new Pattern()
      .setTypeEnum(PatternType.Macro)
      .setDensity(0.42)
      .setKey("G minor 7")
      .setSequenceId(BigInteger.valueOf(2L))
      .setTypeEnum(PatternType.Macro)
      .setName("cannons")
      .setTempo(129.4);

    testDAO.update(access, BigInteger.valueOf(1L), inputData);
  }

  @Test
  public void update_TotalIsRequiredForNonMacroTypeSequencePattern() throws Exception {
    Access access = new Access(ImmutableMap.of(
      "roles", "Artist",
      "accounts", "1"
    ));
    Pattern inputData = new Pattern()
      .setDensity(0.42)
      .setKey("G minor 7")
      .setSequenceId(BigInteger.valueOf(1L))
      .setTypeEnum(PatternType.Main)
      .setName("cannons")
      .setTempo(129.4);

    failure.expect(CoreException.class);
    failure.expectMessage("for a pattern of a non-macro-type sequence, total (# beats) must be greater than zero");

    testDAO.update(access, BigInteger.valueOf(1L), inputData);
  }

  @Test
  public void update_TotalMustBeGreaterThanZeroForNonMacroTypeSequencePattern() throws Exception {
    Access access = new Access(ImmutableMap.of(
      "roles", "Artist",
      "accounts", "1"
    ));
    Pattern inputData = new Pattern()
      .setDensity(0.42)
      .setKey("G minor 7")
      .setSequenceId(BigInteger.valueOf(1L))
      .setTypeEnum(PatternType.Main)
      .setName("cannons")
      .setTempo(129.4)
      .setTotal(0);

    failure.expect(CoreException.class);
    failure.expectMessage("for a pattern of a non-macro-type sequence, total (# beats) must be greater than zero");

    testDAO.update(access, BigInteger.valueOf(1L), inputData);
  }

  @Test
  public void update_FailsUpdatingToNonexistentSequence() throws Exception {
    Access access = new Access(ImmutableMap.of(
      "roles", "Artist",
      "accounts", "1"
    ));
    Pattern inputData = new Pattern()
      .setDensity(0.42)
      .setKey("G minor 7")
      .setSequenceId(BigInteger.valueOf(57L))
      .setTypeEnum(PatternType.Macro)
      .setName("Smash!")
      .setTempo(129.4)
      .setTotal(16);

    failure.expect(CoreException.class);
    failure.expectMessage("Sequence does not exist");

    try {
      testDAO.update(access, BigInteger.valueOf(2L), inputData);

    } catch (Exception e) {
      Pattern result = testDAO.readOne(Access.internal(), BigInteger.valueOf(2L));
      assertNotNull(result);
      assertEquals("Caterpillars", result.getName());
      assertEquals(BigInteger.valueOf(1L), result.getSequenceId());
      throw e;
    }
  }

  @Test
  public void destroy() throws Exception {
    Access access = new Access(ImmutableMap.of(
      "roles", "Artist",
      "accounts", "1"
    ));

    testDAO.destroy(access, BigInteger.valueOf(1L));

    IntegrationTestEntity.assertNotExist(testDAO, BigInteger.valueOf(1L));
  }

  @Test(expected = CoreException.class)
  public void destroy_failsIfNotInAccount() throws Exception {
    Access access = new Access(ImmutableMap.of(
      "roles", "Artist",
      "accounts", "2"
    ));

    testDAO.destroy(access, BigInteger.valueOf(1L));
  }

  @Test
  public void destroy_SucceedsEvenIfSequenceHasManyChildren() throws Exception {
    Access access = new Access(ImmutableMap.of(
      "userId", "2",
      "roles", "Artist",
      "accounts", "1"
    ));
    IntegrationTestEntity.insertSequencePattern(1901, 1, 1, 0, Instant.parse("2017-02-14T12:01:00.000001Z"));
    IntegrationTestEntity.insertSequencePatternMeme(1901, "mashup");
    IntegrationTestEntity.insertPatternChord(1, 0, "G");
    IntegrationTestEntity.insertPatternChord(1, 2, "D");
    IntegrationTestEntity.insertVoice(2051, 1, InstrumentType.Percussive, "Smash");
    IntegrationTestEntity.insertPatternEvent(1, 2051, 1.0, 4.0, "Bang", "G2", 0, 1.0);
    IntegrationTestEntity.insertPatternEvent(1, 2051, 3.0, 4.0, "Crash", "D2", 0, 1.0);
    IntegrationTestEntity.insertVoice(2052, 1, InstrumentType.Percussive, "Boom");
    IntegrationTestEntity.insertPatternEvent(1, 2052, 0, 4.0, "Poom", "C3", 1.0, 1.0);
    IntegrationTestEntity.insertPatternEvent(1, 2052, 2.0, 4.0, "Paam", "F4", 1.0, 1.0);
    IntegrationTestEntity.insertInstrument(9, 1, 2, "jams", InstrumentType.Percussive, 0.6);

    testDAO.destroy(access, BigInteger.valueOf(1L));

    // Assert total annihilation
    IntegrationTestEntity.assertNotExist(testDAO, BigInteger.valueOf(1L));
    IntegrationTestEntity.assertNotExist(injector.getInstance(PatternEventDAO.class), BigInteger.valueOf(2061L));
    IntegrationTestEntity.assertNotExist(injector.getInstance(PatternEventDAO.class), BigInteger.valueOf(2062L));
    IntegrationTestEntity.assertNotExist(injector.getInstance(PatternEventDAO.class), BigInteger.valueOf(2063L));
    IntegrationTestEntity.assertNotExist(injector.getInstance(PatternEventDAO.class), BigInteger.valueOf(2064L));
    IntegrationTestEntity.assertNotExist(injector.getInstance(PatternChordDAO.class), BigInteger.valueOf(2012L));
    IntegrationTestEntity.assertNotExist(injector.getInstance(PatternChordDAO.class), BigInteger.valueOf(2011L));
    IntegrationTestEntity.assertNotExist(injector.getInstance(SequencePatternMemeDAO.class), BigInteger.valueOf(2001L));
  }

  // future test: PatternDAO cannot destroy record unless user has account access

  @Test
  public void erase_SucceedsEvenWithChildren() throws Exception {
    Access access = new Access(ImmutableMap.of(
      "userId", "2",
      "roles", "Artist",
      "accounts", "1"
    ));
    testDAO.erase(access, BigInteger.valueOf(1L));

    Pattern result = testDAO.readOne(Access.internal(), BigInteger.valueOf(1L));
    assertNotNull(result);
    assertEquals(PatternState.Erase, result.getState());
  }


}
