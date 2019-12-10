// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.service.worker;

import com.google.inject.AbstractModule;
import com.google.inject.assistedinject.FactoryModuleBuilder;
import net.greghaines.jesque.worker.JobFactory;

public class WorkerModule extends AbstractModule {
  protected void configure() {
    bind(JobFactory.class).to(JobSourceFactory.class);
    install(new FactoryModuleBuilder()
      .implement(ChainEraseJob.class, ChainEraseJobImpl.class)
      .implement(ChainFabricateJob.class, ChainFabricateJobImpl.class)
      .implement(SegmentFabricateJob.class, SegmentFabricateJobImpl.class)
      .build(JobTargetFactory.class));
  }
}
