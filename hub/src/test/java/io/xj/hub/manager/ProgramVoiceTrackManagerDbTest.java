// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.hub.manager;

import com.google.common.collect.ImmutableList;
import io.xj.hub.HubIntegrationTest;
import io.xj.hub.HubIntegrationTestFactory;
import io.xj.hub.IntegrationTestingFixtures;
import io.xj.hub.access.HubAccess;
import io.xj.hub.enums.InstrumentType;
import io.xj.hub.enums.ProgramState;
import io.xj.hub.enums.ProgramType;
import io.xj.hub.tables.pojos.ProgramSequencePatternEvent;
import io.xj.hub.tables.pojos.ProgramVoiceTrack;
import io.xj.lib.filestore.FileStoreProvider;
import io.xj.lib.http.HttpClientProvider;
import io.xj.lib.notification.NotificationProvider;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestInstance;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;

import java.util.Collection;
import java.util.Iterator;
import java.util.UUID;

import static io.xj.hub.IntegrationTestingFixtures.buildAccount;
import static io.xj.hub.IntegrationTestingFixtures.buildAccountUser;
import static io.xj.hub.IntegrationTestingFixtures.buildLibrary;
import static io.xj.hub.IntegrationTestingFixtures.buildProgram;
import static io.xj.hub.IntegrationTestingFixtures.buildProgramSequence;
import static io.xj.hub.IntegrationTestingFixtures.buildProgramSequenceBinding;
import static io.xj.hub.IntegrationTestingFixtures.buildProgramSequencePattern;
import static io.xj.hub.IntegrationTestingFixtures.buildProgramSequencePatternEvent;
import static io.xj.hub.IntegrationTestingFixtures.buildProgramVoice;
import static io.xj.hub.IntegrationTestingFixtures.buildProgramVoiceTrack;
import static io.xj.hub.IntegrationTestingFixtures.buildUser;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertThrows;

// future test: permissions of different users to readMany vs. of vs. update or destroy programs
@TestInstance(TestInstance.Lifecycle.PER_CLASS)
@SpringBootTest
public class ProgramVoiceTrackManagerDbTest {
  ProgramVoiceTrackManager testManager;
  HubIntegrationTest test;
  IntegrationTestingFixtures fake;
  ProgramVoiceTrack voiceTrack1a_0;
  ProgramSequencePatternEvent voiceTrack1a_0_event0;
  ProgramSequencePatternEvent voiceTrack1a_0_event1;

  @MockBean
  NotificationProvider notificationProvider;

  @MockBean
  HttpClientProvider httpClientProvider;

  @MockBean
  FileStoreProvider fileStoreProvider;

  @Autowired
  HubIntegrationTestFactory integrationTestFactory;

  @BeforeEach
  public void setUp() throws Exception {
    test = integrationTestFactory.build();
    fake = new IntegrationTestingFixtures(test);

    test.reset();

    // Account "bananas"
    fake.account1 = test.insert(buildAccount("bananas"));
// John has "user" and "admin" roles, belongs to account "bananas", has "google" auth
    fake.user2 = test.insert(buildUser("john", "john@email.com", "https://pictures.com/john.gif", "Admin"));

    // Jenny has a "user" role and belongs to account "bananas"
    fake.user3 = test.insert(buildUser("jenny", "jenny@email.com", "https://pictures.com/jenny.gif", "User"));
    test.insert(buildAccountUser(fake.account1, fake.user3));

    // Library "palm tree" has a program "Ants" and program "Ants"
    fake.library1 = test.insert(buildLibrary(fake.account1, "palm tree"));
    fake.program1 = test.insert(buildProgram(fake.library1, ProgramType.Main, ProgramState.Published, "ANTS", "C#", 120.0f, 0.6f));
    fake.program1_sequence1 = test.insert(buildProgramSequence(fake.program1, 4, "Ants", 0.583f, "D minor"));
    fake.program2 = test.insert(buildProgram(fake.library1, ProgramType.Beat, ProgramState.Published, "ANTS", "C#", 120.0f, 0.6f));
    fake.program702_voice1 = test.insert(buildProgramVoice(fake.program2, InstrumentType.Drum, "Drums"));
    fake.program2_sequence1_pattern1 = test.insert(buildProgramSequencePattern(fake.program1_sequence1, fake.program702_voice1, 4, "BOOMS"));
    voiceTrack1a_0 = test.insert(buildProgramVoiceTrack(fake.program702_voice1, "JAMS"));
    voiceTrack1a_0_event0 = test.insert(buildProgramSequencePatternEvent(fake.program2_sequence1_pattern1, voiceTrack1a_0, 0.0f, 1.0f, "C", 1.0f));
    voiceTrack1a_0_event1 = test.insert(buildProgramSequencePatternEvent(fake.program2_sequence1_pattern1, voiceTrack1a_0, 1.0f, 1.0f, "C", 1.0f));

    // Library "boat" has a program "helm" and program "sail"
    fake.library2 = test.insert(buildLibrary(fake.account1, "boat"));
    fake.program3 = test.insert(buildProgram(fake.library2, ProgramType.Macro, ProgramState.Published, "helm", "C#", 120.0f, 0.6f));
    fake.program3_sequence1 = test.insert(buildProgramSequence(fake.program3, 16, "Ants", 0.583f, "D minor"));
    test.insert(buildProgramSequenceBinding(fake.program3_sequence1, 0));
    fake.program4 = test.insert(buildProgram(fake.library2, ProgramType.Detail, ProgramState.Published, "sail", "C#", 120.0f, 0.6f));

    // Instantiate the test subject
    testManager = new ProgramVoiceTrackManagerImpl(test.getEntityFactory(), test.getSqlStoreProvider());
  }

