// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.craft.rhythm;

import com.google.common.collect.ImmutableList;
import com.google.inject.Injector;
import com.typesafe.config.Config;
import io.xj.core.CoreModule;
import io.xj.core.IntegrationTestingFixtures;
import io.xj.core.access.Access;
import io.xj.core.app.AppConfiguration;
import io.xj.core.dao.SegmentChoiceDAO;
import io.xj.core.exception.CoreException;
import io.xj.core.fabricator.Fabricator;
import io.xj.core.fabricator.FabricatorFactory;
import io.xj.core.model.Chain;
import io.xj.core.model.ChainBinding;
import io.xj.core.model.ChainState;
import io.xj.core.model.ChainType;
import io.xj.core.model.ProgramType;
import io.xj.core.model.Segment;
import io.xj.core.model.SegmentChoice;
import io.xj.core.model.SegmentChord;
import io.xj.core.model.SegmentMeme;
import io.xj.core.model.SegmentState;
import io.xj.core.testing.AppTestConfiguration;
import io.xj.core.testing.IntegrationTestProvider;
import io.xj.craft.CraftFactory;
import io.xj.craft.CraftModule;
import org.junit.After;
import org.junit.Before;
import org.junit.Rule;
import org.junit.Test;
import org.junit.rules.ExpectedException;

import java.time.Instant;
import java.util.Collection;

import static org.junit.Assert.assertNotNull;

public class CraftRhythmNextMacroIT {
  @Rule
  public ExpectedException failure = ExpectedException.none();
  private CraftFactory craftFactory;
  private FabricatorFactory fabricatorFactory;

  private IntegrationTestingFixtures fake;
  private Injector injector;
  private IntegrationTestProvider test;

  @Before
  public void setUp() throws Exception {
    Config config = AppTestConfiguration.getDefault();
    injector = AppConfiguration.inject(config, ImmutableList.of(new CoreModule(), new CraftModule()));
    test = injector.getInstance(IntegrationTestProvider.class);
    fake = new IntegrationTestingFixtures(test);
    fabricatorFactory = injector.getInstance(FabricatorFactory.class);
    craftFactory = injector.getInstance(CraftFactory.class);

    // Fixtures
    test.reset();
    fake.insertFixtureB1();
    fake.insertFixtureB2();
    fake.insertFixtureB_Instruments();

    // Chain "Test Print #1" has 5 total segments
    fake.chain1 = test.insert(Chain.create(fake.account1, "Test Print #1", ChainType.Production, ChainState.Fabricate, Instant.parse("2014-08-12T12:17:02.527142Z"), null, null));
    test.insert(ChainBinding.create(fake.chain1, fake.library2));
    fake.segment1 = test.insert(Segment.create(fake.chain1, 0, SegmentState.Dubbed, Instant.parse("2017-02-14T12:01:00.000001Z"), Instant.parse("2017-02-14T12:01:32.000001Z"), "D major", 64, 0.73, 120, "chains-1-segments-9f7s89d8a7892.wav"));
    fake.segment2 = test.insert(Segment.create(fake.chain1, 1, SegmentState.Dubbing, Instant.parse("2017-02-14T12:01:32.000001Z"), Instant.parse("2017-02-14T12:02:04.000001Z"), "Db minor", 64, 0.85, 120, "chains-1-segments-9f7s89d8a7892.wav"));
  }

  @After
  public void tearDown() {
    test.shutdown();
  }

  @Test
  public void craftRhythmNextMacro() throws Exception {
    insertSegments3and4(true);
    Fabricator fabricator = fabricatorFactory.fabricate(Access.internal(), fake.segment4);

    craftFactory.rhythm(fabricator).doWork();

    // assert choice of rhythm-type sequence
    Collection<SegmentChoice> segmentChoices = injector.getInstance(SegmentChoiceDAO.class)
      .readMany(Access.internal(), ImmutableList.of(fake.segment4.getId()));
    assertNotNull(SegmentChoice.findFirstOfType(segmentChoices, ProgramType.Rhythm));
  }

