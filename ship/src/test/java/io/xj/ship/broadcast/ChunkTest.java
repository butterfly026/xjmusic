// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.

package io.xj.ship.broadcast;

import com.google.common.collect.ImmutableList;
import com.google.inject.AbstractModule;
import com.google.inject.Guice;
import com.google.inject.util.Modules;
import io.xj.hub.TemplateConfig;
import io.xj.lib.app.Environment;
import io.xj.lib.util.ValueException;
import io.xj.nexus.persistence.ChainManager;
import io.xj.nexus.persistence.ManagerExistenceException;
import io.xj.nexus.persistence.ManagerFatalException;
import io.xj.nexus.persistence.ManagerPrivilegeException;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.Mock;
import org.mockito.junit.MockitoJUnitRunner;

import static io.xj.hub.IntegrationTestingFixtures.*;
import static io.xj.nexus.NexusIntegrationTestingFixtures.buildChain;
import static org.junit.Assert.assertEquals;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.when;

@RunWith(MockitoJUnitRunner.class)
public class ChunkTest {
  private static final String SHIP_KEY = "test63";
  private Chunk subject;

  @Mock
  private ChainManager chainManager;

  @Before
  public void setUp() throws ManagerFatalException, ManagerExistenceException, ManagerPrivilegeException {
    var injector = Guice.createInjector(Modules.override(new BroadcastModule()).with(new AbstractModule() {

      @Override
      protected void configure() {
        bind(Environment.class).toInstance(Environment.getDefault());
        bind(ChainManager.class).toInstance(chainManager);
      }
    }));

    when(chainManager.readOneByShipKey(eq(SHIP_KEY)))
      .thenReturn(buildChain(buildTemplate(buildAccount("Testing"), "Testing")));

    var broadcast = injector.getInstance(BroadcastFactory.class);
    subject = broadcast.chunk(SHIP_KEY, 1513040420);
  }

  @Test
  public void getFromSecondsUTC() {
    assertEquals(1513040420L, (long) subject.getFromSecondsUTC());
  }

  @Test
  public void getShipKey() {
    assertEquals(SHIP_KEY, subject.getShipKey());
  }

  @Test
  public void setState_getState() {
    subject.setState(ChunkState.Done);
    assertEquals(ChunkState.Done, subject.getState());
  }

  @Test
  public void getKey() {
    assertEquals("test63-128k-151304042", subject.getKey(128000));
  }

  @Test
  public void addStreamOutputKey_getStreamOutputKeys() {
    assertEquals(ImmutableList.of("test63-128k-151304042.m4a"),
      subject.addStreamOutputKey("test63-128k-151304042.m4a").getStreamOutputKeys());
  }

  @Test
  public void getConfig() throws ValueException {
    assertEquals(new TemplateConfig(TEST_TEMPLATE_CONFIG).toString(), subject.getTemplateConfig().toString());
  }
}