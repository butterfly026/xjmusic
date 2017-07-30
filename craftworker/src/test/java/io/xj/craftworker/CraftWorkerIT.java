// Copyright (c) 2017, Outright Mental Inc. (http://outright.io) All Rights Reserved.
package io.xj.craftworker;

import io.xj.core.CoreModule;
import io.xj.core.app.App;
import io.xj.core.chain_gang.ChainGangFactory;
import io.xj.core.chain_gang.ChainGangOperation;
import io.xj.core.chain_gang.impl.link_pilot_work.LinkPilotWorkFactoryModule;
import io.xj.core.chain_gang.impl.link_work.LinkWorkFactoryModule;
import io.xj.core.integration.IntegrationTestEntity;
import io.xj.core.integration.IntegrationTestService;
import io.xj.core.model.chain.ChainState;
import io.xj.core.model.chain.ChainType;
import io.xj.core.model.idea.IdeaType;
import io.xj.core.model.link.LinkState;
import io.xj.core.model.role.Role;
import io.xj.core.tables.records.LinkRecord;

import org.jooq.Result;

import com.google.inject.Guice;
import com.google.inject.Injector;

import org.junit.After;
import org.junit.Before;
import org.junit.Rule;
import org.junit.Test;
import org.junit.rules.ExpectedException;

import java.sql.Timestamp;
import java.util.Date;

import static io.xj.core.Tables.LINK;
import static org.junit.Assert.assertTrue;

public class CraftWorkerIT {
  @Rule public ExpectedException failure = ExpectedException.none();
  private final Injector injector = Guice.createInjector(new CoreModule(), new CraftworkerModule());
  private App app;

