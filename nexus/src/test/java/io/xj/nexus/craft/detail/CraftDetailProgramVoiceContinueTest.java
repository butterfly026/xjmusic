// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.nexus.craft.detail;

import com.google.common.collect.ImmutableList;
import com.google.common.collect.Streams;
import com.google.inject.AbstractModule;
import com.google.inject.Guice;
import com.google.inject.util.Modules;
import com.typesafe.config.Config;
import io.xj.api.Chain;
import io.xj.api.ChainState;
import io.xj.api.InstrumentType;
import io.xj.api.ProgramType;
import io.xj.api.Segment;
import io.xj.api.SegmentChoice;
import io.xj.api.SegmentChoiceArrangementPick;
import io.xj.api.SegmentChord;
import io.xj.api.SegmentChordVoicing;
import io.xj.api.SegmentMeme;
import io.xj.api.SegmentState;
import io.xj.api.SegmentType;
import io.xj.api.TemplateType;
import io.xj.lib.app.Environment;
import io.xj.lib.entity.EntityFactory;
import io.xj.lib.entity.common.Topology;
import io.xj.nexus.NexusException;
import io.xj.nexus.NexusIntegrationTestingFixtures;
import io.xj.nexus.NexusTestConfiguration;
import io.xj.nexus.craft.CraftFactory;
import io.xj.nexus.dao.Segments;
import io.xj.nexus.fabricator.Fabricator;
import io.xj.nexus.fabricator.FabricatorFactory;
import io.xj.nexus.hub_client.client.HubClient;
import io.xj.nexus.hub_client.client.HubClientAccess;
import io.xj.nexus.hub_client.client.HubContent;
import io.xj.nexus.persistence.NexusEntityStore;
import io.xj.nexus.work.NexusWorkModule;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.Mock;
import org.mockito.junit.MockitoJUnitRunner;

import java.time.Instant;
import java.util.Collection;
import java.util.UUID;
import java.util.stream.Collectors;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;

@RunWith(MockitoJUnitRunner.class)
public class CraftDetailProgramVoiceContinueTest {
  @Mock
  public HubClient hubClient;
  private Chain chain1;
  private CraftFactory craftFactory;
  private FabricatorFactory fabricatorFactory;
  private HubContent sourceMaterial;
  private NexusEntityStore store;
  private NexusIntegrationTestingFixtures fake;
  private Segment segment4;

  @Before
  public void setUp() throws Exception {
    Config config = NexusTestConfiguration.getDefault();
    Environment env = Environment.getDefault();
    var injector = Guice.createInjector(Modules.override(new NexusWorkModule())
      .with(new AbstractModule() {
        @Override
        public void configure() {
          bind(Config.class).toInstance(config);
          bind(Environment.class).toInstance(env);
          bind(HubClient.class).toInstance(hubClient);
        }
      }));
    fabricatorFactory = injector.getInstance(FabricatorFactory.class);
    craftFactory = injector.getInstance(CraftFactory.class);
    var entityFactory = injector.getInstance(EntityFactory.class);
    Topology.buildHubApiTopology(entityFactory);
    Topology.buildNexusApiTopology(entityFactory);

    // Manipulate the underlying entity store; reset before each test
    store = injector.getInstance(NexusEntityStore.class);
    store.deleteAll();

    // Mock request via HubClient returns fake generated library of hub content
    fake = new NexusIntegrationTestingFixtures();
    sourceMaterial = new HubContent(Streams.concat(
      fake.setupFixtureB1().stream(),
      fake.setupFixtureB2().stream(),
      fake.setupFixtureB4_DetailBass().stream()
    ).collect(Collectors.toList()));

    // Chain "Test Print #1" has 5 total segments
    chain1 = store.put(NexusIntegrationTestingFixtures.buildChain(fake.account1, "Test Print #1", TemplateType.PRODUCTION, ChainState.FABRICATE, fake.template1, Instant.parse("2014-08-12T12:17:02.527142Z"), null, null));
    store.put(new Segment()
      .id(UUID.randomUUID())
      .chainId(chain1.getId())
      .type(SegmentType.INITIAL)
      .state(SegmentState.DUBBED)
      .beginAt("2017-02-14T12:01:00.000001Z")
      .endAt("2017-02-14T12:01:32.000001Z")
      .offset(0L)
      .delta(0)
      .key("D major")
      .total(64)
      .density(0.73)
      .tempo(120.0)
      .storageKey("chains-1-segments-9f7s89d8a7892")
      .outputEncoder("wav"));
    store.put(new Segment()
      .id(UUID.randomUUID())
      .chainId(chain1.getId())
        .type(SegmentType.CONTINUE)
      .state(SegmentState.DUBBING)
      .beginAt("2017-02-14T12:01:32.000001Z")
      .endAt("2017-02-14T12:02:04.000001Z")
      .offset(1L)
      .delta(1)
      .key("Db minor")
      .total(64)
      .density(0.85)
      .tempo(120.0)
      .storageKey("chains-1-segments-9f7s89d8a7892.wav"));
  }

  @After
  public void tearDown() {

  }

  @Test
  public void craftDetailVoiceContinue() throws Exception {
    insertSegments3and4(false);
    Fabricator fabricator = fabricatorFactory.fabricate(HubClientAccess.internal(), sourceMaterial, segment4);

    craftFactory.detail(fabricator).doWork();

    store.getSegment(segment4.getId()).orElseThrow();
    assertFalse(fabricator.getChoices().isEmpty());
    // test vector for [#154014731] persist Audio pick in memory
    int pickedBloop = 0;
    Collection<SegmentChoiceArrangementPick> picks = fabricator.getPicks();

    for (SegmentChoiceArrangementPick pick : picks) {
      if (pick.getInstrumentAudioId().equals(fake.instrument9_audio8.getId()))
        pickedBloop++;
    }
    assertEquals(16, pickedBloop);
  }

