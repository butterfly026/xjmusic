// Copyright (c) 2018, XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.worker.job;

import io.xj.core.CoreModule;
import io.xj.core.access.impl.Access;
import io.xj.core.app.App;
import io.xj.core.dao.LinkDAO;
import io.xj.core.external.amazon.AmazonProvider;
import io.xj.core.integration.IntegrationTestEntity;
import io.xj.core.model.chain.ChainState;
import io.xj.core.model.chain.ChainType;
import io.xj.core.model.link.Link;
import io.xj.core.model.pattern.PatternState;
import io.xj.core.model.pattern.PatternType;
import io.xj.core.model.phase.PhaseState;
import io.xj.core.model.phase.PhaseType;
import io.xj.core.model.user_role.UserRoleType;
import io.xj.core.timestamp.TimestampUTC;
import io.xj.craft.CraftModule;
import io.xj.dub.DubModule;
import io.xj.worker.WorkerModule;

import com.google.common.collect.ImmutableList;
import com.google.inject.AbstractModule;
import com.google.inject.Guice;
import com.google.inject.Injector;
import com.google.inject.util.Modules;

import net.greghaines.jesque.worker.JobFactory;
import org.junit.After;
import org.junit.Before;
import org.junit.Rule;
import org.junit.Test;
import org.junit.rules.ExpectedException;
import org.junit.runner.RunWith;
import org.mockito.Mock;
import org.mockito.runners.MockitoJUnitRunner;

import java.math.BigInteger;
import java.util.Collection;

import static org.junit.Assert.assertTrue;
import static org.mockito.Matchers.any;
import static org.mockito.Matchers.eq;
import static org.mockito.Mockito.atLeast;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@RunWith(MockitoJUnitRunner.class)
public class ChainLinkFabricateJobsIT {
  @Rule public ExpectedException failure = ExpectedException.none();
  private Injector injector;
  @Mock AmazonProvider amazonProvider;
  private static final int TEST_DURATION_SECONDS = 15;
  private static final int MILLIS_PER_SECOND = 1000;
  private App app;

