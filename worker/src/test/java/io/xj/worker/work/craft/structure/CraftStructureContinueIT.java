// Copyright (c) 2017, Outright Mental Inc. (http://outright.io) All Rights Reserved.
package io.xj.worker.work.craft.structure;

import org.jooq.types.ULong;

import com.google.inject.Guice;
import com.google.inject.Injector;

import io.xj.core.CoreModule;
import io.xj.core.integration.IntegrationTestEntity;
import io.xj.core.integration.IntegrationTestService;
import io.xj.core.model.chain.ChainState;
import io.xj.core.model.chain.ChainType;
import io.xj.core.model.idea.IdeaType;
import io.xj.core.model.link.Link;
import io.xj.core.model.link.LinkState;
import io.xj.core.model.role.Role;
import io.xj.core.work.basis.Basis;
import io.xj.core.work.basis.BasisFactory;
import io.xj.worker.WorkerModule;
import io.xj.worker.work.craft.CraftFactory;
import org.junit.After;
import org.junit.Before;
import org.junit.Rule;
import org.junit.Test;
import org.junit.rules.ExpectedException;

import java.sql.Timestamp;

import static io.xj.core.Tables.CHOICE;
import static org.junit.Assert.assertNotNull;

public class CraftStructureContinueIT {
  @Rule public ExpectedException failure = ExpectedException.none();
  private final Injector injector = Guice.createInjector(new CoreModule(), new WorkerModule());
  private CraftFactory craftFactory;
  private BasisFactory basisFactory;

  // Testing entities for reference
  private Link link4;

