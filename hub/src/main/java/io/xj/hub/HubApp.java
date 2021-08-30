// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.hub;

import com.google.inject.Inject;
import com.typesafe.config.Config;
import io.xj.hub.access.HubAccessControlProvider;
import io.xj.hub.access.HubAccessLogFilter;
import io.xj.hub.access.HubAccessTokenAuthFilter;
import io.xj.hub.api.AccountEndpoint;
import io.xj.hub.api.AccountUserEndpoint;
import io.xj.hub.api.AuthEndpoint;
import io.xj.hub.api.ConfigEndpoint;
import io.xj.hub.api.HealthEndpoint;
import io.xj.hub.api.IngestEndpoint;
import io.xj.hub.api.InstrumentAudioEndpoint;
import io.xj.hub.api.InstrumentEndpoint;
import io.xj.hub.api.InstrumentMemeEndpoint;
import io.xj.hub.api.LibraryEndpoint;
import io.xj.hub.api.ProgramEndpoint;
import io.xj.hub.api.ProgramMemeEndpoint;
import io.xj.hub.api.ProgramSequenceBindingEndpoint;
import io.xj.hub.api.ProgramSequenceBindingMemeEndpoint;
import io.xj.hub.api.ProgramSequenceChordEndpoint;
import io.xj.hub.api.ProgramSequenceChordVoicingEndpoint;
import io.xj.hub.api.ProgramSequenceEndpoint;
import io.xj.hub.api.ProgramSequencePatternEndpoint;
import io.xj.hub.api.ProgramSequencePatternEventEndpoint;
import io.xj.hub.api.ProgramVoiceEndpoint;
import io.xj.hub.api.ProgramVoiceTrackEndpoint;
import io.xj.hub.api.TemplateBindingEndpoint;
import io.xj.hub.api.TemplateEndpoint;
import io.xj.hub.api.TemplatePlaybackEndpoint;
import io.xj.hub.api.UserEndpoint;
import io.xj.hub.persistence.HubDatabaseProvider;
import io.xj.hub.persistence.HubMigration;
import io.xj.hub.persistence.HubPersistenceException;
import io.xj.lib.app.App;
import io.xj.lib.app.AppException;
import io.xj.lib.app.Environment;
import io.xj.lib.entity.EntityFactory;
import io.xj.lib.entity.common.Topology;
import io.xj.lib.util.TempFile;
import io.xj.lib.util.Text;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.File;

public class HubApp extends App {
  private final Logger log = LoggerFactory.getLogger(HubApp.class);
  private final String platformRelease;
  private final HubDatabaseProvider hubDatabaseProvider;
  private final HubMigration hubMigration;

