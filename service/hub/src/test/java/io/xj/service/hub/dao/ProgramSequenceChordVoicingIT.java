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
import io.xj.service.hub.entity.InstrumentType;
import io.xj.service.hub.entity.Library;
import io.xj.service.hub.entity.Program;
import io.xj.service.hub.entity.ProgramSequence;
import io.xj.service.hub.entity.ProgramSequenceChord;
import io.xj.service.hub.entity.ProgramSequenceChordVoicing;
import io.xj.service.hub.entity.ProgramState;
import io.xj.service.hub.entity.ProgramType;
import io.xj.service.hub.entity.ProgramVoice;
import io.xj.service.hub.entity.User;
import io.xj.service.hub.entity.UserRole;
import io.xj.service.hub.entity.UserRoleType;
import io.xj.service.hub.ingest.HubIngestModule;
import io.xj.service.hub.persistence.HubPersistenceModule;
import io.xj.service.hub.testing.HubIntegrationTestModule;
import io.xj.service.hub.testing.HubIntegrationTestProvider;
import io.xj.service.hub.testing.HubTestConfiguration;
import org.junit.After;
import org.junit.Before;
import org.junit.Rule;
import org.junit.Test;
import org.junit.rules.ExpectedException;
import org.junit.runner.RunWith;
import org.mockito.runners.MockitoJUnitRunner;

import java.time.Instant;
import java.util.Collection;
import java.util.Iterator;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

// future test: permissions of different users to readMany vs. of vs. update or destroy programs
@RunWith(MockitoJUnitRunner.class)
public class ProgramSequenceChordVoicingIT {
  @Rule
  public ExpectedException failure = ExpectedException.none();
  private ProgramSequenceChordVoicingDAO testDAO;

  private HubIntegrationTestProvider test;
  private IntegrationTestingFixtures fake;

  private ProgramSequenceChord sequenceChord1a_0;
  private ProgramSequenceChordVoicing sequenceChord1a_0_voicing0;

  @Before
  public void setUp() throws Exception {
    Config config = HubTestConfiguration.getDefault();
    Injector injector = AppConfiguration.inject(config, ImmutableSet.of(new HubAccessControlModule(), new DAOModule(), new HubIngestModule(), new HubPersistenceModule(), new MixerModule(), new JsonApiModule(), new FileStoreModule(), new HubIntegrationTestModule()));
    test = injector.getInstance(HubIntegrationTestProvider.class);
    fake = new IntegrationTestingFixtures(test);

    test.reset();

    // Account "bananas"
    fake.account1 = test.insert(Account.create("bananas"));

    // John has "user" and "admin" roles, belongs to account "bananas", has "google" auth
    fake.user2 = test.insert(User.create("john", "john@email.com", "http://pictures.com/john.gif"));
    test.insert(UserRole.create(fake.user2, UserRoleType.Admin));

    // Jenny has a "user" role and belongs to account "bananas"
    fake.user3 = test.insert(User.create("jenny", "jenny@email.com", "http://pictures.com/jenny.gif"));
    test.insert(UserRole.create(fake.user3, UserRoleType.User));
    test.insert(AccountUser.create(fake.account1, fake.user3));

    // Library "palm tree" has program "Ants" and program "Ants"
    fake.library1 = test.insert(Library.create(fake.account1, "palm tree", Instant.now()));
    fake.program1 = test.insert(Program.create(fake.user3, fake.library1, ProgramType.Main, ProgramState.Published, "Ants", "C#", 120.0, 0.6));
    fake.program1_sequence1 = test.insert(ProgramSequence.create(fake.program1, 4, "Ants", 0.583, "D minor", 120.0));
    sequenceChord1a_0 = test.insert(ProgramSequenceChord.create(fake.program1_sequence1, 0, "C minor"));
    sequenceChord1a_0_voicing0 = test.insert(ProgramSequenceChordVoicing.create(InstrumentType.Bass, sequenceChord1a_0, "C5, Eb5, G5"));
    ProgramSequenceChordVoicing sequenceChord1a_0_voicing1 = test.insert(ProgramSequenceChordVoicing.create(InstrumentType.Bass, sequenceChord1a_0, "G,B,Db,F"));
    fake.program2 = test.insert(Program.create(fake.user3, fake.library1, ProgramType.Rhythm, ProgramState.Published, "Ants", "C#", 120.0, 0.6));
    fake.program2_voice1 = test.insert(ProgramVoice.create(fake.program2, InstrumentType.Percussive, "Drums"));

    // Library "boat" has program "helm" and program "sail"
    fake.library2 = test.insert(Library.create(fake.account1, "boat", Instant.now()));
    fake.program3 = test.insert(Program.create(fake.user3, fake.library2, ProgramType.Macro, ProgramState.Published, "helm", "C#", 120.0, 0.6));
    fake.program3_sequence1 = test.insert(ProgramSequence.create(fake.program3, 16, "Ants", 0.583, "D minor", 120.0));
    fake.program3_chord1 = test.insert(ProgramSequenceChord.create(fake.program3_sequence1, 0, "G7 flat 6"));
    fake.program4 = test.insert(Program.create(fake.user3, fake.library2, ProgramType.Detail, ProgramState.Published, "sail", "C#", 120.0, 0.6));

    // Instantiate the test subject
    testDAO = injector.getInstance(ProgramSequenceChordVoicingDAO.class);
  }

