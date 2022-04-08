// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.hub.manager;

import com.google.common.collect.ImmutableList;
import com.google.common.collect.ImmutableSet;
import com.google.inject.AbstractModule;
import com.google.inject.Guice;
import com.google.inject.util.Modules;
import io.xj.hub.HubIntegrationTestModule;
import io.xj.hub.HubIntegrationTestProvider;
import io.xj.hub.IntegrationTestingFixtures;
import io.xj.hub.access.HubAccess;
import io.xj.hub.access.HubAccessControlModule;
import io.xj.hub.enums.InstrumentMode;
import io.xj.hub.enums.InstrumentState;
import io.xj.hub.enums.InstrumentType;
import io.xj.hub.ingest.HubIngestModule;
import io.xj.hub.persistence.HubPersistenceModule;
import io.xj.hub.tables.pojos.InstrumentAudio;
import io.xj.lib.app.Environment;
import io.xj.lib.filestore.FileStoreModule;
import io.xj.lib.filestore.FileStoreProvider;
import io.xj.lib.filestore.S3UploadPolicy;
import io.xj.lib.jsonapi.JsonapiModule;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.Mock;
import org.mockito.junit.MockitoJUnitRunner;

import java.io.File;
import java.util.Collection;
import java.util.Map;
import java.util.UUID;

import static io.xj.hub.IntegrationTestingFixtures.*;
import static org.junit.Assert.*;
import static org.mockito.Mockito.*;

// future test: permissions of different users to readMany vs. of vs. update or delete instruments

// FUTURE: any test that

@RunWith(MockitoJUnitRunner.class)
public class InstrumentAudioManagerDbTest {
  @Mock
  public FileStoreProvider fileStoreProvider;
  private InstrumentAudioManager testManager;
  private HubIntegrationTestProvider test;
  private IntegrationTestingFixtures fake;

  @Before
  public void setUp() throws Exception {
    var env = Environment.getDefault();
    var injector = Guice.createInjector(Modules.override(ImmutableSet.of(new HubAccessControlModule(), new ManagerModule(), new HubIngestModule(), new HubPersistenceModule(), new JsonapiModule(), new FileStoreModule(), new HubIntegrationTestModule())).with(new AbstractModule() {
      @Override
      protected void configure() {
        bind(Environment.class).toInstance(env);
        bind(FileStoreProvider.class).toInstance(fileStoreProvider);
      }
    }));

    test = injector.getInstance(HubIntegrationTestProvider.class);
    fake = new IntegrationTestingFixtures(test);

    test.reset();

    // Account "bananas"
    fake.account1 = test.insert(buildAccount("bananas"));

    // John has "user" and "admin" roles, belongs to account "bananas", has "google" auth
    fake.user2 = test.insert(buildUser("john", "john@email.com", "https://pictures.com/john.gif", "Admin"));

    // Jenny has a "user" role and belongs to account "bananas"
    fake.user3 = test.insert(buildUser("jenny", "jenny@email.com", "https://pictures.com/jenny.gif", "User"));
    test.insert(buildAccountUser(fake.account1, fake.user3));

    // Library "sandwich" has instruments "jams" and instrument "buns"
    fake.library1 = test.insert(buildLibrary(fake.account1, "sandwich"));
    fake.instrument201 = test.insert(buildInstrument(fake.library1, InstrumentType.Pad, InstrumentMode.NoteEvent, InstrumentState.Published, "buns"));
    fake.instrument202 = test.insert(buildInstrument(fake.library1, InstrumentType.Drum, InstrumentMode.NoteEvent, InstrumentState.Published, "jams"));
    test.insert(buildInstrumentMeme(fake.instrument202, "smooth"));
    fake.audio1 = test.insert(buildInstrumentAudio(fake.instrument202, "Test audio", "fake.audio5.wav", 0.0f, 2.0f, 120.0f, 0.5f, "bing", "D", 1.0f));
    fake.audio2 = test.insert(buildInstrumentAudio(fake.instrument202, "Test audio2", "fake.audio5222.wav", 0.0f, 2.0f, 120.0f, 0.5f, "bang", "E", 1.0f));

    // Instantiate the test subject
    testManager = injector.getInstance(InstrumentAudioManager.class);
  }

  @After
  public void tearDown() {
    test.shutdown();
  }

