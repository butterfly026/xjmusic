// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.lib.app;

import com.fasterxml.jackson.jaxrs.json.JacksonJsonProvider;
import com.google.common.collect.ImmutableList;
import com.google.common.collect.ImmutableSet;
import com.google.inject.Injector;
import com.typesafe.config.Config;
import io.prometheus.client.exporter.HTTPServer;
import io.prometheus.client.hotspot.DefaultExports;
import org.eclipse.jetty.server.Server;
import org.eclipse.jetty.servlet.ServletContextHandler;
import org.eclipse.jetty.servlet.ServletHolder;
import org.glassfish.jersey.server.ResourceConfig;
import org.glassfish.jersey.servlet.ServletContainer;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.Collection;
import java.util.Objects;
import java.util.Set;
import java.util.function.Supplier;
import java.util.stream.Collectors;

/**
 Base application for Ocean Backend services.
 Created by Charney Kaye on 2019/11/29
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
 + Perform relational database migration
 - do not start the app if migrations are out of sync
 <p>
 + Configure Jersey server resources
 <p>
 + Call application start()
 - Add shutdown hook that calls application stop()
 */
public class App {
  private static final Logger log = LoggerFactory.getLogger(App.class);
  private static final Collection<String> commonResourcesPackages = ImmutableList.of("io.xj.lib.app");
  //
  private final boolean prometheusEnabled;
  private final int prometheusPort;

  private final ResourceConfig resourceConfig;

  private final String name;
  private final String restHostname;
  private HTTPServer statServer;
  private int restPort;
  private Server resourceServer;
  private boolean started = false;

  public App(
    Set<String> resourcePackages,
    Injector injector,
    String name
  ) {
    this.name = name;

    // Configuration from typesafe config
    Config config = injector.getInstance(Config.class);
    prometheusPort = config.getInt("prometheus.port");
    prometheusEnabled = config.getBoolean("prometheus.enabled");
    restHostname = fallback(System.getenv("FULL_HOSTNAME"), () -> getInetHostname(config.getString("app.hostname")));
    restPort = config.getInt("app.port");

    // Exposes JVM stats to Prometheus
    DefaultExports.initialize();

    // non-static logger for this class, because app must init first
    log.info("{} configured with\n{}", name, toReport(config));

    // resources configuration for jetty/server server
    // This is how we get our Guice Injector available for all JAX-RS resources that want it
    resourceConfig = initJerseyResources(resourcePackages, injector);
  }

  /**
   Format a config into multiline key=value

   @param config to format
   @return multiline formatted config
   */
  private static String toReport(Config config) {
    return String.join("\n",
      ImmutableList.<String>builder().addAll(
        config.entrySet()
          .stream()
          .map(c -> String.format("    %s => %s", c.getKey(), c.getValue()))
          .collect(Collectors.toList()))
        .build());
  }

  /**
   Get the resource configuration, only before the app has been started—
   e.g. in order to register additional filters before starting the app.

   @return resource configuration
   */
  public ResourceConfig getResourceConfig() {
    if (started) log.warn("Should not modify resource configuration after app has started!");
    return resourceConfig;
  }

  /**
   Set the REST port of the application, because individual apps will have their own ports to override the default

   @param restPort to set
   */
  public void setRestPort(int restPort) {
    this.restPort = restPort;
  }

  /**
   Get name of application, probably simple name of main app class, e.g. Hub

   @return name of application
   */
  public String getName() {
    return name;
  }

  /**
   Use value if non-null and 0 < length, else fallback value

   @param value         to use if non-null and 0 < length
   @param fallbackValue to use if value is not null or 0 = length
   @return value if non-null and 0 < length, else fallback value
   */
  protected String fallback(String value, Supplier<String> fallbackValue) {
    if (Objects.nonNull(value) && 0 < value.length()) return value;
    return fallbackValue.get();
  }

  /**
   Get inet hostname value if available, else fallback value

   @param fallbackValue to use if inet hostname is not available
   @return inet hostname value if available, else fallback value
   */
  protected String getInetHostname(String fallbackValue) {
    try {
      return InetAddress.getLocalHost().getHostName();
    } catch (UnknownHostException ignored) {
      return fallbackValue;
    }
  }

  /**
   Scans for all resource classes in package
   Use specified packages plus common resources@param packages to register

   @param addPackages containing JAX-RS resources to serve
   @param injector    to resolve Guice bindings in JAX-RS resource classes
   @return resource configuration
   */
  private ResourceConfig initJerseyResources(Set<String> addPackages, Injector injector) {
    Set<String> packages = ImmutableSet.<String>builder()
      .addAll(commonResourcesPackages)
      .addAll(addPackages)
      .build();

    // scans for all resource classes in packages
    ResourceConfig config = new AppResourceConfig(injector, packages);

    // register jackson json provider
    config.register(JacksonJsonProvider.class);

    packages.forEach(pkg -> log.info("{} will serve resources from package {}", name, pkg));
    return config;
  }

  /**
   Create a Jetty server from the configuration

   @return Jetty server
   */
  private Server startResourceServer() throws AppException {
    ServletContextHandler context = new ServletContextHandler(ServletContextHandler.SESSIONS);
    context.setContextPath("/");

    ServletHolder jerseyServlet = new ServletHolder(new ServletContainer(resourceConfig));

    Server server = new Server(getRestPort());
    server.setHandler(context);
    context.addServlet(jerseyServlet, "/*");

    server.setRequestLog(new AppRequestLogFactory(log).create());

    try {
      server.start();
    } catch (Exception e) {
      throw new AppException("Failed to start resource server", e);
    }
    return server;
  }

  /**
   Register Prometheus exporters and export metrics to a Prometheus HTTPServer.
   See: https://prometheus.io/

   @return Prometheus HTTP Server
   */
  private HTTPServer startStatServer() throws AppException {
    HTTPServer server;
    try {
      server = new HTTPServer(prometheusPort, true);
    } catch (IOException e) {
      throw new AppException("Failed to start stat server", e);
    }
    log.info("{} prometheus metrics available on port {}", name, prometheusPort);
    return server;
  }

  /**
   Starts Jetty HTTP server
   exposing JAX-RS resources defined in this app.
   */
  public void start() throws AppException {
    log.info("{} will start", name);
    started = true;

    // Prometheus stats
    if (prometheusEnabled)
      statServer = startStatServer();

    // Jetty
    resourceServer = startResourceServer();

    log.info("{} did start OK, listening at {}", name, resourceServer.getURI());
  }

  /**
   stop App Server
   */
  public void stop() {
    log.info("{} will stop", name);

    try {
      resourceServer.stop();
      resourceServer.destroy();
    } catch (Exception e) {
      log.error("{} failed to stop resource server", name, e);
    }

    if (Objects.nonNull(statServer)) {
      statServer.stop();
    }

    log.info("{} did stop", name);
  }

  public int getRestPort() {
    return restPort;
  }

  public String getRestHostname() {
    return restHostname;
  }
}
