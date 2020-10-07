// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.service.hub;

import com.google.inject.Injector;
import com.typesafe.config.Config;
import io.xj.lib.app.App;
import io.xj.lib.app.AppException;
import io.xj.lib.entity.EntityFactory;
import io.xj.lib.jsonapi.ApiUrlProvider;
import io.xj.lib.util.TempFile;
import io.xj.lib.util.Text;
import io.xj.service.hub.access.HubAccessControlProvider;
import io.xj.service.hub.access.HubAccessLogFilter;
import io.xj.service.hub.access.HubAccessTokenAuthFilter;
import io.xj.service.hub.entity.Account;
import io.xj.service.hub.entity.AccountUser;
import io.xj.service.hub.entity.Instrument;
import io.xj.service.hub.entity.InstrumentAudio;
import io.xj.service.hub.entity.InstrumentAudioChord;
import io.xj.service.hub.entity.InstrumentAudioEvent;
import io.xj.service.hub.entity.InstrumentMeme;
import io.xj.service.hub.entity.Library;
import io.xj.service.hub.entity.Program;
import io.xj.service.hub.entity.ProgramMeme;
import io.xj.service.hub.entity.ProgramSequence;
import io.xj.service.hub.entity.ProgramSequenceBinding;
import io.xj.service.hub.entity.ProgramSequenceBindingMeme;
import io.xj.service.hub.entity.ProgramSequenceChord;
import io.xj.service.hub.entity.ProgramSequencePattern;
import io.xj.service.hub.entity.ProgramSequencePatternEvent;
import io.xj.service.hub.entity.ProgramVoice;
import io.xj.service.hub.entity.ProgramVoiceTrack;
import io.xj.service.hub.entity.User;
import io.xj.service.hub.entity.UserAuth;
import io.xj.service.hub.entity.UserAuthToken;
import io.xj.service.hub.entity.UserRole;
import io.xj.service.hub.persistence.HubDatabaseProvider;
import io.xj.service.hub.persistence.HubMigration;
import io.xj.service.hub.persistence.HubPersistenceException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.File;
import java.util.Collections;

/**
 Base application for XJ services.
 <p>
 USAGE
 <p>
 + Create a Guice injector that will be used throughout the entire application, by means of:
 - Creating an application with new App(pathToConfigFile, resourcePackages, injector) <-- pass in Guice injector
 - Making that injector available to Jersey2-based resources for their injection
 - Ensuring all classes within the application are injected via their constructors (NOT creating another injector)
 - ensuring all classes rely on factory and provider modules (NOT creating another injector)
 <p>
 + Accept one runtime argument, pointing to the location of a TypeSafe config
 - ingest that configuration and make it available throughout the application
 <p>
 + Configure Jersey server resources
 <p>
 + Call application start()
 - Add shutdown hook that calls application stop()
 */
public class HubApp extends App {
  private final Logger log = LoggerFactory.getLogger(HubApp.class);
  private final String platformRelease;
  private final Injector injector;
  private final HubDatabaseProvider hubDatabaseProvider;

  /**
   Construct a new application by providing
   - a config,
   - a set of resource packages to add to the core set, and
   - an injector to create a child injector of in order to add the core set.@param resourcePackages to add to the core set of packages for the new application@param resourcePackages@param injector to add to the core set of modules for the new application
   */
  public HubApp(
    Injector injector
  ) {
    super(injector, Collections.singleton("io.xj.service.hub.api"));

    // Injection
    this.injector = injector;
    hubDatabaseProvider = injector.getInstance(HubDatabaseProvider.class);
    Config config = injector.getInstance(Config.class);

    // Configuration
    platformRelease = config.getString("platform.release");

    // Non-static logger for this class, because app must init first
    log.info("{} configuration:\n{}", getName(), Text.toReport(config));

    // Setup Entity topology
    buildApiTopology(injector.getInstance(EntityFactory.class));

    // Configure REST API url provider
    ApiUrlProvider.configureApiUrls(config, injector.getInstance(ApiUrlProvider.class));

    // Register JAX-RS filter for access log only registers if file succeeds to open for writing
    String pathToWriteAccessLog = config.hasPath("app.accessLogFile") ?
      config.getString("app.accessLogFile") :
      String.format("%s%s-access.log", TempFile.getTempFilePathPrefix(), File.separator);
    new HubAccessLogFilter(pathToWriteAccessLog).registerTo(getResourceConfig());

    // Register JAX-RS filter for reading access control token
    HubAccessControlProvider hubAccessControlProvider = injector.getInstance(HubAccessControlProvider.class);
    getResourceConfig().register(new HubAccessTokenAuthFilter(hubAccessControlProvider,
      config.getString("access.tokenName"))); }