  @AfterAll
  public void tearDown() {
    test.shutdown();
  }

  @Test
  public void create() throws Exception {
    HubAccess access = HubAccess.create(fake.user2, UUID.randomUUID(), ImmutableList.of(fake.account1));
    var subject = new ProgramVoiceTrack();
    subject.setId(UUID.randomUUID());
    subject.setProgramId(fake.program3.getId());
    subject.setProgramVoiceId(fake.program702_voice1.getId());
    subject.setName("Jams");

    var result = testManager.create(
      access, subject);

    assertNotNull(result);
    assertEquals(fake.program3.getId(), result.getProgramId());
    assertEquals(fake.program702_voice1.getId(), result.getProgramVoiceId());
    assertEquals("JAMS", result.getName());
  }

  /**
   * Artist expects to of a Main-type programVoiceTrack without crashing the entire platform https://www.pivotaltracker.com/story/show/156144567
   * NOTE: This simple test fails to invoke the complexity of database call that is/was creating this issue in production.
   */
  @Test
  public void create_asArtist() throws Exception {
    HubAccess access = HubAccess.create(fake.user2, UUID.randomUUID(), ImmutableList.of(fake.account1));
    var inputData = new ProgramVoiceTrack();
    inputData.setId(UUID.randomUUID());
    inputData.setProgramId(fake.program3.getId());
    inputData.setProgramVoiceId(fake.program702_voice1.getId());
    inputData.setName("Jams");

    var result = testManager.create(
      access, inputData);

    assertNotNull(result);
    assertEquals(fake.program3.getId(), result.getProgramId());
    assertEquals(fake.program702_voice1.getId(), result.getProgramVoiceId());
    assertEquals("JAMS", result.getName());
  }

  @Test
  public void readOne() throws Exception {
    HubAccess access = HubAccess.create(UUID.randomUUID(), UUID.randomUUID(), ImmutableList.of(fake.account1), "User, Artist");

    var result = testManager.readOne(access, voiceTrack1a_0.getId());

    assertNotNull(result);
    assertEquals(voiceTrack1a_0.getId(), result.getId());
    assertEquals(fake.program2.getId(), result.getProgramId());
    assertEquals("JAMS", result.getName());
  }

  @Test
  public void readOne_FailsWhenUserIsNotInLibrary() throws Exception {
    HubAccess access = HubAccess.create(UUID.randomUUID(), UUID.randomUUID(), ImmutableList.of(buildAccount("Testing")), "User, Artist");

    var e = assertThrows(ManagerException.class, () -> testManager.readOne(access, voiceTrack1a_0.getId()));
    assertEquals("Record does not exist", e.getMessage());
  }

  // future test: readManyInAccount vs readManyInLibraries, positive and negative cases

