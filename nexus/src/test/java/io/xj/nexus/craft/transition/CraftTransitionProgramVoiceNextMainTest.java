// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.nexus.craft.transition;

import com.google.common.collect.ImmutableList;
import com.google.common.collect.Lists;
import com.google.common.collect.Streams;
import com.google.inject.AbstractModule;
import com.google.inject.Guice;
import com.google.inject.util.Modules;
import io.xj.api.*;
import io.xj.hub.HubTopology;
import io.xj.hub.enums.InstrumentState;
import io.xj.hub.enums.InstrumentType;
import io.xj.hub.tables.pojos.Instrument;
import io.xj.hub.tables.pojos.InstrumentAudio;
import io.xj.lib.app.Environment;
import io.xj.lib.entity.Entities;
import io.xj.lib.entity.EntityFactory;
import io.xj.nexus.NexusException;
import io.xj.nexus.NexusIntegrationTestingFixtures;
import io.xj.nexus.NexusTopology;
import io.xj.nexus.craft.CraftFactory;
import io.xj.nexus.fabricator.Fabricator;
import io.xj.nexus.fabricator.FabricatorFactory;
import io.xj.nexus.hub_client.client.HubClient;
import io.xj.nexus.hub_client.client.HubContent;
import io.xj.nexus.persistence.NexusEntityStore;
import io.xj.nexus.persistence.Segments;
import io.xj.nexus.work.NexusWorkModule;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.Mock;
import org.mockito.junit.MockitoJUnitRunner;

import java.time.Instant;
import java.util.Collection;
import java.util.stream.Collectors;

import static io.xj.hub.IntegrationTestingFixtures.*;
import static io.xj.nexus.NexusIntegrationTestingFixtures.*;

@RunWith(MockitoJUnitRunner.class)
public class CraftTransitionProgramVoiceNextMainTest {
  @Mock
  public HubClient hubClient;
  private CraftFactory craftFactory;
  private FabricatorFactory fabricatorFactory;
  private NexusIntegrationTestingFixtures fake;
  private Chain chain1;
  private Segment segment4;
  private NexusEntityStore store;
  private InstrumentAudio audioKick;
  private InstrumentAudio audioSnare;
  private HubContent sourceMaterial;

  @Before
  public void setUp() throws Exception {
    Environment env = Environment.getDefault();
    var injector = Guice.createInjector(Modules.override(new NexusWorkModule())
      .with(new AbstractModule() {
        @Override
        protected void configure() {
          bind(Environment.class).toInstance(env);
        }
      }));
    fabricatorFactory = injector.getInstance(FabricatorFactory.class);
    craftFactory = injector.getInstance(CraftFactory.class);
    var entityFactory = injector.getInstance(EntityFactory.class);
    HubTopology.buildHubApiTopology(entityFactory);
    NexusTopology.buildNexusApiTopology(entityFactory);

    // Manipulate the underlying entity store; reset before each test
    store = injector.getInstance(NexusEntityStore.class);
    store.deleteAll();

    // Mock request via HubClient returns fake generated library of hub content
    fake = new NexusIntegrationTestingFixtures();
    sourceMaterial = new HubContent(Streams.concat(
      fake.setupFixtureB1().stream(),
      fake.setupFixtureB2().stream(),
      customFixtures().stream()
    ).collect(Collectors.toList()));

    // Chain "Test Print #1" has 5 total segments
    chain1 = store.put(buildChain(
      fake.account1,
      fake.template1,
      "Test Print #1",
      ChainType.PRODUCTION,
      ChainState.FABRICATE,
      Instant.parse("2014-08-12T12:17:02.527142Z")));
    store.put(buildSegment(
      chain1,
      0,
      SegmentState.DUBBED,
      Instant.parse("2017-02-14T12:01:00.000001Z"),
      Instant.parse("2017-02-14T12:01:32.000001Z"),
      "D major",
      64,
      0.73,
      120.0,
      "chains-1-segments-9f7s89d8a7892",
      "wav"));
    store.put(buildSegment(
      chain1,
      SegmentType.CONTINUE,
      1,
      1,
      SegmentState.DUBBING,
      Instant.parse("2017-02-14T12:01:32.000001Z"),
      Instant.parse("2017-02-14T12:02:04.000001Z"),
      "Db minor",
      64,
      0.85,
      120.0,
      "chains-1-segments-9f7s89d8a7892.wav"));
  }

