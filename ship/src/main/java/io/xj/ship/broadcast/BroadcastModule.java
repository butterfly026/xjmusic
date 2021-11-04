// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.

package io.xj.ship.broadcast;

import com.google.inject.AbstractModule;
import com.google.inject.assistedinject.FactoryModuleBuilder;
import io.xj.lib.entity.EntityModule;
import io.xj.lib.filestore.FileStoreModule;
import io.xj.lib.notification.NotificationModule;
import io.xj.nexus.persistence.NexusPersistenceModule;
import io.xj.ship.source.SourceModule;

public class BroadcastModule extends AbstractModule {
  @Override
  protected void configure() {
    bind(ChunkManager.class).to(ChunkManagerImpl.class);
    install(new FactoryModuleBuilder()
      .implement(Chunk.class, Chunk.class)
      .implement(ChunkPrinter.class, ChunkPrinterImpl.class)
      .implement(PlaylistPublisher.class, PlaylistPublisherImpl.class)
      .build(BroadcastFactory.class));
    install(new SourceModule());
    install(new EntityModule());
    install(new NexusPersistenceModule());
    install(new FileStoreModule());
    install(new NotificationModule());
  }
}