  @Inject
  public HubApp(
    Config config,
    EntityFactory entityFactory,
    Environment env,
    HubAccessControlProvider hubAccessControlProvider,
    HubDatabaseProvider hubDatabaseProvider,
    HubMigration hubMigration,
    AccountEndpoint accountEndpoint,
    AccountUserEndpoint accountUserEndpoint,
    AuthEndpoint authEndpoint,
    ConfigEndpoint configEndpoint,
    HealthEndpoint healthEndpoint,
    IngestEndpoint ingestEndpoint,
    InstrumentAudioEndpoint instrumentAudioEndpoint,
    InstrumentEndpoint instrumentEndpoint,
    InstrumentMemeEndpoint instrumentMemeEndpoint,
    LibraryEndpoint libraryEndpoint,
    ProgramEndpoint programEndpoint,
    ProgramMemeEndpoint programMemeEndpoint,
    ProgramSequenceBindingEndpoint programSequenceBindingEndpoint,
    ProgramSequenceBindingMemeEndpoint programSequenceBindingMemeEndpoint,
    ProgramSequenceChordEndpoint programSequenceChordEndpoint,
    ProgramSequenceChordVoicingEndpoint programSequenceChordVoicingEndpoint,
    ProgramSequenceEndpoint programSequenceEndpoint,
    ProgramSequencePatternEndpoint programSequencePatternEndpoint,
    ProgramSequencePatternEventEndpoint programSequencePatternEventEndpoint,
    ProgramVoiceEndpoint programVoiceEndpoint,
    ProgramVoiceTrackEndpoint programVoiceTrackEndpoint,
    TemplateEndpoint templateEndpoint,
    TemplateBindingEndpoint templateBindingEndpoint,
    TemplatePlaybackEndpoint templatePlaybackEndpoint,
    UserEndpoint userEndpoint
  ) {
    super(config, env);

    getResourceConfig().register(accountEndpoint);
    getResourceConfig().register(accountUserEndpoint);
    getResourceConfig().register(authEndpoint);
    getResourceConfig().register(configEndpoint);
    getResourceConfig().register(healthEndpoint);
    getResourceConfig().register(ingestEndpoint);
    getResourceConfig().register(instrumentAudioEndpoint);
    getResourceConfig().register(instrumentEndpoint);
    getResourceConfig().register(instrumentMemeEndpoint);
    getResourceConfig().register(libraryEndpoint);
    getResourceConfig().register(programEndpoint);
    getResourceConfig().register(programMemeEndpoint);
    getResourceConfig().register(programSequenceBindingEndpoint);
    getResourceConfig().register(programSequenceBindingMemeEndpoint);
    getResourceConfig().register(programSequenceChordEndpoint);
    getResourceConfig().register(programSequenceChordVoicingEndpoint);
    getResourceConfig().register(programSequenceEndpoint);
    getResourceConfig().register(programSequencePatternEndpoint);
    getResourceConfig().register(programSequencePatternEventEndpoint);
    getResourceConfig().register(programVoiceEndpoint);
    getResourceConfig().register(programVoiceTrackEndpoint);
    getResourceConfig().register(templateEndpoint);
    getResourceConfig().register(templateBindingEndpoint);
    getResourceConfig().register(templatePlaybackEndpoint);
    getResourceConfig().register(userEndpoint);

    // Configuration
    platformRelease = env.getPlatformEnvironment();
    this.hubDatabaseProvider = hubDatabaseProvider;
    this.hubMigration = hubMigration;

    // Non-static logger for this class, because app must init first
    log.info("{} configuration:\n{}", getName(), Text.toReport(config));

    // Setup Entity topology
    Topology.buildHubApiTopology(entityFactory);

    // Register JAX-RS filter for access log only registers if file succeeds to open for writing
    String pathToWriteAccessLog = 0 < env.getAccessLogFilename().length() ?
      env.getAccessLogFilename() :
      TempFile.getTempFilePathPrefix() + File.separator + env.getAccessLogFilename();
    new HubAccessLogFilter(pathToWriteAccessLog).registerTo(getResourceConfig());

    // Register JAX-RS filter for reading access control token
    getResourceConfig().register(new HubAccessTokenAuthFilter(hubAccessControlProvider, env.getAccessTokenName()));
  }

  /**
   Starts Grizzly HTTP server
   exposing JAX-RS resources defined in this app.
   */
  public void start() throws AppException {
    // start the underlying app
    super.start();
    log.info("{} ({}) is up and running at {}}", getName(), platformRelease, getBaseURI());
  }

  /**
   stop App Server
   */
  public void finish() {
    // stop the underlying app
    super.finish();
    log.info("{} ({}}) did exit OK at {}", getName(), platformRelease, getBaseURI());

    // shutdown SQL database connection pool
    hubDatabaseProvider.shutdown();
    log.debug("{} SQL database connection pool did shutdown OK", getName());
  }

  /**
   Get base URI

   @return base URI
   */
  public String getBaseURI() {
    return "http://" + getRestHostname() + ":" + getRestPort() + "/";
  }

  /**
   Run database migrations
   */
  public void migrate() {
    // Database migrations
    try {
      hubMigration.migrate();
    } catch (HubPersistenceException e) {
      System.out.printf("Migrations failed! HubApp will not start. %s: %s\n%s%n", e.getClass().getSimpleName(), e.getMessage(), Text.formatStackTrace(e));
      System.exit(1);
    }
  }

}