  @Before
  public void setUp() throws Exception {
    IntegrationTestEntity.deleteAll();

    // Account "manatees"
    IntegrationTestEntity.insertAccount(1, "manatees");

    // Jen has "user" and "admin" roles, belongs to account "manatees", has "google" auth
    IntegrationTestEntity.insertUser(2, "jen", "jen@email.com", "http://pictures.com/jen.gif");
    IntegrationTestEntity.insertUserRole(1, 2, Role.ADMIN);

    // Fred has a "user" role and belongs to account "manatees"
    IntegrationTestEntity.insertUser(3, "fred", "fred@email.com", "http://pictures.com/fred.gif");
    IntegrationTestEntity.insertUserRole(2, 3, Role.USER);
    IntegrationTestEntity.insertAccountUser(3, 1, 3);

    // Library "house"
    IntegrationTestEntity.insertLibrary(2, 1, "house");

    // "Classic, Wild to Cozy" macro-idea in house library
    IntegrationTestEntity.insertIdea(4, 3, 2, IdeaType.Macro, "Classic, Wild to Cozy", 0.5, "C", 120);
    IntegrationTestEntity.insertIdeaMeme(2, 4, "Classic");
    IntegrationTestEntity.insertPhase(3, 4, 0, 64, "Start Wild", 0.6, "C", 125);
    IntegrationTestEntity.insertPhaseMeme(3, 3, "Wild");
    IntegrationTestEntity.insertPhaseChord(3, 3, 0, "C");
    IntegrationTestEntity.insertPhase(4, 4, 1, 64, "Finish Finish Cozy", 0.4, "Bb minor", 115);
    IntegrationTestEntity.insertPhaseMeme(4, 4, "Cozy");
    IntegrationTestEntity.insertPhaseChord(4, 4, 0, "Bb minor");

    // Main idea
    IntegrationTestEntity.insertIdea(5, 3, 2, IdeaType.Main, "Main Jam", 0.2, "Gb minor", 140);
    IntegrationTestEntity.insertIdeaMeme(3, 5, "Outlook");
    IntegrationTestEntity.insertPhase(15, 5, 0, 16, "Intro", 0.5, "Gb minor", 135.0);
    IntegrationTestEntity.insertPhaseMeme(6, 15, "Cloudy");
    IntegrationTestEntity.insertPhaseChord(12, 15, 0, "Gb minor");
    IntegrationTestEntity.insertPhaseChord(14, 15, 8, "G minor");
    IntegrationTestEntity.insertPhase(16, 5, 1, 16, "Intro", 0.5, "G major", 135.0);
    IntegrationTestEntity.insertPhaseMeme(7, 16, "Rosy");
    IntegrationTestEntity.insertPhaseChord(16, 16, 0, "D minor");
    IntegrationTestEntity.insertPhaseChord(18, 16, 8, "G major");

    // A basic beat
    IntegrationTestEntity.insertIdea(35, 3, 2, IdeaType.Rhythm, "Basic Beat", 0.2, "C", 121);
    IntegrationTestEntity.insertIdeaMeme(343, 35, "Basic");
    IntegrationTestEntity.insertPhase(315, 35, 0, 16, "Drop", 0.5, "C", 125.0);
    IntegrationTestEntity.insertPhaseMeme(346, 315, "Heavy");
    IntegrationTestEntity.insertPhase(316, 35, 1, 16, "Continue", 0.5, "C", 125.0);
    IntegrationTestEntity.insertPhaseMeme(347, 316, "Heavy");

    // support idea
    IntegrationTestEntity.insertIdea(7, 3, 2, IdeaType.Support, "Support Jam", 0.3, "Cb minor", 170);

    // Chain "Test Print #1" has 5 total links
    IntegrationTestEntity.insertChain(1, 1, "Test Print #1", ChainType.Production, ChainState.Fabricating, Timestamp.valueOf("2014-08-12 12:17:02.527142"), null, null);
    IntegrationTestEntity.insertLink(1, 1, 0, LinkState.Dubbed, Timestamp.valueOf("2017-02-14 12:01:00.000001"), Timestamp.valueOf("2017-02-14 12:01:32.000001"), "D major", 64, 0.73, 120, "chain-1-link-97898asdf7892.wav");
    IntegrationTestEntity.insertLink(2, 1, 1, LinkState.Dubbing, Timestamp.valueOf("2017-02-14 12:01:32.000001"), Timestamp.valueOf("2017-02-14 12:02:04.000001"), "Db minor", 64, 0.85, 120, "chain-1-link-97898asdf7892.wav");

    // Chain "Test Print #1" has this link that was just crafted
    IntegrationTestEntity.insertLink(3, 1, 2, LinkState.Crafted, Timestamp.valueOf("2017-02-14 12:02:04.000001"), Timestamp.valueOf("2017-02-14 12:02:36.000001"), "F major", 64, 0.30, 120, "chain-1-link-97898asdf7892.wav");
    IntegrationTestEntity.insertChoice(25, 3, 4, IdeaType.Macro, 1, 3);
    IntegrationTestEntity.insertChoice(26, 3, 5, IdeaType.Main, 0, 5);
    IntegrationTestEntity.insertChoice(27, 3, 35, IdeaType.Rhythm, 0, 5);

    // Chain "Test Print #1" is crafting - Foundation is complete
    link4 = IntegrationTestEntity.insertLink(4, 1, 3, LinkState.Crafting, Timestamp.valueOf("2017-02-14 12:03:08.000001"), Timestamp.valueOf("2017-02-14 12:03:15.836735"), "D major", 16, 0.45, 120, "chain-1-link-97898asdf7892.wav");
    IntegrationTestEntity.insertLinkMeme(101,4,"Cozy");
    IntegrationTestEntity.insertLinkMeme(102,4,"Classic");
    IntegrationTestEntity.insertLinkMeme(103,4,"Outlook");
    IntegrationTestEntity.insertLinkMeme(104,4,"Rosy");
    IntegrationTestEntity.insertChoice(101,4, 4, IdeaType.Macro,1,3);
    IntegrationTestEntity.insertChoice(102,4, 5, IdeaType.Main,1,-5);
    IntegrationTestEntity.insertLinkChord(101,4,0,"A minor");
    IntegrationTestEntity.insertLinkChord(102,4,8,"D major");

    // Bind the library to the chain
    IntegrationTestEntity.insertChainLibrary(1, 1, 2);

    // Instantiate the test subject
    craftFactory = injector.getInstance(CraftFactory.class);
    basisFactory = injector.getInstance(BasisFactory.class);
  }

  @After
  public void tearDown() throws Exception {
    craftFactory = null;
    basisFactory = null;
  }

  @Test
  public void craftStructureContinue() throws Exception {
    Basis basis = basisFactory.createBasis(link4);

    craftFactory.structure(basis).doWork();

    // choice of rhythm-type idea
    assertNotNull(IntegrationTestService.getDb().selectFrom(CHOICE)
      .where(CHOICE.LINK_ID.eq(ULong.valueOf(4)))
      .and(CHOICE.IDEA_ID.eq(ULong.valueOf(35)))
      .and(CHOICE.TYPE.eq(IdeaType.Rhythm.toString()))
      .and(CHOICE.TRANSPOSE.eq(2))
      .and(CHOICE.PHASE_OFFSET.eq(ULong.valueOf(1)))
      .fetchOne());

  }

}