// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.nexus.craft.detail;

import com.google.common.collect.ImmutableList;
import com.google.common.collect.ImmutableSet;
import com.google.common.collect.Streams;
import com.google.inject.AbstractModule;
import com.google.inject.util.Modules;
import com.typesafe.config.Config;
import io.xj.api.Chain;
import io.xj.api.ChainBinding;
import io.xj.api.ChainBindingType;
import io.xj.api.ChainState;
import io.xj.api.ChainType;
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
import io.xj.lib.app.AppConfiguration;
import io.xj.lib.app.Environment;
import io.xj.lib.entity.EntityFactory;
import io.xj.lib.entity.common.Topology;
import io.xj.nexus.NexusException;
import io.xj.nexus.NexusIntegrationTestingFixtures;
import io.xj.nexus.craft.CraftFactory;
import io.xj.nexus.dao.Segments;
import io.xj.nexus.fabricator.Fabricator;
import io.xj.nexus.fabricator.FabricatorFactory;
import io.xj.nexus.hub_client.client.HubClient;
import io.xj.nexus.hub_client.client.HubClientAccess;
import io.xj.nexus.hub_client.client.HubContent;
import io.xj.nexus.persistence.NexusEntityStore;
import io.xj.nexus.testing.NexusTestConfiguration;
import io.xj.nexus.work.NexusWorkModule;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.Mock;
import org.mockito.runners.MockitoJUnitRunner;

import java.time.Instant;
import java.util.Collection;
import java.util.UUID;
import java.util.stream.Collectors;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