  @Before
  public void setUp() throws Exception {
    IntegrationTestEntity.reset();

    // inject mocks
    createInjector();

    // Account "pilots"
    IntegrationTestEntity.insertAccount(1, "pilots");

    // Ted has "user" and "admin" roles, belongs to account "pilots", has "google" auth
    IntegrationTestEntity.insertUser(2, "ted", "ted@email.com", "http://pictures.com/ted.gif");
    IntegrationTestEntity.insertUserRole(1, 2, UserRoleType.Admin);

    // Sally has a "user" role and belongs to account "pilots"
    IntegrationTestEntity.insertUser(3, "sally", "sally@email.com", "http://pictures.com/sally.gif");
    IntegrationTestEntity.insertUserRole(2, 3, UserRoleType.User);
    IntegrationTestEntity.insertAccountUser(3, 1, 3);

    // Library "house"
    IntegrationTestEntity.insertLibrary(2, 1, "house");

    // "Heavy, Deep to Metal" macro-pattern in house library
    IntegrationTestEntity.insertPattern(4, 3, 2, PatternType.Macro, PatternState.Published, "Heavy, Deep to Metal", 0.5, "C", 120);
    IntegrationTestEntity.insertPatternMeme(2, 4, "Heavy");
    // " phase offset 0
    IntegrationTestEntity.insertPhase(3, 4, PhaseType.Macro, PhaseState.Published, 0, 0, "Start Deep", 0.6, "C", 125);
    IntegrationTestEntity.insertPhaseMeme(3, 3, "Deep");
    IntegrationTestEntity.insertPhaseChord(3, 3, 0, "C");
    // " phase offset 1
    IntegrationTestEntity.insertPhase(4, 4, PhaseType.Macro, PhaseState.Published, 1, 0, "Intermediate", 0.4, "Bb minor", 115);
    IntegrationTestEntity.insertPhaseMeme(4, 4, "Metal");
    IntegrationTestEntity.insertPhaseMeme(49, 4, "Deep");
    IntegrationTestEntity.insertPhaseChord(4, 4, 0, "Bb minor");
    // " phase offset 2
    IntegrationTestEntity.insertPhase(5, 4, PhaseType.Macro, PhaseState.Published, 2, 0, "Finish Metal", 0.4, "Ab minor", 125);
    IntegrationTestEntity.insertPhaseMeme(5, 4, "Metal");
    IntegrationTestEntity.insertPhaseChord(5, 5, 0, "Ab minor");

    // "Tech, Steampunk to Modern" macro-pattern in house library
    IntegrationTestEntity.insertPattern(3, 3, 2, PatternType.Macro, PatternState.Published, "Tech, Steampunk to Modern", 0.5, "G minor", 120);
    IntegrationTestEntity.insertPatternMeme(1, 3, "Tech");
    // # phase offset 0
    IntegrationTestEntity.insertPhase(1, 3, PhaseType.Macro, PhaseState.Published, 0, 0, "Start Steampunk", 0.4, "G minor", 115);
    IntegrationTestEntity.insertPhaseMeme(1, 1, "Steampunk");
    IntegrationTestEntity.insertPhaseChord(1, 1, 0, "G minor");
    // # phase offset 1
    IntegrationTestEntity.insertPhase(2, 3, PhaseType.Macro, PhaseState.Published, 1, 0, "Finish Modern", 0.6, "C", 125);
    IntegrationTestEntity.insertPhaseMeme(2, 2, "Modern");
    IntegrationTestEntity.insertPhaseChord(2, 2, 0, "C");

    // Main pattern
    IntegrationTestEntity.insertPattern(5, 3, 2, PatternType.Main, PatternState.Published, "Main Jam", 0.2, "C minor", 140);
    IntegrationTestEntity.insertPatternMeme(3, 5, "Attitude");
    // # phase offset 0
    IntegrationTestEntity.insertPhase(15, 5, PhaseType.Main, PhaseState.Published, 0, 16, "Intro", 0.5, "G major", 135.0);
    IntegrationTestEntity.insertPhaseMeme(6, 15, "Gritty");
    IntegrationTestEntity.insertPhaseChord(12, 15, 0, "G major");
    IntegrationTestEntity.insertPhaseChord(14, 15, 8, "Ab minor");
    // # phase offset 1
    IntegrationTestEntity.insertPhase(16, 5, PhaseType.Main, PhaseState.Published, 1, 16, "Drop", 0.5, "G minor", 135.0);
    IntegrationTestEntity.insertPhaseMeme(7, 16, "Gentle");
    IntegrationTestEntity.insertPhaseChord(16, 16, 0, "C major");
    IntegrationTestEntity.insertPhaseChord(18, 16, 8, "Bb minor");

    // Another Main pattern to go to
    IntegrationTestEntity.insertPattern(15, 3, 2, PatternType.Main, PatternState.Published, "Next Jam", 0.2, "Db minor", 140);
    IntegrationTestEntity.insertPatternMeme(43, 15, "Temptation");
    IntegrationTestEntity.insertPhase(415, 15, PhaseType.Main, PhaseState.Published, 0, 16, "Intro", 0.5, "G minor", 135.0);
    IntegrationTestEntity.insertPhaseMeme(46, 415, "Food");
    IntegrationTestEntity.insertPhaseChord(412, 415, 0, "G minor");
    IntegrationTestEntity.insertPhaseChord(414, 415, 8, "Ab minor");
    IntegrationTestEntity.insertPhase(416, 15, PhaseType.Main, PhaseState.Published, 1, 16, "Outro", 0.5, "A major", 135.0);
    IntegrationTestEntity.insertPhaseMeme(47, 416, "Drink");
    IntegrationTestEntity.insertPhaseMeme(149, 416, "Shame");
    IntegrationTestEntity.insertPhaseChord(416, 416, 0, "C major");
    IntegrationTestEntity.insertPhaseChord(418, 416, 8, "Bb major");

    // A basic beat
    IntegrationTestEntity.insertPattern(35, 3, 2, PatternType.Rhythm, PatternState.Published, "Basic Beat", 0.2, "C", 121);
    IntegrationTestEntity.insertPatternMeme(343, 35, "Basic");
    IntegrationTestEntity.insertPhase(315, 35, PhaseType.Loop, PhaseState.Published, 0, 16, "Drop", 0.5, "C", 125.0);
    IntegrationTestEntity.insertPhaseMeme(346, 315, "Heavy");

    // Chain "Test Print #1" is ready to begin
    IntegrationTestEntity.insertChain(1, 1, "Test Print #1", ChainType.Production, ChainState.Fabricate, TimestampUTC.nowMinusSeconds(1000), null, null);

    // Bind the library to the chain
    IntegrationTestEntity.insertChainLibrary(1, 1, 2);

    // ExpectationOfWork recurs frequently to speed up test
    System.setProperty("work.buffer.seconds", "1000");
    System.setProperty("work.buffer.craft.delay.seconds", "1");
    System.setProperty("work.buffer.dub.delay.seconds", "3");
    System.setProperty("work.chain.recur.seconds", "1");
    System.setProperty("work.chain.delete.recur.seconds", "1");
    System.setProperty("work.chain.delay.seconds", "1");

    // Don't sleep between processing work
    System.setProperty("app.port", "9043");

    // link file config
    System.setProperty("link.file.bucket", "xj-link-test");

    // work concurrency config
    System.setProperty("work.concurrency", "1");

    // Server App
    app = injector.getInstance(App.class);
    app.configureServer("io.xj.worker");

    // Attach Job Factory to App
    JobFactory jobFactory = injector.getInstance(JobFactory.class);
    app.setJobFactory(jobFactory);
  }

