// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.

package io.xj.ship.broadcast;

import com.google.common.collect.ImmutableMap;
import com.google.inject.AbstractModule;
import com.google.inject.Guice;
import com.google.inject.util.Modules;
import io.xj.lib.app.Environment;
import io.xj.ship.work.ShipWorkModule;
import org.junit.Before;
import org.junit.Test;

import java.io.IOException;

import static io.xj.lib.util.Files.getResourceFileContent;
import static org.junit.Assert.*;

public class M3U8PlaylistManagerImplTest {
  M3U8PlaylistManager subject;

  @Before
  public void setUp() {
    Environment env = Environment.from(ImmutableMap.of("SHIP_KEY", "coolair"));

    var injector = Guice.createInjector(Modules.override(new ShipWorkModule()).with(new AbstractModule() {
      @Override
      protected void configure() {
        bind(Environment.class).toInstance(env);
      }
    }));

    subject = injector.getInstance(M3U8PlaylistManager.class);
  }

  @Test
  public void get() {
    var item = new M3U8PlaylistItem(164030295, 10.0, "coolair-164030295.mp3");

    subject.put(item);
    assertSame(item, subject.get(164030295).orElseThrow());
  }

  /**
   Second attempt returns false (already seen this item)
   */
  @Test
  public void put() {
    var item = new M3U8PlaylistItem(164030295, 10.0, "coolair-164030295.mp3");

    assertTrue(subject.put(item));
    assertFalse(subject.put(item));
  }

  @Test
  public void collectGarbageBefore() {
    var item = new M3U8PlaylistItem(164030295, 10.0, "coolair-164030295.mp3");

    subject.put(item);
    subject.collectGarbageBefore(164030296);
    assertFalse(subject.get(164030295).isPresent());
  }

  @Test
  public void computeMediaSequence() {
    assertEquals(164030295, subject.computeMediaSequence(1640302958444L));
  }

  @Test
  public void loadItemsFromPlaylist_getPlaylistContent() throws IOException {
    var reference_m3u8 = getResourceFileContent("coolair.m3u8");

    var added = subject.parseAndLoadItems(reference_m3u8);
    assertEquals(20, added.size());

    assertEquals(reference_m3u8, subject.getPlaylistContent(164029638));
  }
}