  /**
   Some custom fixtures for testing

   @return list of all entities
   */
  private Collection<Object> customFixtures() {
    Collection<Object> entities = Lists.newArrayList();

    // Instrument "808"
    Instrument instrument1 = Entities.add(entities,
      buildInstrument(fake.library2, InstrumentType.Transition, InstrumentState.Published, "Bongo Loop"));
    Entities.add(entities, buildInstrumentMeme(instrument1, "heavy"));
    //
    audioKick = Entities.add(entities, buildInstrumentAudio(
      instrument1,
      "Kick",
      "19801735098q47895897895782138975898.wav",
      0.01f,
      2.123f,
      120.0f,
      0.6f,
      "KICK",
      "Eb",
      1.0f));
    //
    audioSnare = Entities.add(entities, buildInstrumentAudio(
      instrument1,
      "Snare",
      "a1g9f8u0k1v7f3e59o7j5e8s98.wav",
      0.01f,
      1.5f,
      120.0f,
      0.6f,
      "SNARE",
      "Ab",
      1.0f));

    return entities;
  }

  @Test
  public void craftTransitionVoiceNextMain() throws Exception {
    insertSegments3and4();
    Fabricator fabricator = fabricatorFactory.fabricate(sourceMaterial, segment4);

    craftFactory.transition(fabricator).doWork();

//    // test vector for [#154014731] persist Audio pick in memory
//    int pickedKick = 0;
//    int pickedSnare = 0;
//    Collection<SegmentChoiceArrangementPick> picks = fabricator.getPicks();
//    for (SegmentChoiceArrangementPick pick : picks) {
//      if (pick.getInstrumentAudioId().equals(audioKick.getId()))
//        pickedKick++;
//      if (pick.getInstrumentAudioId().equals(audioSnare.getId()))
//        pickedSnare++;
//    }
//    assertEquals(8, pickedKick);
//    assertEquals(8, pickedSnare);
  }

  /**
   Insert fixture segments 3 and 4, including the transition choice for segment 3 only if specified
   */
  private void insertSegments3and4() throws NexusException {
    // segment just crafted
    // Testing entities for reference
    Segment segment3 = store.put(buildSegment(
      chain1,
      SegmentType.CONTINUE,
      2,
      2,
      SegmentState.CRAFTED,
      Instant.parse("2017-02-14T12:02:04.000001Z"),
      Instant.parse("2017-02-14T12:02:36.000001Z"),
      "F Major",
      64,
      0.30,
      120.0,
      "chains-1-segments-9f7s89d8a7892",
      "wav"));
    store.put(buildSegmentChoice(
      segment3,
      Segments.DELTA_UNLIMITED,
      Segments.DELTA_UNLIMITED,
      fake.program4,
      fake.program4_sequence0_binding0));
    store.put(buildSegmentChoice(
      segment3,
      Segments.DELTA_UNLIMITED,
      Segments.DELTA_UNLIMITED,
      fake.program15,
      fake.program15_sequence1_binding0));

    // segment crafting
    segment4 = store.put(buildSegment(
      chain1,
      SegmentType.NEXTMAIN,
      0,
      3,
      SegmentState.CRAFTING,
      Instant.parse("2017-02-14T12:03:08.000001Z"),
      Instant.parse("2017-02-14T12:03:15.836735Z"),
      "G minor",
      16,
      0.45,
      120.0,
      "chains-1-segments-9f7s89d8a7892.wav"));
    store.put(buildSegmentChoice(
      segment4,
      Segments.DELTA_UNLIMITED,
      Segments.DELTA_UNLIMITED,
      fake.program4,
      fake.program4_sequence1_binding0));
    store.put(buildSegmentChoice(
      segment4,
      Segments.DELTA_UNLIMITED,
      Segments.DELTA_UNLIMITED,
      fake.program15,
      fake.program15_sequence0_binding0));
    for (String memeName : ImmutableList.of("Regret", "Sky", "Hindsight", "Tropical"))
      store.put(buildSegmentMeme(segment4, memeName));

    store.put(buildSegmentChord(segment4, 0.0, "G minor"));
    store.put(buildSegmentChord(segment4, 8.0, "Ab minor"));
  }

}