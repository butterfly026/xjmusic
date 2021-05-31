// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.

package io.xj.nexus.work;

import com.google.common.collect.ImmutableSet;
import com.google.inject.AbstractModule;
import com.google.inject.util.Modules;
import com.typesafe.config.Config;
import com.typesafe.config.ConfigValueFactory;
import io.xj.Account;
import io.xj.Chain;
import io.xj.lib.app.AppConfiguration;
import io.xj.lib.app.AppException;
import io.xj.lib.entity.EntityFactory;
import io.xj.lib.entity.common.Topology;
import io.xj.lib.filestore.FileStoreProvider;
import io.xj.nexus.testing.NexusTestConfiguration;
import io.xj.nexus.persistence.NexusEntityStore;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.Mock;
import org.mockito.runners.MockitoJUnitRunner;

import java.util.UUID;

import static org.mockito.Mockito.atLeastOnce;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@RunWith(MockitoJUnitRunner.class)
public class NexusWorkImplTest {
  private NexusEntityStore store;
  private NexusWork subject;

  @Mock
  public FileStoreProvider fileStoreProvider;

  @Mock
  public WorkerFactory workerFactory;

  @Mock
  private BossWorker fakeBossWorker;

  @Mock
  private JanitorWorker fakeJanitorWorker;

  @Mock
  private MedicWorker fakeMedicWorker;

  @Before
  public void setUp() throws AppException {
    Config config = NexusTestConfiguration.getDefault()
            .withValue("app.port", ConfigValueFactory.fromAnyRef(9043))
            .withValue("work.bossDelayMillis", ConfigValueFactory.fromAnyRef(1))
            .withValue("work.janitorDelayMillis", ConfigValueFactory.fromAnyRef(1))
            .withValue("work.medicDelayMillis", ConfigValueFactory.fromAnyRef(1))
            .withValue("work.chainDelayMillis", ConfigValueFactory.fromAnyRef(1))
            .withValue("work.concurrency", ConfigValueFactory.fromAnyRef(1));

    var injector = AppConfiguration.inject(config,
            ImmutableSet.of(Modules.override(new NexusWorkModule()).with(
                    new AbstractModule() {
                      @Override
                      public void configure() {
                        bind(Config.class).toInstance(config);
                        bind(WorkerFactory.class).toInstance(workerFactory);
                        bind(FileStoreProvider.class).toInstance(fileStoreProvider);
                      }
                    })));
    var entityFactory = injector.getInstance(EntityFactory.class);
    store = injector.getInstance(NexusEntityStore.class);
    Topology.buildHubApiTopology(entityFactory);
    Topology.buildNexusApiTopology(entityFactory);

    subject = injector.getInstance(NexusWork.class);
  }

  @Test
  public void fabricatesSegments() throws Exception {
    var account1 = Account.newBuilder()
            .setId(UUID.randomUUID().toString())
            .setName("palm tree")
            .build();
    var chain1 = store.put(Chain.newBuilder()
            .setId(UUID.randomUUID().toString())
            .setAccountId(account1.getId())
            .setName("Test Print #1")
            .setType(Chain.Type.Production)
            .setState(Chain.State.Fabricate)
            .setStartAt("2014-08-12T12:17:02.527142Z")
            .build());

    when(fileStoreProvider.generateKey(String.format("chains-%s-segments", chain1.getId())))
            .thenReturn("chains-1-segments-12345.aac");
    when(workerFactory.boss()).thenReturn(fakeBossWorker);
    when(workerFactory.janitor()).thenReturn(fakeJanitorWorker);
    when(workerFactory.medic()).thenReturn(fakeMedicWorker);

    // Start app, wait for work, stop app
    subject.start();
    Thread.sleep(10); // everybody's cycles are 1ms so 10ms should be enough to trigger everything once
    subject.finish();

    // assertions
    verify(fakeBossWorker, atLeastOnce()).run();
    verify(fakeJanitorWorker, atLeastOnce()).run();
    verify(fakeMedicWorker, atLeastOnce()).run();
  }
}