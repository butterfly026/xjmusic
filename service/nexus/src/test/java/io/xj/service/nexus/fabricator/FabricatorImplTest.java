// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.

package io.xj.service.nexus.fabricator;

import com.google.common.collect.ImmutableList;
import com.google.common.collect.ImmutableSet;
import com.google.common.collect.Streams;
import com.google.inject.AbstractModule;
import com.google.inject.Injector;
import com.google.inject.util.Modules;
import com.typesafe.config.Config;
import io.xj.lib.app.AppConfiguration;
import io.xj.lib.entity.EntityCache;
import io.xj.lib.entity.EntityFactory;
import io.xj.lib.filestore.FileStoreModule;
import io.xj.lib.jsonapi.JsonApiModule;
import io.xj.lib.mixer.MixerModule;
import io.xj.lib.music.Tuning;
import io.xj.service.hub.HubApp;
import io.xj.service.hub.client.HubClient;
import io.xj.service.hub.client.HubClientAccess;
import io.xj.service.hub.client.HubClientModule;
import io.xj.service.hub.client.HubContent;
import io.xj.service.hub.entity.Account;
import io.xj.service.hub.entity.Library;
import io.xj.service.hub.entity.ProgramType;
import io.xj.service.nexus.NexusApp;
import io.xj.service.nexus.NexusHubContentFixtures;
import io.xj.service.nexus.dao.NexusDAOModule;
import io.xj.service.nexus.entity.Chain;
import io.xj.service.nexus.entity.ChainBinding;
import io.xj.service.nexus.entity.ChainConfig;
import io.xj.service.nexus.entity.ChainConfigType;
import io.xj.service.nexus.entity.ChainState;
import io.xj.service.nexus.entity.ChainType;
import io.xj.service.nexus.entity.Segment;
import io.xj.service.nexus.entity.SegmentChoice;
import io.xj.service.nexus.entity.SegmentChoiceArrangement;
import io.xj.service.nexus.entity.SegmentChoiceArrangementPick;
import io.xj.service.nexus.entity.SegmentState;
import io.xj.service.nexus.persistence.NexusEntityStore;
import io.xj.service.nexus.persistence.NexusEntityStoreModule;
import io.xj.service.nexus.testing.NexusTestConfiguration;
import io.xj.service.nexus.work.NexusWorkModule;
import org.junit.Before;
import org.junit.Rule;
import org.junit.Test;
import org.junit.rules.ExpectedException;
import org.junit.runner.RunWith;
import org.mockito.Mock;
import org.mockito.runners.MockitoJUnitRunner;

import java.time.Instant;
import java.util.Collection;
import java.util.stream.Collectors;

import static org.junit.Assert.assertEquals;
import static org.mockito.Matchers.any;
import static org.mockito.Matchers.anyDouble;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

/**
 FUTURE: [#170035559] Split the FabricatorImplTest into separate tests of the FabricatorImpl, SegmentWorkbenchImpl, SegmentRetrospectiveImpl, and IngestImpl
 */
@RunWith(MockitoJUnitRunner.class)
public class FabricatorImplTest {

  @Rule
  public ExpectedException failure = ExpectedException.none();
  @Mock
  public TimeComputerFactory mockTimeComputerFactory;
  @Mock
  public TimeComputer mockTimeComputer;
  @Mock
  public SegmentWorkbenchFactory mockSegmentWorkbenchFactory;
  @Mock
  public SegmentWorkbench mockSegmentWorkbench;
  @Mock
  public SegmentRetrospectiveFactory mockSegmentRetrospectiveFactory;
  @Mock
  public SegmentRetrospective mockSegmentRetrospective;
  @Mock
  public Tuning tuning;
  @Mock
  public HubClient hubClient;
  //
  private Fabricator subject;
  private FabricatorFactory fabricatorFactory;
  private NexusEntityStore store;
  private NexusHubContentFixtures fake;

  @Before
  public void setUp() throws Exception {
    Config config = NexusTestConfiguration.getDefault();
    Injector injector = AppConfiguration.inject(config, ImmutableSet.of(Modules.override(new FileStoreModule(), new NexusDAOModule(), new HubClientModule(), new NexusEntityStoreModule(), new MixerModule(), new JsonApiModule(), new NexusWorkModule(), new NexusFabricatorModule()).with(
      new AbstractModule() {
        @Override
        public void configure() {
          bind(Tuning.class).toInstance(tuning);
          bind(TimeComputerFactory.class).toInstance(mockTimeComputerFactory);
          bind(HubClient.class).toInstance(hubClient);
          bind(SegmentWorkbenchFactory.class).toInstance(mockSegmentWorkbenchFactory);
          bind(SegmentRetrospectiveFactory.class).toInstance(mockSegmentRetrospectiveFactory);
          bind(SegmentWorkbench.class).toInstance(mockSegmentWorkbench);
          bind(SegmentRetrospective.class).toInstance(mockSegmentRetrospective);
        }
      })));
    fabricatorFactory = injector.getInstance(FabricatorFactory.class);
    EntityFactory entityFactory = injector.getInstance(EntityFactory.class);
    HubApp.buildApiTopology(entityFactory);
    NexusApp.buildApiTopology(entityFactory);

    // Manipulate the underlying entity store; reset before each test
    store = injector.getInstance(NexusEntityStore.class);
    store.deleteAll();

    // Mock request via HubClient returns fake generated library of hub content
    fake = new NexusHubContentFixtures();
    when(hubClient.ingest(any(), any(), any(), any()))
      .thenReturn(new HubContent(Streams.concat(
        fake.setupFixtureB1(true).stream(),
        fake.setupFixtureB2().stream(),
        fake.setupFixtureB3().stream()
      ).collect(Collectors.toList())));
  }

