// Copyright (c) 2017, Outright Mental Inc. (http://outright.io) All Rights Reserved.
package io.xj.core.resource;

import io.xj.core.CoreModule;
import io.xj.core.app.App;

import com.google.inject.Guice;
import com.google.inject.Injector;

import org.junit.After;
import org.junit.Before;
import org.mockito.Mockito;

import javax.ws.rs.client.Client;
import javax.ws.rs.client.ClientBuilder;
import javax.ws.rs.client.WebTarget;
import java.io.File;
import java.io.IOException;

/**
 THIS CLASS IS NOT ACTUALLY IN USE, UNTIL WE IMPLEMENT [#225] Jersey JAX-RS resource tests mock external dependencies, in order to ensure specific conditions.
 */
public class ResourceEndpointTest extends Mockito {
  private App app;
  private WebTarget target;
  private File tempFile;
  private Injector injector = Guice.createInjector(new CoreModule());

  @Before
  public void before() throws Exception {
    // tempFile file for access log
    try {
      tempFile = File.createTempFile("access-log-", ".tmp");
    } catch (IOException e) {
      e.printStackTrace();
    }

    // start the server
    System.setProperty("app.port", "8001");
    System.setProperty("log.access.filename", tempFile.getAbsolutePath());

    app = injector.getInstance(App.class);
    app.configureServer(packages());
    app.start();

    // get the client
    Client c = ClientBuilder.newClient();

    // uncomment the following line if you want to enable
    // support for JSON in the client (you also have to uncomment
    // dependency on jersey-media-json module in pom.xml and Main.startServer())
    // --
    // c.configuration().enable(new org.glassfish.jersey.media.json.JsonJaxbFeature());

    target = c.target(app.baseURI());
    System.out.println("[TEST] target baseURI: " + app.baseURI());
  }

  @After
  public void after() throws Exception {
    app.stop();
    System.clearProperty("app.port");
    System.clearProperty("log.access.filename");
  }

  protected WebTarget target() {
    return target;
  }

  protected String[] packages() {
    return new String[0];
  }
}