  /**
   https://www.pivotaltracker.com/story/show/175213519 Expect new Audios to have no waveform
   <p>
   Expect audio event to be formatted
   */
  @Test
  public void create() throws Exception {
    HubAccess access = HubAccess.create(ImmutableList.of(fake.account1), "Artist");
    var inputData = buildInstrumentAudio(fake.instrument201, "maracas", null, 0.009f, 0.21f, 80.5f,0.6f, "b 5a !nG", "X", 1.0f);

    var result = testManager.create(access, inputData);

    verify(fileStoreProvider, times(0)).generateKey("instrument-" + fake.instrument202.getId() + "-audio", "wav");
    assertNotNull(result);
    assertEquals(fake.instrument201.getId(), result.getInstrumentId());
    assertEquals("maracas", result.getName());
    assertEquals("BANG", result.getEvent()); // cleaned up from original value: formatted as EVENT
    assertNull(result.getWaveformKey());
    assertEquals(0.009, result.getTransientSeconds(), 0.01);
    assertEquals(0.21, result.getTotalBeats(), 0.01);
    assertEquals(80.5, result.getTempo(), 0.01);
  }

  @Test
  public void create_FailsWithoutInstrumentID() {
    HubAccess access = HubAccess.create(ImmutableList.of(fake.account1), "Artist");
    var inputData = buildInstrumentAudio(fake.instrument201, "maracas", "instrument" + File.separator + "percussion" + File.separator + "demo_source_audio/808" + File.separator + "maracas.wav", 0.009f, 0.21f, 80.5f);
    inputData.setInstrumentId(null);

    var e = assertThrows(ManagerException.class, () -> testManager.create(access, inputData));

    assertEquals(e.getMessage(), "Instrument ID is required.");
  }

  /**
   https://www.pivotaltracker.com/story/show/175213519 Expect new Audios to have no waveform
   */
  @Test
  public void create_SucceedsWithoutWaveformKey() throws Exception {
    HubAccess access = HubAccess.create(ImmutableList.of(fake.account1), "Artist");
    var inputData = buildInstrumentAudio(fake.instrument202, "maracas", null, 0.009f, 0.21f, 80.5f);

    var result = testManager.create(
      access, inputData);

    verify(fileStoreProvider, times(0)).generateKey("instrument-" + fake.instrument202.getId() + "-audio", "wav");
    assertNull(result.getWaveformKey());
  }

  /**
   https://www.pivotaltracker.com/story/show/170290553 Clone sub-entities of instrument audios
   */
  @Test
  public void clone_fromOriginal() throws Exception {
    HubAccess access = HubAccess.create(ImmutableList.of(fake.account1), "Artist");
    var inputData = buildInstrumentAudio(fake.instrument202, "cannons fifty nine", "fake.audio5.wav", 0.01f, 2.0f, 120.0f);

    var result = testManager.clone(access, fake.audio1.getId(), inputData);

    assertEquals("cannons fifty nine", result.getName());
    assertEquals(fake.instrument202.getId(), result.getInstrumentId());
    assertEquals("fake.audio5.wav", result.getWaveformKey());
    assertEquals(0.6, result.getDensity(), 0.01);
    assertEquals(0.01, result.getTransientSeconds(), 0.01);
    assertEquals(2.0, result.getTotalBeats(), 0.01);
    assertEquals(120.0, result.getTempo(), 0.01);
  }

  /**
   Error when cloning Audios in Instruments https://www.pivotaltracker.com/story/show/180698009
   */
  @Test
  public void clone_fromOriginal_noInputData() throws Exception {
    HubAccess access = HubAccess.create(ImmutableList.of(fake.account1), "Artist");
    var inputData = new InstrumentAudio();
    inputData.setName("Clone of thing");

    var result = testManager.clone(access, fake.audio1.getId(), inputData);

    assertEquals("Clone of thing", result.getName());
    assertEquals(fake.instrument202.getId(), result.getInstrumentId());
    assertEquals("fake.audio5.wav", result.getWaveformKey());
    assertEquals(0.5, result.getDensity(), 0.01);
    assertEquals(0.01, result.getTransientSeconds(), 0.01);
    assertEquals(2.0, result.getTotalBeats(), 0.01);
    assertEquals(120.0, result.getTempo(), 0.01);
  }

