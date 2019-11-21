//  Copyright (c) 2020, XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.worker.job.special;

import com.google.common.collect.ImmutableList;
import com.google.inject.AbstractModule;
import com.google.inject.Guice;
import com.google.inject.util.Modules;
import io.xj.core.CoreModule;
import io.xj.core.FixtureIT;
import io.xj.core.access.Access;
import io.xj.core.app.App;
import io.xj.core.dao.SegmentDAO;
import io.xj.core.external.amazon.AmazonProvider;
import io.xj.core.model.Chain;
import io.xj.core.model.ChainBinding;
import io.xj.core.model.ChainState;
import io.xj.core.model.ChainType;
import io.xj.core.model.Segment;
import io.xj.core.model.SegmentState;
import io.xj.core.model.Work;
import io.xj.core.model.WorkType;
import io.xj.craft.CraftModule;
import io.xj.dub.DubModule;
import io.xj.worker.WorkerModule;
import net.greghaines.jesque.worker.JobFactory;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.Mock;
import org.mockito.runners.MockitoJUnitRunner;
import org.mockito.stubbing.Answer;

import java.io.FileInputStream;
import java.io.InputStream;
import java.time.Instant;
import java.util.Collection;
import java.util.UUID;

import static org.junit.Assert.assertTrue;
import static org.mockito.Matchers.any;
import static org.mockito.Matchers.eq;
import static org.mockito.Mockito.atLeast;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@RunWith(MockitoJUnitRunner.class)
public class ComplexLibraryIT extends FixtureIT {
  private static final int MILLIS_PER_SECOND = 1000;
  private static final int MARATHON_NUMBER_OF_SEGMENTS = 7;
  private static final int MAXIMUM_TEST_WAIT_SECONDS = 10 * MARATHON_NUMBER_OF_SEGMENTS;

  long startTime = System.currentTimeMillis();
  @Mock
  AmazonProvider amazonProvider;
  private App app;

  @Before
  public void setUp() throws Exception {
    injector = Guice.createInjector(Modules.override(new CoreModule(), new WorkerModule(), new CraftModule(), new DubModule()).with(
      new AbstractModule() {
        @Override
        public void configure() {
          bind(AmazonProvider.class).toInstance(amazonProvider);
        }
      }));

    // reset to shared fixtures
    reset();
    insertGeneratedFixture(3);

    // Chain "Test Print #1" is ready to begin
    chain1 = insert(Chain.create(account1, "Test Print #1", ChainType.Production, ChainState.Fabricate, Instant.now().minusSeconds(1000), null, null));
    insert(ChainBinding.create(chain1, library1));

    // Config
    System.setProperty("app.port", "9043");
    System.setProperty("audio.file.bucket", "xj-segment-test");
    System.setProperty("segment.file.bucket", "xj-segment-test");
    System.setProperty("work.concurrency", "1");

    // Server App
    app = injector.getInstance(App.class);
    app.configureServer("io.xj.worker");

    // Attach Job Factory to App
    JobFactory jobFactory = injector.getInstance(JobFactory.class);
    app.setJobFactory(jobFactory);
  }

  @After
  public void tearDown() {
    System.clearProperty("app.port");
    System.clearProperty("audio.file.bucket");
    System.clearProperty("segment.file.bucket");
    System.clearProperty("work.concurrency");
  }

  @Test
  public void fabricatesManySegments() throws Exception {
    when(amazonProvider.generateKey(String.format("chains-%s-segments", chain1.getId()), "ogg"))
      .thenReturn("chains-1-segments-12345.ogg");
    when(amazonProvider.streamS3Object(any(), any()))
      .thenAnswer((Answer<InputStream>) invocation -> new FileInputStream(resourceFile("source_audio/kick1.wav")));
    app.getWorkManager().startChainFabrication(chain1.getId());
    assertTrue(hasRemainingWork(WorkType.ChainFabricate));

    // Start app, wait for work, stop app
    app.start();
    int assertShippedSegmentsMinimum = MARATHON_NUMBER_OF_SEGMENTS;
    while (!hasChainAtLeastSegments(chain1.getId(), assertShippedSegmentsMinimum) && isWithinTimeLimit()) {
      Thread.sleep(MILLIS_PER_SECOND);
    }
    app.getWorkManager().stopChainFabrication(chain1.getId());
    app.stop();

    // assertions
    verify(amazonProvider, atLeast(assertShippedSegmentsMinimum))
      .putS3Object(eq("/tmp/chains-1-segments-12345.ogg"), eq("xj-segment-test"), any());
    Collection<Segment> result = injector.getInstance(SegmentDAO.class)
      .readMany(Access.internal(), ImmutableList.of(chain1.getId()));
    assertTrue(assertShippedSegmentsMinimum <= result.size());
  }

  /**
   Whether this test is within the time limit

   @return true if within time limit
   */
  private boolean isWithinTimeLimit() {
    return MAXIMUM_TEST_WAIT_SECONDS * MILLIS_PER_SECOND > System.currentTimeMillis() - startTime;
  }

  /**
   Whether there is active work of a particular type

   @return true if there is work remaining
   */
  private boolean hasRemainingWork(WorkType type) throws Exception {
    int total = 0;
    for (Work work : app.getWorkManager().readAllWork())
      if (type == work.getType()) total++;
    return 0 < total;
  }

  /**
   Does a specified Chain have at least N segments?

   @param chainId   to test
   @param threshold minimum # of segments to qualify
   @return true if has at least N segments
   @throws Exception on failure
   */
  private boolean hasChainAtLeastSegments(UUID chainId, int threshold) throws Exception {
    Collection<Segment> result = injector.getInstance(SegmentDAO.class).readAllInState(Access.internal(), chainId, SegmentState.Dubbed);
    return result.size() >= threshold;
  }


}
