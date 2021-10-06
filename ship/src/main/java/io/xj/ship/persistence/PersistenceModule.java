package io.xj.ship.persistence;

import com.google.inject.AbstractModule;
import io.xj.lib.entity.EntityModule;
import io.xj.lib.filestore.FileStoreModule;
import io.xj.lib.notification.NotificationModule;
import io.xj.nexus.persistence.NexusPersistenceModule;
import io.xj.nexus.persistence.SegmentManager;
import io.xj.nexus.persistence.SegmentManagerImpl;

public class PersistenceModule extends AbstractModule {
  @Override
  protected void configure() {
    bind(ChunkManager.class).to(ChunkManagerImpl.class);
    bind(SegmentManager.class).to(SegmentManagerImpl.class);
    bind(SegmentAudioManager.class).to(SegmentAudioManagerImpl.class);
    install(new EntityModule());
    install(new NexusPersistenceModule());
    install(new FileStoreModule());
    install(new NotificationModule());
  }
}