  @Before
  public void setUp() throws Exception {
    IntegrationTestEntity.deleteAll();

    // Account "pilots"
    IntegrationTestEntity.insertAccount(1, "pilots");

    // Ted has "user" and "admin" roles, belongs to account "pilots", has "google" auth
    IntegrationTestEntity.insertUser(2, "ted", "ted@email.com", "http://pictures.com/ted.gif");
    IntegrationTestEntity.insertUserRole(1, 2, Role.ADMIN);

    // Sally has a "user" role and belongs to account "pilots"
    IntegrationTestEntity.insertUser(3, "sally", "sally@email.com", "http://pictures.com/sally.gif");
    IntegrationTestEntity.insertUserRole(2, 3, Role.USER);
    IntegrationTestEntity.insertAccountUser(3, 1, 3);

    // Library "house"
    IntegrationTestEntity.insertLibrary(2, 1, "house");

    // "Heavy, Deep to Metal" macro-idea in house library
    IntegrationTestEntity.insertIdea(4, 3, 2, IdeaType.Macro, "Heavy, Deep to Metal", 0.5, "C", 120);
    IntegrationTestEntity.insertIdeaMeme(2, 4, "Heavy");
    // " phase offset 0
    IntegrationTestEntity.insertPhase(3, 4, 0, 0, "Start Deep", 0.6, "C", 125);
    IntegrationTestEntity.insertPhaseMeme(3, 3, "Deep");
    IntegrationTestEntity.insertPhaseChord(3, 3, 0, "C");
    // " phase offset 1
    IntegrationTestEntity.insertPhase(4, 4, 1, 0, "Intermediate", 0.4, "Bb minor", 115);
    IntegrationTestEntity.insertPhaseMeme(4, 4, "Metal");
    IntegrationTestEntity.insertPhaseMeme(49, 4, "Deep");
    IntegrationTestEntity.insertPhaseChord(4, 4, 0, "Bb minor");
    // " phase offset 2
    IntegrationTestEntity.insertPhase(5, 4, 2, 0, "Finish Metal", 0.4, "Ab minor", 125);
    IntegrationTestEntity.insertPhaseMeme(5, 4, "Metal");
    IntegrationTestEntity.insertPhaseChord(5, 5, 0, "Ab minor");

    // "Tech, Steampunk to Modern" macro-idea in house library
    IntegrationTestEntity.insertIdea(3, 3, 2, IdeaType.Macro, "Tech, Steampunk to Modern", 0.5, "G minor", 120);
    IntegrationTestEntity.insertIdeaMeme(1, 3, "Tech");
    // # phase offset 0
    IntegrationTestEntity.insertPhase(1, 3, 0, 0, "Start Steampunk", 0.4, "G minor", 115);
    IntegrationTestEntity.insertPhaseMeme(1, 1, "Steampunk");
    IntegrationTestEntity.insertPhaseChord(1, 1, 0, "G minor");
    // # phase offset 1
    IntegrationTestEntity.insertPhase(2, 3, 1, 0, "Finish Modern", 0.6, "C", 125);
    IntegrationTestEntity.insertPhaseMeme(2, 2, "Modern");
    IntegrationTestEntity.insertPhaseChord(2, 2, 0, "C");

    // Main idea
    IntegrationTestEntity.insertIdea(5, 3, 2, IdeaType.Main, "Main Jam", 0.2, "C minor", 140);
    IntegrationTestEntity.insertIdeaMeme(3, 5, "Attitude");
    // # phase offset 0
    IntegrationTestEntity.insertPhase(15, 5, 0, 16, "Intro", 0.5, "G major", 135.0);
    IntegrationTestEntity.insertPhaseMeme(6, 15, "Gritty");
    IntegrationTestEntity.insertPhaseChord(12, 15, 0, "G major");
    IntegrationTestEntity.insertPhaseChord(14, 15, 8, "Ab minor");
    // # phase offset 1
    IntegrationTestEntity.insertPhase(16, 5, 1, 16, "Drop", 0.5, "G minor", 135.0);
    IntegrationTestEntity.insertPhaseMeme(7, 16, "Gentle");
    IntegrationTestEntity.insertPhaseChord(16, 16, 0, "C major");
    IntegrationTestEntity.insertPhaseChord(18, 16, 8, "Bb minor");

    // Another Main idea to go to
    IntegrationTestEntity.insertIdea(15, 3, 2, IdeaType.Main, "Next Jam", 0.2, "Db minor", 140);
    IntegrationTestEntity.insertIdeaMeme(43, 15, "Temptation");
    IntegrationTestEntity.insertPhase(415, 15, 0, 16, "Intro", 0.5, "G minor", 135.0);
    IntegrationTestEntity.insertPhaseMeme(46, 415, "Food");
    IntegrationTestEntity.insertPhaseChord(412, 415, 0, "G minor");
    IntegrationTestEntity.insertPhaseChord(414, 415, 8, "Ab minor");
    IntegrationTestEntity.insertPhase(416, 15, 1, 16, "Outro", 0.5, "A major", 135.0);
    IntegrationTestEntity.insertPhaseMeme(47, 416, "Drink");
    IntegrationTestEntity.insertPhaseMeme(149, 416, "Shame");
    IntegrationTestEntity.insertPhaseChord(416, 416, 0, "C major");
    IntegrationTestEntity.insertPhaseChord(418, 416, 8, "Bb major");

    // A basic beat
    IntegrationTestEntity.insertIdea(35, 3, 2, IdeaType.Rhythm, "Basic Beat", 0.2, "C", 121);
    IntegrationTestEntity.insertIdeaMeme(343, 35, "Basic");
    IntegrationTestEntity.insertPhase(315, 35, 0, 16, "Drop", 0.5, "C", 125.0);
    IntegrationTestEntity.insertPhaseMeme(346, 315, "Heavy");

    // Chain "Test Print #1" is ready to begin
    IntegrationTestEntity.insertChain(1, 1, "Test Print #1", ChainType.Production, ChainState.Fabricating, Timestamp.from(new Date().toInstant().minusSeconds(300)), Timestamp.from(new Date().toInstant()));

    // Bind the library to the chain
    IntegrationTestEntity.insertChainLibrary(1, 1, 2);

    // Don't sleep between processing work
    System.setProperty("app.port", "9043");

    // Server App
    app = injector.getInstance(App.class);
    app.configureServer("io.xj.craftworker");

    // Pilot-type Workload
    ChainGangFactory pilotChainGangFactory = Guice.createInjector(new CoreModule(),
      new LinkPilotWorkFactoryModule()).getInstance(ChainGangFactory.class);
    app.registerGangWorkload(
      "Create New Links",
      pilotChainGangFactory.createLeader(300, 10),
      pilotChainGangFactory.createFollower(LinkState.Planned)
    );

    // Link-type Workload
    ChainGangOperation linkChainGangOperation = Guice.createInjector(new CoreModule(),
      new CraftworkerModule()).getInstance(ChainGangOperation.class);
    ChainGangFactory chainGangFactory = Guice.createInjector(new CoreModule(),
      new LinkWorkFactoryModule()).getInstance(ChainGangFactory.class);
    app.registerGangWorkload(
      "Craft Links",
      chainGangFactory.createLeader(LinkState.Planned, 300, 10),
      chainGangFactory.createFollower(LinkState.Crafting, LinkState.Crafted, linkChainGangOperation)
    );
  }

  @After
  public void tearDown() throws Exception {
    app = null;
  }

  @Test
  public void craftworkerRun() throws Exception {

    app.start();
    int testDurationSeconds = 15;
    Thread.sleep(testDurationSeconds * 1000L);
    app.stop();

    Result<LinkRecord> resultLinks = IntegrationTestService.getDb()
      .selectFrom(LINK)
      .fetch();
    assertTrue(3L < resultLinks.size());
  }

}