  @Test
  public void readOne() throws Exception {
    HubAccess access = HubAccess.create(ImmutableList.of(fake.account1), "Artist");

    var result = testManager.readOne(access, fake.audio1.getId());

    assertNotNull(result);
    assertEquals(fake.instrument202.getId(), result.getInstrumentId());
    assertEquals("Test audio", result.getName());
    assertEquals("fake.audio5.wav", result.getWaveformKey());
    assertEquals(0.0, result.getTransientSeconds(), 0.01);
    assertEquals(2.0, result.getTotalBeats(), 0.01);
    assertEquals(120.0, result.getTempo(), 0.01);
  }

  @Test
  public void uploadOne() throws Exception {
    HubAccess access = HubAccess.create(ImmutableList.of(fake.account1), "Artist");

    when(fileStoreProvider.generateAudioUploadPolicy())
      .thenReturn(new S3UploadPolicy("MyId", "MySecret", "bucket-owner-is-awesome", "xj-audio-test", "", 5));
    when(fileStoreProvider.generateKey("instrument-" + fake.instrument202.getId() + "-audio", "wav"))
      .thenReturn("instrument-" + fake.instrument202.getId() + "-audio-123456789.wav");
    when(fileStoreProvider.getUploadURL())
      .thenReturn("https://coconuts.com");
    when(fileStoreProvider.getCredentialId())
      .thenReturn("MyId");
    when(fileStoreProvider.getAudioBucketName())
      .thenReturn("xj-audio-test");
    when(fileStoreProvider.getAudioUploadACL())
      .thenReturn("bucket-owner-is-awesome");

    Map<String, String> result = testManager.authorizeUpload(access, fake.audio2.getId(), "wav");

    assertNotNull(result);
    assertEquals("instrument-" + fake.instrument202.getId() + "-audio-123456789.wav", result.get("waveformKey"));
    assertEquals("xj-audio-test", result.get("bucketName"));
    assertNotNull(result.get("uploadPolicySignature"));
    assertEquals("https://coconuts.com", result.get("uploadUrl"));
    assertEquals("MyId", result.get("awsAccessKeyId"));
    assertNotNull(result.get("uploadPolicy"));
    assertEquals("bucket-owner-is-awesome", result.get("acl"));
  }

  @Test
  public void readMany() throws Exception {
    HubAccess access = HubAccess.create(ImmutableList.of(fake.account1), "Artist");

    Collection<InstrumentAudio> result = testManager.readMany(access, ImmutableList.of(fake.instrument202.getId()));

    assertEquals(2L, result.size());
  }

  @Test
  public void readMany_SeesNothingOutsideOfLibrary() throws Exception {
    HubAccess access = HubAccess.create(ImmutableList.of(), "Artist");

    Collection<InstrumentAudio> result = testManager.readMany(access, ImmutableList.of(fake.instrument202.getId()));

    assertEquals(0L, result.size());
  }

  @Test
  public void update_FailsWithoutInstrumentID() {
    HubAccess access = HubAccess.create(ImmutableList.of(fake.account1), "Artist");
    var inputData = buildInstrumentAudio(fake.instrument201, "maracas", "instrument" + File.separator + "percussion" + File.separator + "demo_source_audio/808" + File.separator + "maracas.wav", 0.009f, 0.21f, 80.5f);
    inputData.setInstrumentId(null);

    var e = assertThrows(ManagerException.class, () -> testManager.update(access, fake.audio1.getId(), inputData));

    assertEquals(e.getMessage(), "Instrument ID is required.");
  }

  @Test
  public void update_FailsUpdatingToNonexistentInstrument() throws Exception {
    HubAccess access = HubAccess.create(ImmutableList.of(fake.account1), "Artist");
    var inputData = new InstrumentAudio();
    inputData.setId(UUID.randomUUID());
    inputData.setInstrumentId(UUID.randomUUID());
    inputData.setName("maracas");
    inputData.setWaveformKey("instrument" + File.separator + "percussion" + File.separator + "demo_source_audio/808" + File.separator + "maracas.wav");
    inputData.setTransientSeconds(0.009f);
    inputData.setTotalBeats(0.21f);
    inputData.setTempo(80.5f);

    var e = assertThrows(ManagerException.class, () -> testManager.update(access, fake.audio2.getId(), inputData));

    assertEquals(e.getMessage(), "Instrument does not exist");
    var result = testManager.readOne(HubAccess.internal(), fake.audio2.getId());
    assertNotNull(result);
    assertEquals("Test audio2", result.getName());
    assertEquals(fake.instrument202.getId(), result.getInstrumentId());
  }