  @Test
  public void usesTimeComputer() throws Exception {
    Library library = Library.create();
    Chain chain = store.put(Chain.create(Account.create(), "test", ChainType.Production, ChainState.Fabricate, Instant.parse("2017-12-12T01:00:08.000000Z"), null, null));
    Segment previousSegment = store.put(Segment.create(chain, 1, SegmentState.Crafted, Instant.parse("2017-12-12T01:00:08.000000Z"), Instant.parse("2017-12-12T01:00:16.000000Z"), "F major", 8, 0.6, 120, "seg123.ogg"));
    Segment segment = store.put(Segment.create(chain, 2, SegmentState.Crafting, Instant.parse("2017-12-12T01:00:16.000000Z"), Instant.parse("2017-12-12T01:00:22.000000Z"), "G major", 8, 0.6, 240, "seg123.ogg"));
    store.put(ChainBinding.create(chain, library));
    store.put(ChainConfig.create(chain, ChainConfigType.OutputEncoding, "PCM_SIGNED"));
    when(mockTimeComputerFactory.create(anyDouble(), anyDouble(), anyDouble()))
      .thenReturn(mockTimeComputer);
    when(mockTimeComputer.getSecondsAtPosition(anyDouble()))
      .thenReturn(Double.valueOf(0));
    when(mockSegmentRetrospectiveFactory.workOn(any(), any(), any()))
      .thenReturn(mockSegmentRetrospective);
    when(mockSegmentWorkbenchFactory.workOn(any(), any(), any()))
      .thenReturn(mockSegmentWorkbench);
    when(mockSegmentWorkbench.getSegment())
      .thenReturn(segment);
    when(mockSegmentRetrospective.getPreviousSegment())
      .thenReturn(java.util.Optional.ofNullable(previousSegment));
    subject = fabricatorFactory.fabricate(HubClientAccess.internal(), segment);

    Double result = subject.computeSecondsAtPosition(0); // instantiates a time computer; see expectation above

    assertEquals(Double.valueOf(0), result);
    verify(mockTimeComputerFactory).create(8.0, 120, 240.0);
  }


  @Test
  public void pick_returned_by_picks() throws Exception {
    Chain chain = store.put(Chain.create(Account.create(), "test", ChainType.Production, ChainState.Fabricate, Instant.parse("2017-12-12T01:00:08.000000Z"), null, null));
    Segment previousSegment = store.put(Segment.create(chain, 1, SegmentState.Crafted, Instant.parse("2017-12-12T01:00:08.000000Z"), Instant.parse("2017-12-12T01:00:16.000000Z"), "F major", 8, 0.6, 120, "seg123.ogg"));
    Segment segment = store.put(Segment.create(chain, 2, SegmentState.Crafting, Instant.parse("2017-12-12T01:00:16.000000Z"), Instant.parse("2017-12-12T01:00:22.000000Z"), "G major", 8, 0.6, 240, "seg123.ogg"));
    store.put(ChainBinding.create(chain, fake.library2));
    store.put(ChainConfig.create(chain, ChainConfigType.OutputEncoding, "PCM_SIGNED"));
    store.put(SegmentChoice.create(segment, ProgramType.Main, fake.program5, 4));
    SegmentChoice rhythmChoice = store.put(SegmentChoice.create(segment, ProgramType.Rhythm, fake.program35, 0));
    SegmentChoiceArrangement rhythmArrangement = store.put(SegmentChoiceArrangement.create(segment, rhythmChoice, fake.program35_voice0, fake.instrument8));
    SegmentChoiceArrangementPick rhythmPick = store.put(SegmentChoiceArrangementPick.create(rhythmArrangement)
      .setProgramSequencePatternEventId(fake.program35_sequence0_pattern0_event0.getId())
      .setInstrumentAudioId(fake.instrument8_audio8kick.getId())
      .setName("CLANG")
      .setStart(0.273)
      .setLength(1.571)
      .setAmplitude(0.8)
      .setPitch(432.0));
    when(mockTimeComputerFactory.create(anyDouble(), anyDouble(), anyDouble()))
      .thenReturn(mockTimeComputer);
    when(mockTimeComputer.getSecondsAtPosition(anyDouble()))
      .thenReturn(Double.valueOf(0));
    when(mockSegmentRetrospectiveFactory.workOn(any(), any(), any()))
      .thenReturn(mockSegmentRetrospective);
    when(mockSegmentWorkbenchFactory.workOn(any(), any(), any()))
      .thenReturn(mockSegmentWorkbench);
    when(mockSegmentWorkbench.getSegment())
      .thenReturn(segment);
    when(mockSegmentWorkbench.getSegmentPicks())
      .thenReturn(new EntityCache<>(ImmutableList.of(rhythmPick)));
    when(mockSegmentRetrospective.getPreviousSegment())
      .thenReturn(java.util.Optional.ofNullable(previousSegment));
    subject = fabricatorFactory.fabricate(HubClientAccess.internal(), segment);

    Collection<SegmentChoiceArrangementPick> result = subject.getSegmentPicks();

    SegmentChoiceArrangementPick resultPick = result.iterator().next();
    assertEquals(rhythmArrangement.getId(), resultPick.getSegmentChoiceArrangementId());
    assertEquals(fake.instrument8_audio8kick.getId(), resultPick.getInstrumentAudioId());
    assertEquals(0.273, resultPick.getStart(), 0.001);
    assertEquals(1.571, resultPick.getLength(), 0.001);
    assertEquals(0.8, resultPick.getAmplitude(), 0.1);
    assertEquals(432.0, resultPick.getPitch(), 0.1);
  }
}