  @Test
  public void readMany() throws Exception {
    HubAccess access = HubAccess.create(UUID.randomUUID(), UUID.randomUUID(), ImmutableList.of(fake.account1), "User, Artist");

    Collection<ProgramVoiceTrack> result = testManager.readMany(access, ImmutableList.of(fake.program702_voice1.getId()));

    assertEquals(1L, result.size());
    Iterator<ProgramVoiceTrack> resultIt = result.iterator();
    assertEquals("JAMS", resultIt.next().getName());
  }

  @Test
  public void readMany_SeesNothingOutsideOfLibrary() throws Exception {
    HubAccess access = HubAccess.create(UUID.randomUUID(), UUID.randomUUID(), ImmutableList.of(buildAccount("Testing")), "User, Artist");

    Collection<ProgramVoiceTrack> result = testManager.readMany(access, ImmutableList.of(fake.program702_voice1.getId()));

    assertEquals(0L, result.size());
  }

  /**
   * Should be able to delete track with events in it https://www.pivotaltracker.com/story/show/180769781
   */
  @Test
  public void destroy_okWithChildEntities() throws Exception {
    HubAccess access = HubAccess.create("Admin");

    testManager.destroy(access, voiceTrack1a_0.getId());

    try (var selectCount = test.getDSL().selectCount()) {
      assertEquals(Integer.valueOf(0),
        selectCount.from(io.xj.hub.tables.ProgramVoiceTrack.PROGRAM_VOICE_TRACK)
          .where(io.xj.hub.tables.ProgramVoiceTrack.PROGRAM_VOICE_TRACK.ID.eq(voiceTrack1a_0.getId()))
          .fetchOne(0, int.class));
    }
  }

  @Test
  public void destroy_asArtist() throws Exception {
    HubAccess access = HubAccess.create(UUID.randomUUID(), UUID.randomUUID(), ImmutableList.of(fake.account1), "Artist");
    new ProgramSequencePatternEventManagerImpl(test.getEntityFactory(), test.getSqlStoreProvider()).destroy(HubAccess.internal(), voiceTrack1a_0_event0.getId());
    new ProgramSequencePatternEventManagerImpl(test.getEntityFactory(), test.getSqlStoreProvider()).destroy(HubAccess.internal(), voiceTrack1a_0_event1.getId());

    testManager.destroy(access, voiceTrack1a_0.getId());

    try (var selectCount = test.getDSL().selectCount()) {
      assertEquals(Integer.valueOf(0),
        selectCount.from(io.xj.hub.tables.ProgramVoiceTrack.PROGRAM_VOICE_TRACK)
          .where(io.xj.hub.tables.ProgramVoiceTrack.PROGRAM_VOICE_TRACK.ID.eq(voiceTrack1a_0.getId()))
          .fetchOne(0, int.class));
    }
  }

  @Test
  public void destroy_failsIfNotInAccount() throws Exception {
    fake.account2 = buildAccount("Testing");
    HubAccess access = HubAccess.create(UUID.randomUUID(), UUID.randomUUID(), ImmutableList.of(fake.account2), "Artist");
    new ProgramSequencePatternEventManagerImpl(test.getEntityFactory(), test.getSqlStoreProvider()).destroy(HubAccess.internal(), voiceTrack1a_0_event0.getId());
    new ProgramSequencePatternEventManagerImpl(test.getEntityFactory(), test.getSqlStoreProvider()).destroy(HubAccess.internal(), voiceTrack1a_0_event1.getId());

    var e = assertThrows(ManagerException.class, () -> testManager.destroy(access, voiceTrack1a_0.getId()));
    assertEquals("Track in Voice in Program you have access to does not exist", e.getMessage());
  }

  /**
   * Update ProgramVoiceTrack to belong to a different ProgramVoice https://www.pivotaltracker.com/story/show/175423724
   */
  @Test
  public void update_moveToDifferentVoice() throws Exception {
    HubAccess access = HubAccess.create(UUID.randomUUID(), UUID.randomUUID(), ImmutableList.of(fake.account1), "Artist");
    fake.program2_voice2 = test.insert(buildProgramVoice(fake.program2, InstrumentType.Drum, "Cans"));
    voiceTrack1a_0.setProgramVoiceId(fake.program2_voice2.getId());

    testManager.update(access, voiceTrack1a_0.getId(), voiceTrack1a_0);

    var result = testManager.readOne(access, voiceTrack1a_0.getId());
    assertEquals(fake.program2_voice2.getId(), result.getProgramVoiceId());
  }

}

