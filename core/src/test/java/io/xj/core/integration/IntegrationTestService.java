// Copyright (c) 2017, Outright Mental Inc. (http://outright.io) All Rights Reserved.
package io.xj.core.integration;

import io.xj.core.CoreModule;
import io.xj.core.app.exception.ConfigException;
import io.xj.core.app.exception.DatabaseException;
import io.xj.core.database.redis.RedisDatabaseProvider;
import io.xj.core.database.sql.impl.SQLConnection;
import io.xj.core.database.sql.SQLDatabaseProvider;
import io.xj.core.migration.MigrationService;

import org.jooq.DSLContext;

import com.google.inject.Guice;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import redis.clients.jedis.Jedis;

public enum IntegrationTestService {
  INSTANCE;
  private Logger log = LoggerFactory.getLogger(IntegrationTestService.class);
  private SQLConnection sqlConnection;
  private Jedis redisConnection;

  IntegrationTestService() {
    log.info("Will prepare integration database.");

    // One database connection remains open until main program exit
    System.setProperty("db.mysql.database", "xj_test");
    System.setProperty("env.test", "true");
    SQLDatabaseProvider dbProvider = Guice.createInjector(new CoreModule())
      .getInstance(SQLDatabaseProvider.class);
    try {
      sqlConnection = dbProvider.getConnection();
    } catch (DatabaseException e) {
      log.error("DatabaseException: " + e);
      System.exit(1);
    }

    // One Redis connection remains open until main program exit
    System.setProperty("work.queue.name", "xj_test");
    RedisDatabaseProvider redisDatabaseProvider = Guice.createInjector(new CoreModule())
      .getInstance(RedisDatabaseProvider.class);
    redisConnection = redisDatabaseProvider.getClient();

    // Shut it down before program exit
    Runtime.getRuntime().addShutdownHook(new Thread(IntegrationTestService::shutdown));

    // Migrate the test database
    try {
      MigrationService.migrate(dbProvider);
    } catch (ConfigException e) {
      log.error("ConfigException: " + e);
      System.exit(1);
    }

    // Like a boy scout
    log.info("Did open master connection and prepare integration database.");
  }

  /**
   Get the master connection to integration database

   @return DSL Context
   */
  public static DSLContext getDb() {
    return INSTANCE.sqlConnection.getContext();
  }

  /**
   * Flush entire Redis contents and database
   */
  public static void flushRedis() {
    INSTANCE.redisConnection.flushAll();
    INSTANCE.redisConnection.flushDB();
    INSTANCE.log.info("Did flush entire Redis contents and database");
  }

  /**
   Runs on program exit
   */
  private static void shutdown() {
    try {
      INSTANCE.sqlConnection.success();
      INSTANCE.redisConnection.close();
      INSTANCE.log.info("Did close master connection to integration database.");
    } catch (DatabaseException e) {
      e.printStackTrace();
    }

    System.clearProperty("work.queue.name");
  }

}