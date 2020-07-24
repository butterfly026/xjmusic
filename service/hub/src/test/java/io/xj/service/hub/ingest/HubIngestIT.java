// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.service.hub.ingest;

import com.google.common.collect.ImmutableSet;
import com.google.common.collect.Maps;
import com.google.inject.Injector;
import com.typesafe.config.Config;
import io.xj.lib.app.AppConfiguration;
import io.xj.lib.entity.Entity;
import io.xj.lib.filestore.FileStoreModule;
import io.xj.lib.jsonapi.JsonApiModule;
import io.xj.lib.mixer.MixerModule;
import io.xj.lib.util.Text;
import io.xj.service.hub.IntegrationTestingFixtures;
import io.xj.service.hub.access.HubAccess;
import io.xj.service.hub.access.HubAccessControlModule;
import io.xj.service.hub.dao.DAOModule;
import io.xj.service.hub.entity.*;
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

import java.util.Collection;
import java.util.Map;
import java.util.UUID;

import static org.junit.Assert.assertEquals;

@RunWith(MockitoJUnitRunner.class)
public class HubIngestIT {

  @Rule
  public ExpectedException failure = ExpectedException.none();
  private HubIngestFactory ingestFactory;
  private HubIntegrationTestProvider test;
  private IntegrationTestingFixtures fake;

  private static Map<String, Integer> classTally(Collection<Entity> allEntities) {
    Map<String, Integer> out = Maps.newHashMap();
    allEntities.forEach(entity -> {
      String name = Text.getSimpleName(entity);
      out.put(name, out.containsKey(name) ? out.get(name) + 1 : 1);
    });
    return out;
  }

  @Before
  public void setUp() throws Exception {
    Config config = HubTestConfiguration.getDefault();
    Injector injector = AppConfiguration.inject(config, ImmutableSet.of(new HubAccessControlModule(), new DAOModule(), new HubIngestModule(), new HubPersistenceModule(), new MixerModule(), new JsonApiModule(), new FileStoreModule(), new HubIntegrationTestModule()));
    test = injector.getInstance(HubIntegrationTestProvider.class);
    fake = new IntegrationTestingFixtures(test);

    test.reset();
    fake.insertFixtureA();
    ingestFactory = injector.getInstance(HubIngestFactory.class);
  }

  @After
  public void tearDown() {
    test.shutdown();
  }

  @Test
  public void ingest() throws Exception {
    HubIngest result = ingestFactory.ingest(HubAccess.internal(), ImmutableSet.of(fake.library10000001.getId()), ImmutableSet.of(), ImmutableSet.of());

    assertEquals(2, result.getAllInstruments().size());
  }

  @Test
  public void getAllPrograms() throws Exception {
    HubIngest ingest = ingestFactory.ingest(HubAccess.internal(), ImmutableSet.of(fake.library10000001.getId()), ImmutableSet.of(), ImmutableSet.of());

    assertEquals(3, ingest.getAllPrograms().size());
  }

  @Test
  public void getProgramsOfType() throws Exception {
    test.insert(Program.create(fake.user101, fake.library10000001, ProgramType.Rhythm, ProgramState.Published, "cups", "B", 120.4, 0.6));
    test.insert(Program.create(fake.user101, fake.library10000001, ProgramType.Main, ProgramState.Published, "plates", "Bb", 120.4, 0.6));
    test.insert(Program.create(fake.user101, fake.library10000001, ProgramType.Detail, ProgramState.Published, "bowls", "A", 120.4, 0.6));
    HubIngest ingest = ingestFactory.ingest(HubAccess.internal(), ImmutableSet.of(fake.library10000001.getId()), ImmutableSet.of(), ImmutableSet.of());

    assertEquals(3, ingest.getProgramsOfType(ProgramType.Main).size());
    assertEquals(2, ingest.getProgramsOfType(ProgramType.Rhythm).size());
    assertEquals(1, ingest.getProgramsOfType(ProgramType.Detail).size());
  }

  @Test
  public void access() throws Exception {
    HubAccess hubAccess = HubAccess.internal();
    HubIngest ingest = ingestFactory.ingest(hubAccess, ImmutableSet.of(fake.library10000001.getId()), ImmutableSet.of(), ImmutableSet.of());

    assertEquals(hubAccess, ingest.getHubAccess());
  }