  // https://www.pivotaltracker.com/story/show/162361785 InstrumentAudio can be moved to a different Instrument
  @Test
  public void update() throws Exception {
    HubAccess access = HubAccess.create(ImmutableList.of(fake.account1), "Artist");
    var inputData = buildInstrumentAudio(fake.instrument201, "maracas", "fake.audio5.wav", 0.009f, 0.21f, 80.5f);

    testManager.update(access, fake.audio1.getId(), inputData);

    var result = testManager.readOne(HubAccess.internal(), fake.audio1.getId());
    assertNotNull(result);
    assertEquals(fake.instrument201.getId(), result.getInstrumentId());
    assertEquals("maracas", result.getName());
    assertEquals("fake.audio5.wav", result.getWaveformKey());
    assertEquals(0.009, result.getTransientSeconds(), 0.001);
    assertEquals(0.21, result.getTotalBeats(), 0.001);
    assertEquals(80.5, result.getTempo(), 0.001);
  }

  // FUTURE test: Manager cannot update Sequence to a User or Library not owned by current session

  @Test
  public void destroy_failsIfNotInAccount() throws Exception {
    HubAccess access = HubAccess.create(ImmutableList.of(), "Artist");

    var e = assertThrows(ManagerException.class, () -> testManager.destroy(access, fake.audio1.getId()));

    assertEquals(e.getMessage(), "InstrumentAudio does not exist");
  }

  @Test
  public void destroy_SucceedsEvenWithChildren() throws Exception {
    HubAccess access = HubAccess.create(fake.user2, ImmutableList.of(fake.account1));

    try {
      testManager.destroy(access, fake.audio1.getId());

    } catch (Exception e) {
      var result = testManager.readOne(HubAccess.internal(), fake.audio1.getId());
      assertNotNull(result);
      throw e;
    }
  }

  @Test
  public void destroy() throws Exception {
    HubAccess access = HubAccess.internal();

    testManager.destroy(access, fake.audio1.getId());

    try {
      testManager.readOne(HubAccess.internal(), fake.audio1.getId());
      fail();
    } catch (ManagerException e) {
      assertTrue("Record should not exist", e.getMessage().contains("does not exist"));
    }
  }

  // future test: AudioManager cannot delete record unless user has account access

