package io.xj.ship.broadcast;

import com.google.inject.AbstractModule;
import com.google.inject.Guice;
import com.google.inject.util.Modules;
import io.xj.lib.app.Environment;
import io.xj.lib.util.ValueException;
import io.xj.ship.ShipException;
import io.xj.ship.source.SegmentAudioManager;
import io.xj.ship.work.ShipWorkModule;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.Mock;
import org.mockito.junit.MockitoJUnitRunner;

import java.io.IOException;
import java.util.List;

import static io.xj.lib.util.Files.getResourceFileContent;
import static org.junit.Assert.assertEquals;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.when;

@RunWith(MockitoJUnitRunner.class)
public class PlaylistProviderImplTest {
  // Under Test
  private PlaylistProvider subject;

  // Fixtures
  private static final String SHIP_TITLE = "Test Stream 5";
  private static final String SHIP_SOURCE = "XJ Music Testing";
  private static final String SHIP_KEY = "test5";
  private Chunk chunk0;

  @Mock
  private ChunkManager chunkManager;

  @Mock
  private SegmentAudioManager segmentAudioManager;

  @Before
  public void setUp() {
    var env = Environment.getDefault();
    var injector = Guice.createInjector(Modules.override(new ShipWorkModule()).with(new AbstractModule() {
      @Override
      protected void configure() {
        bind(ChunkManager.class).toInstance(chunkManager);
        bind(Environment.class).toInstance(env);
        bind(SegmentAudioManager.class).toInstance(segmentAudioManager);
      }
    }));

    chunk0 = injector.getInstance(ShipBroadcastFactory.class)
      .chunk(SHIP_KEY, 1513040420).setState(ChunkState.Done).addStreamOutputKey("test5-128000-151304042.m4a");

    subject = injector.getInstance(PlaylistProvider.class);
  }

  @Test
  public void computeMpdXML() throws IOException, ShipException, ValueException {
    when(chunkManager.getAll(eq(SHIP_KEY), eq(1513040450000L))).thenReturn(List.of(chunk0));
    when(chunkManager.computeFromSecondUTC(eq(1513040450000L))).thenReturn(1513040450L);
    when(chunkManager.getContiguousDone(eq(SHIP_KEY), eq(1513040450000L))).thenReturn(List.of(chunk0));

    var result = subject.computeMpdXML(SHIP_KEY, SHIP_TITLE, SHIP_SOURCE, 1513040450000L);

    assertMatchesResourceFile(result, "mpeg_dash_playlist/test5.mpd");
  }

  /**
   * Assert this matches the reference file
   *
   * @param content           to test
   * @param referenceFilePath to reference
   * @throws IOException on failure
   */
  @SuppressWarnings("SameParameterValue")
  private void assertMatchesResourceFile(String content, String referenceFilePath) throws IOException {
    assertEquals("Demo output (" + content.length() + " bytes) does not match reference file " + referenceFilePath + "!",
      getResourceFileContent(referenceFilePath), content);
  }
}