  @Test
  public void getProgram() throws Exception {
    HubIngest ingest = ingestFactory.ingest(HubAccess.internal(), ImmutableSet.of(fake.library10000001.getId()), ImmutableSet.of(), ImmutableSet.of());

    assertEquals("leaves", ingest.getProgram(fake.program701.getId()).getName());
    assertEquals("coconuts", ingest.getProgram(fake.program702.getId()).getName());
    assertEquals("bananas", ingest.getProgram(fake.program703.getId()).getName());
  }

  @Test
  public void getProgram_exceptionOnMissing() throws Exception {
    failure.expect(HubIngestException.class);
    failure.expectMessage("No such Program");
    HubIngest ingest = ingestFactory.ingest(HubAccess.internal(), ImmutableSet.of(fake.library10000001.getId()), ImmutableSet.of(), ImmutableSet.of());

    ingest.getProgram(UUID.randomUUID());
  }

  @Test
  public void getAllInstruments() throws Exception {
    HubIngest ingest = ingestFactory.ingest(HubAccess.internal(), ImmutableSet.of(fake.library10000001.getId()), ImmutableSet.of(), ImmutableSet.of());

    assertEquals(2, ingest.getAllInstruments().size());
  }

  @Test
  public void getInstrumentsOfType() throws Exception {
    test.insert(Instrument.create(fake.user101, fake.library10000001, InstrumentType.Harmonic, InstrumentState.Published, "Dreamy"));
    HubIngest ingest = ingestFactory.ingest(HubAccess.internal(), ImmutableSet.of(fake.library10000001.getId()), ImmutableSet.of(), ImmutableSet.of());

    assertEquals(2, ingest.getInstrumentsOfType(InstrumentType.Percussive).size());
    assertEquals(1, ingest.getInstrumentsOfType(InstrumentType.Harmonic).size());
  }

  @Test
  public void getInstrument() throws Exception {
    HubIngest ingest = ingestFactory.ingest(HubAccess.internal(), ImmutableSet.of(fake.library10000001.getId()), ImmutableSet.of(), ImmutableSet.of());

    assertEquals("808 Drums", ingest.getInstrument(fake.instrument201.getId()).getName());
  }

  @Test
  public void getAllEntities() throws Exception {
    HubIngest ingest = ingestFactory.ingest(HubAccess.internal(), ImmutableSet.of(fake.library10000001.getId()), ImmutableSet.of(), ImmutableSet.of());

    Collection<Entity> result = ingest.getAllEntities();

    assertEquals(53, result.size());
    Map<String, Integer> classes = classTally(result);
    assertEquals(Integer.valueOf(3), classes.get("Program"));
    assertEquals(Integer.valueOf(2), classes.get("InstrumentAudio"));
    assertEquals(Integer.valueOf(6), classes.get("InstrumentAudioChord"));
    assertEquals(Integer.valueOf(4), classes.get("InstrumentAudioEvent"));
    assertEquals(Integer.valueOf(3), classes.get("InstrumentMeme"));
    assertEquals(Integer.valueOf(4), classes.get("ProgramSequencePatternEvent"));
    assertEquals(Integer.valueOf(3), classes.get("ProgramMeme"));
    assertEquals(Integer.valueOf(1), classes.get("ProgramSequencePattern"));
    assertEquals(Integer.valueOf(2), classes.get("ProgramSequence"));
    assertEquals(Integer.valueOf(6), classes.get("ProgramSequenceBinding"));
    assertEquals(Integer.valueOf(8), classes.get("ProgramSequenceBindingMeme"));
    assertEquals(Integer.valueOf(6), classes.get("ProgramSequenceChord"));
    assertEquals(Integer.valueOf(2), classes.get("ProgramVoiceTrack"));
    assertEquals(Integer.valueOf(1), classes.get("ProgramVoice"));
    assertEquals(Integer.valueOf(2), classes.get("Instrument"));
  }

  @Test
  public void toStringOutput() throws Exception {
    HubIngest ingest = ingestFactory.ingest(HubAccess.internal(), ImmutableSet.of(fake.library10000001.getId()), ImmutableSet.of(), ImmutableSet.of());

    assertEquals("2 Instrument, 2 InstrumentAudio, 6 InstrumentAudioChord, 4 InstrumentAudioEvent, 3 InstrumentMeme, 3 Program, 3 ProgramMeme, 2 ProgramSequence, 6 ProgramSequenceBinding, 8 ProgramSequenceBindingMeme, 6 ProgramSequenceChord, 1 ProgramSequencePattern, 4 ProgramSequencePatternEvent, 1 ProgramVoice, 2 ProgramVoiceTrack", ingest.toString());
  }

}