@RunWith(MockitoJUnitRunner.class)
public class CraftDetailProgramVoiceNextMainTest {
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
    var injector = AppConfiguration.inject(config, env,
      ImmutableSet.of(Modules.override(new NexusWorkModule())
        .with(new AbstractModule() {
          @Override
          public void configure() {
            bind(HubClient.class).toInstance(hubClient);
          }
        })));
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
    chain1 = store.put(NexusIntegrationTestingFixtures.makeChain(fake.account1, "Test Print #1", ChainType.PRODUCTION, ChainState.FABRICATE, Instant.parse("2014-08-12T12:17:02.527142Z"), null, null));
    store.put(new ChainBinding()
      .id(UUID.randomUUID())
      .chainId(chain1.getId())
      .targetId(fake.library2.getId())
      .type(ChainBindingType.LIBRARY)
      );
    store.put(new Segment()
      .id(UUID.randomUUID())
      .chainId(chain1.getId())
      .offset(0L)
      .state(SegmentState.DUBBED)
      .beginAt("2017-02-14T12:01:00.000001Z")
      .endAt("2017-02-14T12:01:32.000001Z")
      .key("D major")
      .total(64)
      .density(0.73)
      .tempo(120.0)
      .storageKey("chains-1-segments-9f7s89d8a7892")
      .outputEncoder("wav")
      );
    store.put(new Segment()
      .id(UUID.randomUUID())
      .chainId(chain1.getId())
      .offset(1L)
      .state(SegmentState.DUBBING)
      .beginAt("2017-02-14T12:01:32.000001Z")
      .endAt("2017-02-14T12:02:04.000001Z")
      .key("Db minor")
      .total(64)
      .density(0.85)
      .tempo(120.0)
      .storageKey("chains-1-segments-9f7s89d8a7892.wav")
      );
  }

  @Test
  public void craftDetailVoiceNextMain() throws Exception {
    insertSegments3and4(true);
    Fabricator fabricator = fabricatorFactory.fabricate(HubClientAccess.internal(), sourceMaterial, segment4);

    craftFactory.detail(fabricator).doWork();

    assertNotNull(fabricator.getArrangements(fabricator.getCurrentDetailChoices()));

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
  public void craftDetailVoiceNextMain_okIfNoDetailChoice() throws Exception {
    insertSegments3and4(false);
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
      .offset(2L)
      .state(SegmentState.CRAFTED)
      .beginAt("2017-02-14T12:02:04.000001Z")
      .endAt("2017-02-14T12:02:36.000001Z")
      .key("F Major")
      .total(64)
      .density(0.30)
      .tempo(120.0)
      .storageKey("chains-1-segments-9f7s89d8a7892.wav")
      );
    store.put(new SegmentChoice()
      .id(UUID.randomUUID())
      .segmentId(segment3.getId())
      .deltaIn(Segments.DELTA_UNLIMITED)
      .deltaOut(Segments.DELTA_UNLIMITED)
      .programId(fake.program4.getId())
      .programId(fake.program4_sequence0_binding0.getProgramId())
      .programSequenceBindingId(fake.program4_sequence0_binding0.getId())
      .programType(ProgramType.MACRO)
      );
    store.put(new SegmentChoice()
      .id(UUID.randomUUID())
      .segmentId(segment3.getId())
      .deltaIn(Segments.DELTA_UNLIMITED)
      .deltaOut(Segments.DELTA_UNLIMITED)
      .programId(fake.program15.getId())
      .programId(fake.program15_sequence1_binding0.getProgramId())
      .programSequenceBindingId(fake.program15_sequence1_binding0.getId())
      .programType(ProgramType.MAIN)
      );
    if (!excludeDetailChoiceForSegment3)
      store.put(new SegmentChoice()
        .id(UUID.randomUUID())
        .segmentId(segment3.getId())
        .deltaIn(Segments.DELTA_UNLIMITED)
        .deltaOut(Segments.DELTA_UNLIMITED)
        .programId(fake.program10.getId())
        .programType(ProgramType.DETAIL)
        );

    // segment crafting
    segment4 = store.put(new Segment()
      .id(UUID.randomUUID())
      .type(SegmentType.NEXTMAIN)
      .chainId(chain1.getId())
      .offset(3L)
      .state(SegmentState.CRAFTING)
      .beginAt("2017-02-14T12:03:08.000001Z")
      .endAt("2017-02-14T12:03:15.836735Z")
      .key("G minor")
      .total(16)
      .density(0.45)
      .tempo(120.0)
      .storageKey("chains-1-segments-9f7s89d8a7892.wav")
      );
    store.put(new SegmentChoice()
      .id(UUID.randomUUID())
      .segmentId(segment4.getId())
      .deltaIn(Segments.DELTA_UNLIMITED)
      .deltaOut(Segments.DELTA_UNLIMITED)
      .programId(fake.program4.getId())
      .programId(fake.program4_sequence1_binding0.getProgramId())
      .programSequenceBindingId(fake.program4_sequence1_binding0.getId())
      .programType(ProgramType.MACRO)
      );
    store.put(new SegmentChoice()
      .id(UUID.randomUUID())
      .segmentId(segment4.getId())
      .deltaIn(Segments.DELTA_UNLIMITED)
      .deltaOut(Segments.DELTA_UNLIMITED)
      .programId(fake.program15.getId())
      .programId(fake.program15_sequence0_binding0.getProgramId())
      .programSequenceBindingId(fake.program15_sequence0_binding0.getId())
      .programType(ProgramType.MAIN)
      );
    for (String memeName : ImmutableList.of("Regret", "Sky", "Hindsight", "Tropical"))
      store.put(new SegmentMeme()
        .id(UUID.randomUUID())
        .segmentId(segment4.getId()).name(memeName)
        );

    SegmentChord chord0 = store.put(new SegmentChord()
      .id(UUID.randomUUID())
      .segmentId(segment4.getId())
      .position(0.0)
      .name("G minor")
      );
    store.put(new SegmentChordVoicing()
      .id(UUID.randomUUID())
      .segmentId(segment4.getId())
      .segmentChordId(chord0.getId())
      .type(InstrumentType.BASS)
      .notes("G2, Bb2, D3")
      );
    SegmentChord chord1 = store.put(new SegmentChord()
      .id(UUID.randomUUID())
      .segmentId(segment4.getId())
      .position(8.0)
      .name("Ab minor")
      );
    store.put(new SegmentChordVoicing()
      .id(UUID.randomUUID())
      .segmentId(segment4.getId())
      .segmentChordId(chord1.getId())
      .type(InstrumentType.BASS)
      .notes("Ab2, C3, Eb3")
      );
  }
}