  @Test
  public void craftRhythmNextMacro_okEvenWithoutPreviousSegmentRhythmChoice() throws Exception {
    insertSegments3and4(false);
    Fabricator fabricator = fabricatorFactory.fabricate(Access.internal(), fake.segment4);

    craftFactory.rhythm(fabricator).doWork();

    // assert choice of rhythm-type sequence
    Collection<SegmentChoice> segmentChoices = injector.getInstance(SegmentChoiceDAO.class)
      .readMany(Access.internal(), ImmutableList.of(fake.segment4.getId()));
    assertNotNull(SegmentChoice.findFirstOfType(segmentChoices, ProgramType.Rhythm));
  }

  /**
   Insert fixture segments 3 and 4, including the rhythm choice for segment 3 only if specified

   @param excludeRhythmChoiceForSegment3 if desired for the purpose of this test
   */
  private void insertSegments3and4(boolean excludeRhythmChoiceForSegment3) throws CoreException {
    // Chain "Test Print #1" has this segment that was just crafted
    fake.segment3 = test.insert(Segment.create()
      .setChainId(fake.chain1.getId())
      .setOffset(2L)
      .setStateEnum(SegmentState.Crafted)
      .setBeginAt("2017-02-14T12:02:04.000001Z")
      .setEndAt("2017-02-14T12:02:36.000001Z")
      .setKey("Ab minor")
      .setTotal(64)
      .setDensity(0.30)
      .setTempo(120.0)
      .setWaveformKey("chains-1-segments-9f7s89d8a7892.wav"));
    test.insert(SegmentChoice.create().setSegmentId(fake.segment3.getId())
      .setProgramId(fake.program4.getId())
      .setProgramSequenceBindingId(fake.program4_binding2.getId())
      .setTypeEnum(ProgramType.Macro)
      .setTranspose(3));
    test.insert(SegmentChoice.create().setSegmentId(fake.segment3.getId())
      .setProgramId(fake.program5.getId())
      .setProgramSequenceBindingId(fake.program5_binding1.getId())
      .setTypeEnum(ProgramType.Main)
      .setTranspose(1));
    if (!excludeRhythmChoiceForSegment3)
      test.insert(SegmentChoice.create().setSegmentId(fake.segment3.getId())
        .setProgramId(fake.program35.getId())
        .setTypeEnum(ProgramType.Rhythm)
        .setTranspose(-4));

    // Chain "Test Print #1" has a segment in crafting state - Foundation is complete
    fake.segment4 = test.insert(Segment.create()
      .setChainId(fake.chain1.getId())
      .setOffset(3L)
      .setStateEnum(SegmentState.Crafting)
      .setBeginAt("2017-02-14T12:03:08.000001Z")
      .setEndAt("2017-02-14T12:03:15.836735Z")
      .setKey("F minor")
      .setTotal(16)
      .setDensity(0.45)
      .setTempo(125.0)
      .setWaveformKey("chains-1-segments-9f7s89d8a7892.wav"));
    test.insert(SegmentChoice.create().setSegmentId(fake.segment4.getId())
      .setProgramId(fake.program3.getId())
      .setProgramSequenceBindingId(fake.program3_binding0.getId())
      .setTypeEnum(ProgramType.Macro)
      .setTranspose(4));
    test.insert(SegmentChoice.create().setSegmentId(fake.segment4.getId())
      .setProgramId(fake.program15.getId())
      .setProgramSequenceBindingId(fake.program15_binding0.getId())
      .setTypeEnum(ProgramType.Main)
      .setTranspose(-2));
    for (String memeName : ImmutableList.of("Hindsight", "Chunky", "Regret", "Tangy")) {
      test.insert(SegmentMeme.create(fake.segment4, memeName));
    }
    test.insert(SegmentChord.create()
      .setSegmentId(fake.segment4.getId())
      .setPosition(0.0)
      .setName("F minor"));
    test.insert(SegmentChord.create()
      .setSegmentId(fake.segment4.getId())
      .setPosition(8.0)
      .setName("Gb minor"));
  }


}