  @After
  public void tearDown() throws Exception {
    app = null;

    System.clearProperty("link.file.bucket");

    System.clearProperty("work.concurrency");

    System.clearProperty("work.buffer.seconds");
    System.clearProperty("work.buffer.craft.delay.seconds");
    System.clearProperty("work.buffer.dub.delay.seconds");
    System.clearProperty("work.chain.recur.seconds");
    System.clearProperty("work.chain.delete.recur.seconds");
    System.clearProperty("work.chain.delay.seconds");
  }

  private void createInjector() {
    injector = Guice.createInjector(Modules.override(new CoreModule(), new WorkerModule(), new CraftModule(), new DubModule()).with(
      new AbstractModule() {
        @Override
        public void configure() {
          bind(AmazonProvider.class).toInstance(amazonProvider);
        }
      }));
  }

  @Test
  public void runWorker() throws Exception {
    when(amazonProvider.generateKey("chain-1-link", "mp3"))
      .thenReturn("chain-1-link-12345.mp3");

    // Start app, send chain fabrication message to queue
    app.start();
    app.getWorkManager().startChainFabrication(BigInteger.valueOf(1));

    // wait for work, stop chain fabrication, stop app
    Thread.sleep(TEST_DURATION_SECONDS * MILLIS_PER_SECOND);
    app.getWorkManager().stopChainFabrication(BigInteger.valueOf(1));
    app.stop();

    // assertions
    int assertShippedLinksMinimum = 3;
    verify(amazonProvider, atLeast(assertShippedLinksMinimum)).putS3Object(eq("/tmp/chain-1-link-12345.mp3"), eq("xj-link-test"), any());
    Collection<Link> result = injector.getInstance(LinkDAO.class).readAll(Access.internal(), ImmutableList.of(BigInteger.valueOf(1)));
    assertTrue(assertShippedLinksMinimum < result.size());
  }

}
