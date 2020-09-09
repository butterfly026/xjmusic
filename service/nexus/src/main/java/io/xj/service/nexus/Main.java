// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.service.nexus;

import com.google.common.collect.ImmutableSet;
import com.google.inject.Module;
import com.typesafe.config.Config;
import com.typesafe.config.ConfigValueFactory;
import io.xj.lib.app.AppConfiguration;
import io.xj.lib.app.AppException;
import io.xj.lib.filestore.FileStoreModule;
import io.xj.lib.jsonapi.JsonApiModule;
import io.xj.lib.mixer.MixerModule;
import io.xj.service.hub.client.HubClientModule;
import io.xj.service.nexus.craft.CraftModule;
import io.xj.service.nexus.dao.NexusDAOModule;
import io.xj.service.nexus.dub.DubModule;
import io.xj.service.nexus.fabricator.NexusFabricatorModule;
import io.xj.service.nexus.persistence.NexusEntityStoreModule;
import io.xj.service.nexus.work.NexusWorkModule;

import java.util.Set;

/**
 Nexus service
 */
public interface Main {
  Set<Module> injectorModules = ImmutableSet.of(
    new CraftModule(),
    new HubClientModule(),
    new NexusDAOModule(),
    new DubModule(),
    new NexusFabricatorModule(),
    new FileStoreModule(),
    new JsonApiModule(),
    new MixerModule(),
    new NexusEntityStoreModule(),
    new NexusWorkModule()
  );
  Set<String> resourcePackages = ImmutableSet.of("io.xj.service.nexus.api");
  int defaultPort = 8042;

  /**
   Main method.

   @param args arguments-- the first argument must be the path to the configuration file
   */
  static void main(String[] args) throws AppException {
    // Get default configuration
    Config defaults = AppConfiguration.getDefault()
      .withValue("app.port", ConfigValueFactory.fromAnyRef(defaultPort));

    // Read configuration from arguments to program, with default fallbacks
    Config config = AppConfiguration.parseArgs(args, defaults);

    // Instantiate app
    NexusApp app = new NexusApp(resourcePackages, AppConfiguration.inject(config, injectorModules));

    // Shutdown Hook
    Runtime.getRuntime().addShutdownHook(new Thread(app::finish));

    // start
    app.start();
  }
}