  // future test: AudioManager cannot write to Waveform Key value on of or update- ONLY updated by generating an upload policy


/*

FUTURE address deleting audio after it has been picked


  @Test
  public void destroy_afterAudioHasBeenPicked() throws Exception {
    HubAccess access = HubAccess.internal();
    // EventEntity and ChordEntity on InstrumentAudio 1
    test.insert(new InstrumentAudioEvent()
.setId(UUID.randomUUID());
fake.audio1, 2.5, 1.0, "KICK", "Eb", 0.8);
    test.insert(new InstrumentAudioChord()
.setId(UUID.randomUUID());
fake.audio1, 4, "D major");
    // Sequence, Pattern, Voice
    test.insert(new Program()
.setId(UUID.randomUUID());
fake.user2, fake.library1, ProgramType.Macro, ProgramState.Published, "epic concept",  "C#", 0.342, 0.286);
    test.insert(new ProgramSequence()
.setId(UUID.randomUUID());
1, 1, PatternType.Macro, PatternState.Published, 16, "Ants", 0.583, "D minor", 120.0);
    test.insert(new ProgramSequencePattern()
.setId(UUID.randomUUID());
110, 1, 1, 0);
    test.insert(new ProgramVoice()
.setId(UUID.randomUUID());
8, 1, InstrumentType.Drum, "This is a drum voice");

    testManager.destroy(access, fake.audio1.getId());

    try {
      testManager.readOne(HubAccess.internal(), fake.audio1.getId());
      fail();
    } catch (ManagerException e) {
      assertTrue("Record should not exist", e.getMessage().contains("does not exist"));
    }
  }
*/







/*

  FUTURE tests for events and chords below



  @Before
  public void setUp() throws Exception {
    reset();

    var injector = Guice.createInjector(Modules.override(new CoreModule()).with(
      new AbstractModule() {
        @Override
        public void configure() {
          bind(FileStoreProvider.class).toInstance(fileStoreProvider);
          }
      }));
    audioFactory = injector.getInstance(AudioFactory.class);


    // Account "bananas"
    insert(of(1, "bananas");

    // John has "user" and "admin" roles, belongs to account "bananas", has "google" auth
    insert(of(2, "john", "john@email.com", "https://pictures.com/john.gif");
    insert(of(2, UserRoleType.Admin);

    // Library "palm tree" has sequence "leaves" and sequence "coconuts"
    insert(of(1, 1, "palm tree",now()));

    // Sequence "leaves" has instruments "808" and "909"
    insertInstrument(1, 1, 2, "808 Drums", InstrumentType.Drum, 0.9);
    insertInstrument(2, 1, 2, "909 Drums", InstrumentType.Drum, 0.8);

    // Instrument "808" has Audios "Kick" and "Snare"
    insertAudio(1, 1, "Published", "Kick", "instrument" + File.separator + "percussion" + File.separator + "808" + File.separator + "kick1.wav", 0.01, 2.123, 120.0, 440.0);
    insertAudio(2, 1, "Published", "Snare", "instrument" + File.separator + "percussion" + File.separator + "808" + File.separator + "snare.wav", 0.0023, 1.05, 131.0, 702.0);

    // Instantiate the test subject
    testManager = injector.getInstance(AudioManager.class);
  }




  @Test
  public void create() throws Exception {
    HubAccess access = HubAccess.create(ImmutableList.of(fake.account1), "Artist");
    AudioChord inputData = new AudioChord()
      .setPosition(4.0);
      .setName("G minor 7")
      .setInstrumentAudioId(UUID.randomUUID());

    AudioChord result = testManager.create(
access, inputData);

    assertNotNull(result);
    assertEquals(4.0, result.getPosition(), 0.01);
    assertEquals("G minor 7", result.getName());
    assertEquals(fake.audio1.getId(), result.getInstrumentAudioId());
  }

  @Test(expected = CoreException.class)
  public void create_FailsWithoutAudioID() throws Exception {
    HubAccess access = HubAccess.create(ImmutableList.of(fake.account1), "Artist");
    AudioChord inputData = new AudioChord()
      .setPosition(4.0);
      .setName("G minor 7");

    testManager.create(
access, inputData);
  }

  @Test(expected = CoreException.class)
  public void create_FailsWithoutName() throws Exception {
    HubAccess access = HubAccess.create(ImmutableList.of(fake.account1), "Artist");
    AudioChord inputData = new AudioChord()
      .setPosition(4.0);
      .setInstrumentAudioId(UUID.randomUUID());

    testManager.create(
access, inputData);
  }

  @Test
  public void readOne() throws Exception {
    HubAccess access = HubAccess.create(ImmutableList.of(fake.account1), "Artist");

    AudioChord result = testManager.readOne(access, 1000L);

    assertNotNull(result);
    assertEquals(fake.audio1.getId(), result.getInstrumentAudioId());
    assertEquals("D major", result.getName());
  }

  @Test
  public void readOne_FailsWhenUserIsNotInAccount() throws Exception {
    HubAccess access = of(ImmutableList.of(of()), "Artist");
    failure.expect(CoreException.class);
    failure.expectMessage("does not exist");

    testManager.readOne(access, 1000L);
  }

  @Test
  public void readMany() throws Exception {
    HubAccess access = HubAccess.create(ImmutableList.of(fake.account1), "Artist");

    Collection<AudioChord> result = testManager.readMany(access, ImmutableList.of(fake.audio1.getId()));

    assertEquals(2, result.size());
  }

  @Test
  public void readMany_SeesNothingOutsideOfLibrary() throws Exception {
    HubAccess access = of(ImmutableList.of(of()), "Artist");

    Collection<AudioChord> result = testManager.readMany(access, ImmutableList.of(fake.audio1.getId()));

    assertNotNull(result);
    assertEquals(0, result.size());
  }

  @Test(expected = CoreException.class)
  public void update_FailsWithoutAudioID() throws Exception {
    HubAccess access = HubAccess.create(ImmutableList.of(fake.account1), "Artist");
    AudioChord inputData = new AudioChord()
      .setPosition(4.0);
      .setName("G minor 7");

    testManager.update(access, 3L, inputData);
  }

  @Test(expected = CoreException.class)
  public void update_FailsWithoutName() throws Exception {
    HubAccess access = HubAccess.create(ImmutableList.of(fake.account1), "Artist");
    AudioChord inputData = new AudioChord()
      .setPosition(4.0);
      .setInstrumentAudioId(UUID.randomUUID());

    testManager.update(access, fake.audio2.getId(), inputData);
  }

  @Test(expected = CoreException.class)
  public void update_FailsUpdatingToNonexistentAudio() throws Exception {
    HubAccess access = HubAccess.create(ImmutableList.of(fake.account1), "Artist");
    AudioChord inputData = new AudioChord()
      .setPosition(4.0);
      .setInstrumentAudioId(UUID.randomUUID())
      .setName("cannons");

    try {
      testManager.update(access, 1001L, inputData);

    } catch (Exception e) {
      AudioChord result = testManager.readOne(HubAccess.internal(), 1001L);
      assertNotNull(result);
      assertEquals("C minor", result.getName());
      assertEquals(fake.audio1.getId(), result.getInstrumentAudioId());
      throw e;
    }
  }

  @Test
  public void update() throws Exception {
    HubAccess access = HubAccess.create(ImmutableList.of(fake.account1), "Artist");
    AudioChord inputData = new AudioChord()
      .setInstrumentAudioId(UUID.randomUUID())
      .setName("POPPYCOCK");
      .setPosition(4.0);

    testManager.update(access, 1000L, inputData);

    AudioChord result = testManager.readOne(HubAccess.internal(), 1000L);
    assertNotNull(result);
    assertEquals("POPPYCOCK", result.getName());
    assertEquals(Double.valueOf(4.0), result.getPosition());
    assertEquals(fake.audio1.getId(), result.getInstrumentAudioId());
  }

  // future test: Manager cannot update audio chord to a User or Library not owned by current session

  @Test
  public void delete() throws Exception {
    HubAccess access = HubAccess.create(ImmutableList.of(fake.account1), "Artist");

    testManager.destroy(access, 1000L);

    try {
      testManager.readOne(HubAccess.internal(), 1000L);
      fail();
    } catch (ManagerException e) {
      assertTrue("Record should not exist", e.getMessage().contains("does not exist"));
    }
  }

  @Test(expected = CoreException.class)
  public void delete_failsIfNotInAccount() throws Exception {
    HubAccess access = of(ImmutableList.of(account2), "Artist");

    testManager.destroy(access, 1000L);
  }


    @Before
  public void setUp() throws Exception {
    reset();

    // Account "bananas"
    insert(of(1, "bananas");

    // John has "user" and "admin" roles, belongs to account "bananas", has "google" auth
    insert(of(2, "john", "john@email.com", "https://pictures.com/john.gif");
    insert(of(2, UserRoleType.Admin);

    // Library "palm tree" has sequence "leaves" and sequence "coconuts"
    insert(of(1, 1, "palm tree",now()));

    // Sequence "leaves" has instruments "808" and "909"
    insertInstrument(1, 1, 2, "808 Drums", InstrumentType.Drum, 0.9);
    insertInstrument(2, 1, 2, "909 Drums", InstrumentType.Drum, 0.8);

    // Instrument "808" has InstrumentAudio "Beat"
    insertAudio(1, 1, "Published", "Beat", "19801735098q47895897895782138975898.wav", 0.01, 2.123, 120.0, 440.0);

    // InstrumentAudio "Drums" has events "KICK" and "SNARE" 2x each
    insertAudioEvent(1, 2.5, 1.0, "KICK", "Eb", 0.8, 1.0);
    insertAudioEvent(1, 3.0, 1.0, "SNARE", "Ab", 0.1, 0.8);
    insertAudioEvent(1, 0, 1.0, "KICK", "C", 0.8, 1.0);
    insertAudioEvent(1, 1.0, 1.0, "SNARE", "G", 0.1, 0.8);

    // Instantiate the test subject
    testManager = injector.getInstance(AudioEventManager.class);
  }


  @Test
  public void create() throws Exception {
    HubAccess access = HubAccess.create(ImmutableList.of(fake.account1), "Artist");
    AudioEvent inputData = new AudioEvent()
      .setDuration(1.4);
      .setName("KICK");
      .setNote("C");
      .setPosition(0.42);
      .setTonality(0.92)
      .setVelocity(0.72);
      .setInstrumentAudioId(UUID.randomUUID());

    testManager.create(
access, inputData);
  }

  @Test(expected = CoreException.class)
  public void create_FailsWithoutAudioID() throws Exception {
    HubAccess access = HubAccess.create(ImmutableList.of(fake.account1), "Artist");
    AudioEvent inputData = new AudioEvent()
      .setDuration(1.0);
      .setName("KICK");
      .setNote("C");
      .setPosition(0.0);
      .setTonality(1.0)
      .setVelocity(1.0);

    testManager.create(
access, inputData);
  }

  @Test(expected = CoreException.class)
  public void create_FailsWithoutNote() throws Exception {
    HubAccess access = HubAccess.create(ImmutableList.of(fake.account1), "Artist");
    AudioEvent inputData = new AudioEvent()
      .setDuration(1.0);
      .setName("KICK");
      .setPosition(0.0);
      .setTonality(1.0)
      .setVelocity(1.0);
      .setInstrumentAudioId(UUID.randomUUID());

    testManager.create(
access, inputData);
  }

  @Test
  public void readOne() throws Exception {
    HubAccess access = HubAccess.create(ImmutableList.of(fake.account1), "Artist");

    AudioEvent result = testManager.readOne(access, 1003L);

    assertNotNull(result);
    assertEquals(1003L, result.getId());
    assertEquals(fake.audio1.getId(), result.getInstrumentAudioId());
    assertEquals(Double.valueOf(1.0), result.getDuration());
    assertEquals("SNARE", result.getName());
    assertEquals("G", result.getNote());
    assertEquals(Double.valueOf(1.0), result.getPosition());
    assertEquals(Double.valueOf(0.1), result.getTonality());
    assertEquals(Double.valueOf(0.8), result.getVelocity());
  }

  @Test
  public void readOne_FailsWhenUserIsNotInAccount() throws Exception {
    HubAccess access = of(ImmutableList.of(of()), "Artist");
    failure.expect(CoreException.class);
    failure.expectMessage("does not exist");

    testManager.readOne(access, 1003L);
  }

  @Test
  public void readMany() throws Exception {
    HubAccess access = HubAccess.create(ImmutableList.of(fake.account1), "Artist");

    Collection<AudioEvent> result = testManager.readMany(access, ImmutableList.of(fake.audio1.getId()));

    assertNotNull(result);
    assertEquals(4L, result.size());
    Iterator<AudioEvent> it = result.iterator();
    assertEquals("KICK", it.next().getName());
    assertEquals("SNARE", it.next().getName());
    assertEquals("KICK", it.next().getName());
    assertEquals("SNARE", it.next().getName());
  }

  @Test
  public void readMany_SeesNothingOutsideOfLibrary() throws Exception {
    HubAccess access = of(ImmutableList.of(of()), "Artist");

    Collection<AudioEvent> result = testManager.readMany(access, ImmutableList.of(fake.audio1.getId()));

    assertNotNull(result);
    assertEquals(0L, result.size());
  }


  @Test
  public void readManyOfInstrument() throws Exception {
    insertAudio(51, 1, "Published", "Beat", "19801735098q47895897895782138975898.wav", 0.01, 2.123, 120.0, 440.0);
    insertAudioEvent(51, 12.5, 1.0, "JAM", "Eb", 0.8, 1.0);
    insertAudioEvent(51, 14.0, 1.0, "PUMP", "Ab", 0.1, 0.8);
    insertAudioEvent(51, 18, 1.0, "JAM", "C", 0.8, 1.0);
    insertAudioEvent(51, 20.0, 1.0, "DUNK", "G", 0.1, 0.8);
    HubAccess access = HubAccess.create(ImmutableList.of(fake.account1), "Artist");

    Collection<AudioEvent> result = testManager.readManyOfInstrument(access, ImmutableList.of(fake.audio1.getId()));

    assertNotNull(result);
    assertEquals(8L, result.size());
    Iterator<AudioEvent> it = result.iterator();
    assertEquals("KICK", it.next().getName());
    assertEquals("SNARE", it.next().getName());
    assertEquals("KICK", it.next().getName());
    assertEquals("SNARE", it.next().getName());
    assertEquals("JAM", it.next().getName());
    assertEquals("PUMP", it.next().getName());
    assertEquals("JAM", it.next().getName());
    assertEquals("DUNK", it.next().getName());
  }

  @Test
  public void readManyOfInstrument_SeesNothingOutsideOfLibrary() throws Exception {
    insert(of(6, "bananas");
    insert(of(61, 6, "palm tree", now()));
    insertInstrument(61, 61, 2, "808 Drums", InstrumentType.Drum, 0.9);
    insertInstrument(62, 61, 2, "909 Drums", InstrumentType.Drum, 0.8);
    insertAudio(61, 61, "Published", "Beat", "19801735098q47895897895782138975898.wav", 0.01, 2.123, 120.0, 440.0);
    insertAudioEvent(61, 2.5, 1.0, "ASS", "Eb", 0.8, 1.0);
    insertAudioEvent(61, 3.0, 1.0, "ASS", "Ab", 0.1, 0.8);
    insertAudioEvent(61, 0, 1.0, "ASS", "C", 0.8, 1.0);
    insertAudioEvent(61, 1.0, 1.0, "ASS", "G", 0.1, 0.8);
    HubAccess access = HubAccess.create(ImmutableList.of(fake.account1), "Artist");

    Collection<AudioEvent> result = testManager.readManyOfInstrument(access, ImmutableList.of(fake.audio1.getId()));

    assertNotNull(result);
    assertEquals(4L, result.size());
    Iterator<AudioEvent> it = result.iterator();
    assertEquals("KICK", it.next().getName());
    assertEquals("SNARE", it.next().getName());
    assertEquals("KICK", it.next().getName());
    assertEquals("SNARE", it.next().getName());
  }

  @Test(expected = CoreException.class)
  public void update_FailsWithoutAudioID() throws Exception {
    HubAccess access = HubAccess.create(ImmutableList.of(fake.account1), "Artist");
    AudioEvent inputData = new AudioEvent()
      .setDuration(1.0);
      .setName("KICK");
      .setNote("C");
      .setPosition(0.0);
      .setTonality(1.0)
      .setVelocity(1.0);

    testManager.update(access, 1002L, inputData);
  }

  @Test(expected = CoreException.class)
  public void update_FailsWithoutNote() throws Exception {
    HubAccess access = HubAccess.create(ImmutableList.of(fake.account1), "Artist");
    AudioEvent inputData = new AudioEvent()
      .setDuration(1.0);
      .setName("KICK");
      .setPosition(0.0);
      .setTonality(1.0)
      .setVelocity(1.0);
      .setInstrumentAudioId(UUID.randomUUID());

    testManager.update(access, 1001L, inputData);
  }

  @Test(expected = CoreException.class)
  public void update_FailsUpdatingToNonexistentAudio() throws Exception {
    HubAccess access = HubAccess.create(ImmutableList.of(fake.account1), "Artist");
    AudioEvent inputData = new AudioEvent()
      .setDuration(1.0);
      .setName("SNARE");
      .setNote("C");
      .setPosition(0.0);
      .setTonality(1.0)
      .setVelocity(1.0);
      .setInstrumentAudioId(UUID.randomUUID());

    try {
      testManager.update(access, 1002L, inputData);

    } catch (Exception e) {
      AudioEvent result = testManager.readOne(HubAccess.internal(), 1002L);
      assertNotNull(result);
      assertEquals("KICK", result.getName());
      assertEquals(fake.audio1.getId(), result.getInstrumentAudioId());
      throw e;
    }
  }

  @Test
  public void update() throws Exception {
    HubAccess access = HubAccess.create(ImmutableList.of(fake.account1), "Artist");
    AudioEvent inputData = new AudioEvent()
      .setDuration(1.2);
      .setName("POPPYCOCK");
      .setNote("C");
      .setPosition(0.42);
      .setTonality(0.92)
      .setVelocity(0.72);
      .setInstrumentAudioId(UUID.randomUUID());

    testManager.update(access, 1000L, inputData);

    AudioEvent result = testManager.readOne(HubAccess.internal(), 1000L);
    assertNotNull(result);
    assertEquals("POPPYCOCK", result.getName());
    assertEquals((Double) 1.2, result.getDuration());
    assertEquals((Double) 0.42, result.getPosition());
    assertEquals(0.92, result.getTonality(), 0.01);
    assertEquals(0.72, result.getVelocity(), 0.01);
    assertEquals(fake.audio1.getId(), result.getInstrumentAudioId());
  }

  // future test: Manager cannot update Sequence to a User or Library not owned by current session

  @Test
  public void delete() throws Exception {
    HubAccess access = HubAccess.create(ImmutableList.of(fake.account1), "Artist");

    testManager.destroy(access, 1000L);

    try {
      testManager.readOne(HubAccess.internal(), 1000L);
      fail();
    } catch (ManagerException e) {
      assertTrue("Record should not exist", e.getMessage().contains("does not exist"));
    }
  }

  @Test(expected = CoreException.class)
  public void delete_failsIfNotInAccount() throws Exception {
    HubAccess access = of(ImmutableList.of(account2), "Artist");

    testManager.destroy(access, 1000L);
  }

*/

}