  /**
   Given a entity factory, build the Hub REST API entity topology

   @param entityFactory to build topology on
   */
  public static void buildApiTopology(EntityFactory entityFactory) {
    // Account
    entityFactory.register(Account.class)
      .createdBy(Account::new)
      .withAttribute("name")
      .hasMany(Library.class)
      .hasMany(AccountUser.class);

    // AccountUser
    entityFactory.register(AccountUser.class)
      .createdBy(AccountUser::new)
      .belongsTo(Account.class)
      .belongsTo(User.class);

    // Instrument
    entityFactory.register(Instrument.class)
      .createdBy(Instrument::new)
      .withAttribute("state")
      .withAttribute("type")
      .withAttribute("name")
      .withAttribute("density")
      .belongsTo(User.class)
      .belongsTo(Library.class)
      .hasMany(InstrumentAudio.class)
      .hasMany(InstrumentMeme.class);

    // InstrumentAudio
    entityFactory.register(InstrumentAudio.class)
      .createdBy(InstrumentAudio::new)
      .withAttribute("waveformKey")
      .withAttribute("name")
      .withAttribute("start")
      .withAttribute("length")
      .withAttribute("tempo")
      .withAttribute("pitch")
      .withAttribute("density")
      .belongsTo(Instrument.class)
      .hasMany(InstrumentAudioChord.class)
      .hasMany(InstrumentAudioEvent.class);

    // InstrumentAudioChord
    entityFactory.register(InstrumentAudioChord.class)
      .createdBy(InstrumentAudioChord::new)
      .withAttribute("name")
      .withAttribute("position")
      .belongsTo(Instrument.class)
      .belongsTo(InstrumentAudio.class);

    // InstrumentAudioEvent
    entityFactory.register(InstrumentAudioEvent.class)
      .createdBy(InstrumentAudioEvent::new)
      .withAttribute("duration")
      .withAttribute("note")
      .withAttribute("position")
      .withAttribute("velocity")
      .withAttribute("name")
      .belongsTo(Instrument.class)
      .belongsTo(InstrumentAudio.class);

    // InstrumentMeme
    entityFactory.register(InstrumentMeme.class)
      .createdBy(InstrumentMeme::new)
      .withAttribute("name")
      .belongsTo(Instrument.class);

    // Library
    entityFactory.register(Library.class)
      .createdBy(Library::new)
      .withAttribute("name")
      .belongsTo(Account.class)
      .hasMany(Instrument.class)
      .hasMany(Program.class);

    // Program
    entityFactory.register(Program.class)
      .createdBy(Program::new)
      .withAttribute("state")
      .withAttribute("key")
      .withAttribute("tempo")
      .withAttribute("type")
      .withAttribute("name")
      .withAttribute("density")
      .belongsTo(User.class)
      .belongsTo(Library.class)
      .hasMany(ProgramMeme.class)
      .hasMany(ProgramSequence.class)
      .hasMany(ProgramSequenceChord.class)
      .hasMany(ProgramSequencePattern.class)
      .hasMany(ProgramVoiceTrack.class)
      .hasMany(ProgramSequencePatternEvent.class)
      .hasMany(ProgramSequenceBinding.class)
      .hasMany(ProgramSequenceBindingMeme.class)
      .hasMany(ProgramVoice.class);

    // ProgramMeme
    entityFactory.register(ProgramMeme.class)
      .createdBy(ProgramMeme::new)
      .withAttribute("name")
      .belongsTo(Program.class);

    // ProgramSequence
    entityFactory.register(ProgramSequence.class)
      .createdBy(ProgramSequence::new)
      .withAttribute("name")
      .withAttribute("key")
      .withAttribute("density")
      .withAttribute("total")
      .withAttribute("tempo")
      .belongsTo(Program.class)
      .hasMany(ProgramSequencePattern.class)
      .hasMany(ProgramSequenceBinding.class)
      .hasMany(ProgramSequenceChord.class);

    // ProgramSequenceBinding
    entityFactory.register(ProgramSequenceBinding.class)
      .createdBy(ProgramSequenceBinding::new)
      .withAttribute("offset")
      .belongsTo(Program.class)
      .belongsTo(ProgramSequence.class)
      .hasMany(ProgramSequenceBindingMeme.class);

    // ProgramSequenceBindingMeme
    entityFactory.register(ProgramSequenceBindingMeme.class)
      .createdBy(ProgramSequenceBindingMeme::new)
      .withAttribute("name")
      .belongsTo(Program.class)
      .belongsTo(ProgramSequenceBinding.class);

    // ProgramSequenceChord
    entityFactory.register(ProgramSequenceChord.class)
      .createdBy(ProgramSequenceChord::new)
      .withAttribute("name")
      .withAttribute("position")
      .belongsTo(Program.class)
      .belongsTo(ProgramSequence.class);

    // ProgramSequencePattern
    entityFactory.register(ProgramSequencePattern.class)
      .createdBy(ProgramSequencePattern::new)
      .withAttribute("type")
      .withAttribute("total")
      .withAttribute("name")
      .belongsTo(Program.class)
      .belongsTo(ProgramSequence.class)
      .belongsTo(ProgramVoice.class)
      .hasMany(ProgramSequencePatternEvent.class);

    // ProgramSequencePatternEvent
    entityFactory.register(ProgramSequencePatternEvent.class)
      .createdBy(ProgramSequencePatternEvent::new)
      .withAttribute("duration")
      .withAttribute("note")
      .withAttribute("position")
      .withAttribute("velocity")
      .belongsTo(Program.class)
      .belongsTo(ProgramSequencePattern.class)
      .belongsTo(ProgramVoiceTrack.class);

    // ProgramVoice
    entityFactory.register(ProgramVoice.class)
      .createdBy(ProgramVoice::new)
      .withAttribute("type")
      .withAttribute("name")
      .withAttribute("order")
      .belongsTo(Program.class)
      .hasMany(ProgramSequencePattern.class);

    // ProgramVoiceTrack
    entityFactory.register(ProgramVoiceTrack.class)
      .createdBy(ProgramVoiceTrack::new)
      .withAttribute("name")
      .withAttribute("order")
      .belongsTo(Program.class)
      .belongsTo(ProgramVoice.class)
      .hasMany(ProgramSequencePatternEvent.class);

    // User
    entityFactory.register(User.class)
      .createdBy(User::new)
      .withAttribute("name")
      .withAttribute("roles")
      .withAttribute("email")
      .withAttribute("avatarUrl")
      .hasMany(UserAuth.class)
      .hasMany(UserAuthToken.class);

    // UserAuth
    entityFactory.register(UserAuth.class)
      .createdBy(UserAuth::new)
      .withAttribute("type")
      .withAttribute("externalAccessToken")
      .withAttribute("externalRefreshToken")
      .withAttribute("externalAccount")
      .belongsTo(User.class);

    // UserAuthToken
    entityFactory.register(UserAuthToken.class)
      .createdBy(UserAuthToken::new)
      .withAttribute("accessToken")
      .belongsTo(User.class)
      .belongsTo(UserAuth.class);

    // UserRole
    entityFactory.register(UserRole.class)
      .createdBy(UserRole::new)
      .withAttribute("type")
      .belongsTo(User.class);
  }

  /**
   Starts Grizzly HTTP server
   exposing JAX-RS resources defined in this app.
   */
  public void start() throws AppException {
    // start the underlying app
    super.start();
    log.info("{} ({}) is up at {}}", getName(), platformRelease, getBaseURI());
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
    log.info("{} SQL database connection pool did shutdown OK", getName());
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
      injector.getInstance(HubMigration.class).migrate();
    } catch (HubPersistenceException e) {
      System.out.println(String.format("Migrations failed! HubApp will not start. %s: %s\n%s", e.getClass().getSimpleName(), e.getMessage(), Text.formatStackTrace(e)));
      System.exit(1);
    }
  }

}