  @Test
  public void craftDetailVoiceContinue_okIfNoDetailChoice() throws Exception {
    insertSegments3and4(true);
    Fabricator fabricator = fabricatorFactory.fabricate(HubClientAccess.internal(), sourceMaterial, segment4);

    craftFactory.detail(fabricator).doWork();
  }

  /**
   Insert fixture segments 3 and 4, including the detail choice for segment 3 only if specified

   @param excludeDetailChoiceForSegment3 if desired for the purpose of this test
   */
  private void insertSegments3and4(boolean excludeDetailChoiceForSegment3) throws NexusException {
    // segment just crafted
    // Testing entities for reference
    Segment segment3 = store.put(new Segment()
      .id(UUID.randomUUID())
      .chainId(chain1.getId())
      .type(SegmentType.CONTINUE)
      .state(SegmentState.CRAFTED)
      .beginAt("2017-02-14T12:02:04.000001Z")
      .endAt("2017-02-14T12:02:36.000001Z")
      .offset(2L)
      .delta(2)
      .key("F Major")
      .total(64)
      .density(0.30)
      .tempo(120.0)
      .storageKey("chains-1-segments-9f7s89d8a7892.wav"));
    store.put(new SegmentChoice()
      .id(UUID.randomUUID())
      .segmentId(segment3.getId())
      .id(UUID.randomUUID())
      .programId(fake.program4.getId())
      .programId(fake.program4_sequence0_binding0.getProgramId())
      .deltaIn(Segments.DELTA_UNLIMITED)
      .deltaOut(Segments.DELTA_UNLIMITED)
      .programSequenceBindingId(fake.program4_sequence0_binding0.getId())
      .programType(ProgramType.MACRO));
    store.put(new SegmentChoice()
      .id(UUID.randomUUID())
      .segmentId(segment3.getId())
      .id(UUID.randomUUID())
      .programId(fake.program5.getId())
      .programId(fake.program5_sequence0_binding0.getProgramId())
      .deltaIn(Segments.DELTA_UNLIMITED)
      .deltaOut(Segments.DELTA_UNLIMITED)
      .programSequenceBindingId(fake.program5_sequence0_binding0.getId())
      .programType(ProgramType.MAIN));
    if (!excludeDetailChoiceForSegment3)
      store.put(new SegmentChoice()
        .id(UUID.randomUUID())
        .segmentId(segment3.getId())
        .id(UUID.randomUUID())
        .deltaIn(Segments.DELTA_UNLIMITED)
        .deltaOut(Segments.DELTA_UNLIMITED)
        .programId(fake.program10.getId())
        .programType(ProgramType.DETAIL));

    // segment crafting
    segment4 = store.put(new Segment()
      .id(UUID.randomUUID())
      .chainId(chain1.getId())
      .type(SegmentType.CONTINUE)
      .state(SegmentState.CRAFTING)
      .beginAt("2017-02-14T12:03:08.000001Z")
      .endAt("2017-02-14T12:03:15.836735Z")
      .offset(3L)
      .delta(3)
      .key("D Major")
      .total(16)
      .density(0.45)
      .tempo(120.0)
      .storageKey("chains-1-segments-9f7s89d8a7892.wav"));
    store.put(new SegmentChoice()
      .id(UUID.randomUUID())
      .segmentId(segment4.getId())
      .id(UUID.randomUUID())
      .deltaIn(Segments.DELTA_UNLIMITED)
      .deltaOut(Segments.DELTA_UNLIMITED)
      .programId(fake.program4.getId())
      .programId(fake.program4_sequence0_binding0.getProgramId())
      .programSequenceBindingId(fake.program4_sequence0_binding0.getId())
      .programType(ProgramType.MACRO));
    store.put(new SegmentChoice()
      .id(UUID.randomUUID())
      .segmentId(segment4.getId())
      .id(UUID.randomUUID())
      .deltaIn(Segments.DELTA_UNLIMITED)
      .deltaOut(Segments.DELTA_UNLIMITED)
      .programId(fake.program5.getId())
      .programId(fake.program5_sequence1_binding0.getProgramId())
      .programSequenceBindingId(fake.program5_sequence1_binding0.getId())
      .programType(ProgramType.MAIN));
    for (String memeName : ImmutableList.of("Cozy", "Classic", "Outlook", "Rosy"))
      store.put(new SegmentMeme()
        .id(UUID.randomUUID())
        .segmentId(segment4.getId()).name(memeName));
    SegmentChord chord0 = store.put(new SegmentChord()
      .id(UUID.randomUUID())
      .segmentId(segment4.getId())
      .position(0.0)
      .name("A minor"));
    store.put(new SegmentChordVoicing()
      .id(UUID.randomUUID())
      .segmentId(segment4.getId())
      .segmentChordId(chord0.getId())
      .type(InstrumentType.BASS)
      .notes("A2, C3, E3"));
    SegmentChord chord1 = store.put(new SegmentChord()
      .id(UUID.randomUUID())
      .segmentId(segment4.getId())
      .position(8.0)
      .name("D Major"));
    store.put(new SegmentChordVoicing()
      .id(UUID.randomUUID())
      .segmentId(segment4.getId())
      .segmentChordId(chord1.getId())
      .type(InstrumentType.BASS)
      .notes("D2, F#2, A2"));
  }


}