  @After
  public void tearDown() {
    test.shutdown();
  }

  @Test
  public void create() throws Exception {
    HubAccess hubAccess = HubAccess.create(fake.user2, ImmutableList.of(fake.account1), "Artist");
    ProgramSequenceChordVoicing subject = ProgramSequenceChordVoicing.create()
      .setProgramId(fake.program3.getId())
      .setProgramSequenceChordId(fake.program3_chord1.getId())
      .setType(InstrumentType.Harmonic)
      .setNotes("C5, Eb5, G5");

    ProgramSequenceChordVoicing result = testDAO.create(hubAccess, subject);

    assertNotNull(result);
    assertEquals(fake.program3.getId(), result.getProgramId());
    assertEquals(fake.program3_chord1.getId(), result.getProgramSequenceChordId());
    assertEquals(InstrumentType.Harmonic, result.getType());
    assertEquals("C5, Eb5, G5", result.getNotes());
  }

  /**
   [#156144567] Artist expects to of a Main-type programSequenceChordVoicing without crashing the entire platform
   NOTE: This simple test fails to invoke the complexity of database call that is/was creating this issue in production.
   */
  @Test
  public void create_asArtist() throws Exception {
    HubAccess hubAccess = HubAccess.create(fake.user2, ImmutableList.of(fake.account1), "User,Artist");
    ProgramSequenceChordVoicing inputData = ProgramSequenceChordVoicing.create()
      .setProgramId(fake.program3.getId())
      .setProgramSequenceChordId(fake.program3_chord1.getId())
      .setType(InstrumentType.Bass)
      .setNotes("C5, Eb5, G5");

    ProgramSequenceChordVoicing result = testDAO.create(hubAccess, inputData);

    assertNotNull(result);
    assertEquals(fake.program3.getId(), result.getProgramId());
    assertEquals(fake.program3_chord1.getId(), result.getProgramSequenceChordId());
    assertEquals(InstrumentType.Bass, result.getType());
    assertEquals("C5, Eb5, G5", result.getNotes());
  }

  @Test
  public void readOne() throws Exception {
    HubAccess hubAccess = HubAccess.create(ImmutableList.of(fake.account1), "User, Artist");

    ProgramSequenceChordVoicing result = testDAO.readOne(hubAccess, sequenceChord1a_0_voicing0.getId());

    assertNotNull(result);
    assertEquals(sequenceChord1a_0_voicing0.getId(), result.getId());
    assertEquals(fake.program1.getId(), result.getProgramId());
    assertEquals(sequenceChord1a_0.getId(), result.getProgramSequenceChordId());
    assertEquals(InstrumentType.Bass, result.getType());
    assertEquals("C5, Eb5, G5", result.getNotes());
  }

  @Test
  public void readOne_FailsWhenUserIsNotInLibrary() throws Exception {
    HubAccess hubAccess = HubAccess.create(ImmutableList.of(Account.create()), "User, Artist");
    failure.expect(DAOException.class);
    failure.expectMessage("does not exist");

    testDAO.readOne(hubAccess, sequenceChord1a_0_voicing0.getId());
  }

  // future test: readManyInAccount vs readManyInLibraries, positive and negative cases

  @Test
  public void readMany() throws Exception {
    HubAccess hubAccess = HubAccess.create(ImmutableList.of(fake.account1), "Admin");

    Collection<ProgramSequenceChordVoicing> result = testDAO.readMany(hubAccess, ImmutableList.of(fake.program1.getId()));

    assertEquals(2L, result.size());
    Iterator<ProgramSequenceChordVoicing> resultIt = result.iterator();
    assertEquals("C5, Eb5, G5", resultIt.next().getNotes());
    assertEquals("G,B,Db,F", resultIt.next().getNotes());
  }

  @Test
  public void readMany_SeesNothingOutsideOfLibrary() throws Exception {
    HubAccess hubAccess = HubAccess.create(ImmutableList.of(Account.create()), "User, Artist");

    Collection<ProgramSequenceChordVoicing> result = testDAO.readMany(hubAccess, ImmutableList.of(fake.program1.getId()));

    assertEquals(0L, result.size());
  }

  @Test
  public void destroy_failsIfNotInAccount() throws Exception {
    fake.account2 = Account.create();
    HubAccess hubAccess = HubAccess.create(ImmutableList.of(fake.account2), "Artist");

    failure.expect(DAOException.class);
    failure.expectMessage("Voicing belongs to Program in Account you have hubAccess to does not exist");

    testDAO.destroy(hubAccess, sequenceChord1a_0_voicing0.getId());
  }

}
