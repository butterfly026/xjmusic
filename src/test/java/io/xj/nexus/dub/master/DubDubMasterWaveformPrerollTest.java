// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.nexus.dub.master;

import com.google.common.collect.ImmutableSet;
import com.google.common.collect.Streams;
import com.google.inject.AbstractModule;
import com.google.inject.Injector;
import com.google.inject.util.Modules;
import com.typesafe.config.Config;
import io.xj.Chain;
import io.xj.ChainBinding;
import io.xj.Program;
import io.xj.Segment;
import io.xj.SegmentChoice;
import io.xj.SegmentChoiceArrangement;
import io.xj.lib.app.AppConfiguration;
import io.xj.lib.entity.EntityFactory;
import io.xj.lib.entity.common.Topology;
import io.xj.nexus.NexusIntegrationTestingFixtures;
import io.xj.nexus.dub.DubFactory;
import io.xj.nexus.fabricator.Fabricator;
import io.xj.nexus.fabricator.FabricatorFactory;
import io.xj.nexus.work.NexusWorkModule;
import io.xj.nexus.hub_client.client.HubClient;
import io.xj.nexus.hub_client.client.HubClientAccess;
import io.xj.nexus.hub_client.client.HubContent;
import io.xj.nexus.persistence.NexusEntityStore;
import io.xj.nexus.testing.NexusTestConfiguration;
import org.junit.After;
import org.junit.Before;
import org.junit.Rule;
import org.junit.Test;
import org.junit.rules.ExpectedException;
import org.junit.runner.RunWith;
import org.mockito.Mock;
import org.mockito.runners.MockitoJUnitRunner;

import java.time.Instant;
import java.util.UUID;
import java.util.stream.Collectors;

import static io.xj.nexus.NexusIntegrationTestingFixtures.makeSegmentChoice;
import static io.xj.nexus.NexusIntegrationTestingFixtures.makeChord;
import static io.xj.nexus.NexusIntegrationTestingFixtures.makeMeme;
import static org.junit.Assert.assertEquals;
import static org.mockito.Matchers.any;
import static org.mockito.Mockito.when;

@RunWith(MockitoJUnitRunner.class)
public class DubDubMasterWaveformPrerollTest {
  private Injector injector;
  private DubFactory dubFactory;
  private FabricatorFactory fabricatorFactory;
  private NexusIntegrationTestingFixtures fake;
  private Chain chain1;
  private Segment segment1;
  private Segment segment2;
  private Segment segment3;
  private Segment segment4;
  private NexusEntityStore store;

  @Rule
  public ExpectedException failure = ExpectedException.none();

  @Mock
  public HubClient hubClient;
  private Segment segment6;
  private Chain chain2;

  @Before
  public void setUp() throws Exception {
    Config config = NexusTestConfiguration.getDefault();
    var injector = AppConfiguration.inject(config,
      ImmutableSet.of(Modules.override(new NexusWorkModule())
        .with(new AbstractModule() {
          @Override
          public void configure() {
            bind(HubClient.class).toInstance(hubClient);
          }
        })));
    fabricatorFactory = injector.getInstance(FabricatorFactory.class);
    dubFactory = injector.getInstance(DubFactory.class);
    var entityFactory = injector.getInstance(EntityFactory.class);
    Topology.buildHubApiTopology(entityFactory);
    Topology.buildNexusApiTopology(entityFactory);

    // Manipulate the underlying entity store; reset before each test
    store = injector.getInstance(NexusEntityStore.class);
    store.deleteAll();

    // Mock request via HubClient returns fake generated library of hub content
    fake = new NexusIntegrationTestingFixtures();
    when(hubClient.ingest(any(), any(), any(), any()))
      .thenReturn(new HubContent(Streams.concat(
        fake.setupFixtureB1().stream(),
        fake.setupFixtureB3().stream()
      ).collect(Collectors.toList())));

    // Chain "Print #2" has 1 initial segment in dubbing state - DubMaster is complete
    chain2 = store.put(Chain.newBuilder()
      .setId(UUID.randomUUID().toString())
      .setAccountId(fake.account1.getId())
      .setName("Print #2")
      .setType(Chain.Type.Production)
      .setState(Chain.State.Fabricate)
      .setStartAt("2014-08-12T12:17:02.527142Z")
      .build());
    store.put(ChainBinding.newBuilder()
      .setId(UUID.randomUUID().toString())
      .setChainId(chain2.getId())
      .setTargetId(fake.library2.getId())
      .setType(ChainBinding.Type.Library)
      .build());

    segment6 = store.put(NexusIntegrationTestingFixtures.makeSegment(chain2, 0, Segment.State.Dubbing, Instant.parse("2017-02-14T12:01:00.000001Z"), Instant.parse("2017-02-14T12:01:07.384616Z"), "C minor", 16, 0.55, 130, "chains-1-segments-9f7s89d8a7892", "wav"));
    store.put(NexusIntegrationTestingFixtures.makeSegmentChoice(segment6, Program.Type.Macro, fake.program4_sequence0_binding0));
    store.put(NexusIntegrationTestingFixtures.makeSegmentChoice(segment6, Program.Type.Main, fake.program5_sequence0_binding0));
    SegmentChoice choice1 = store.put(NexusIntegrationTestingFixtures.makeSegmentChoice(segment6, fake.program35, fake.program35_sequence0, fake.program35_voice0, fake.instrument8));
    store.put(NexusIntegrationTestingFixtures.makeMeme(segment6, "Special"));
    store.put(NexusIntegrationTestingFixtures.makeMeme(segment6, "Wild"));
    store.put(NexusIntegrationTestingFixtures.makeMeme(segment6, "Pessimism"));
    store.put(NexusIntegrationTestingFixtures.makeMeme(segment6, "Outlook"));
    var chord0 = NexusIntegrationTestingFixtures.makeChord(segment6, 0.0, "A minor");
    store.put(chord0);
    store.put(NexusIntegrationTestingFixtures.makeChord(segment6, 8.0, "D major"));
    SegmentChoiceArrangement arr1 = store.put(NexusIntegrationTestingFixtures.makeArrangement(choice1));
    store.put(NexusIntegrationTestingFixtures.makePick(arr1, fake.program35_sequence0_pattern0_event0, fake.instrument8_audio8kick, 0.0, 1.0, 1.0, "A4", "BOOM"));

    // future: insert arrangement of choice1
    // future: insert 8 picks of audio 1
    // future: insert 8 picks of audio 2
  }

  @After
  public void tearDown() {

  }

  @Test
  public void dubMaster_hasWaveformPrerollBeforeSegmentStart() throws Exception {
    Fabricator fabricator = fabricatorFactory.fabricate(HubClientAccess.internal(), segment6);

    dubFactory.master(fabricator).doWork();

    Segment resultSegment = store.getSegment(segment6.getId()).orElseThrow();
    assertEquals(0.01, resultSegment.getWaveformPreroll(), 0.01);
    // future test: success of dub master continue test
  }
}