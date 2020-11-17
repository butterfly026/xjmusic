// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.

package io.xj.lib.jsonapi;

import com.google.inject.AbstractModule;
import com.google.inject.Guice;
import com.google.inject.Injector;
import com.typesafe.config.Config;
import com.typesafe.config.ConfigFactory;
import com.typesafe.config.ConfigValueFactory;
import io.xj.Program;
import org.junit.Before;
import org.junit.Test;

import javax.ws.rs.core.NewCookie;
import javax.ws.rs.core.Response;
import java.util.UUID;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;

public class HttpResponseProviderImplTest {
  HttpResponseProvider subject;

  @Before
  public void setUp() {
    Injector injector = Guice.createInjector(new JsonApiModule(), new AbstractModule() {
      @Override
      protected void configure() {
        bind(Config.class).toInstance(ConfigFactory.empty()
          .withValue("app.apiUrl", ConfigValueFactory.fromAnyRef("http://localhost/"))
          .withValue("app.baseUrl", ConfigValueFactory.fromAnyRef("http://localhost/"))
          .withValue("app.host", ConfigValueFactory.fromAnyRef("localhost"))
          .withValue("app.hostname", ConfigValueFactory.fromAnyRef("localhost"))
          .withValue("app.name", ConfigValueFactory.fromAnyRef("testApp"))
          .withValue("api.unauthorizedRedirectPath", ConfigValueFactory.fromAnyRef("unauthorized"))
          .withValue("api.welcomeRedirectPath", ConfigValueFactory.fromAnyRef(""))
          .withValue("audio.baseUrl", ConfigValueFactory.fromAnyRef("http://localhost/"))
          .withValue("player.baseUrl", ConfigValueFactory.fromAnyRef("http://localhost/"))
          .withValue("segment.baseUrl", ConfigValueFactory.fromAnyRef("http://localhost/")));
      }
    });
    subject = injector.getInstance(HttpResponseProvider.class);
  }

  @Test
  public void internalRedirect() {
    Response result = subject.internalRedirect("kingdom-come");

    assertEquals(307, result.getStatus());
    assertEquals("/kingdom-come", result.getLocation().getPath());
  }

  @Test
  public void internalRedirectWithCookie() {
    NewCookie cookie = NewCookie.valueOf("Fun=97");
    Response result = subject.internalRedirectWithCookie("kingdom-come", cookie);

    assertEquals("Fun=97;Version=1", result.getCookies().get("Fun").toString());
  }

  @Test
  public void unauthorized() {
    Response result = subject.unauthorized();

    assertEquals(401, result.getStatus());
  }

  @Test
  public void notFound() {
    Response result = subject.notFound(Program.newBuilder().setId(UUID.randomUUID().toString()));

    assertEquals(404, result.getStatus());
  }

  @Test
  public void failure() {
    Response result = subject.failure(new JsonApiException("Fails"));

    assertEquals(400, result.getStatus());
  }

  @Test
  public void failure_andCode() {
    Response result = subject.failure(Response.Status.NOT_ACCEPTABLE, new JsonApiException("Fails"));

    assertEquals(406, result.getStatus());
  }

  @Test
  public void failure_andCode_serverFailureUnknownException() {
    Response result = subject.failure(Response.Status.NOT_ACCEPTABLE, new Exception("Low Level"));

    assertEquals(406, result.getStatus());
  }

  @Test
  public void failureToCreate() {
    Response result = subject.notAcceptable(new JsonApiException("Fails"));

    assertEquals(406, result.getStatus());
  }

  @Test
  public void failureToUpdate() {
    Response result = subject.notAcceptable(new JsonApiException("Fails"));

    assertEquals(406, result.getStatus());
  }

  @Test
  public void notAcceptable() {
    Response result = subject.notAcceptable("at all");

    assertEquals(406, result.getStatus());
  }

  @Test
  public void noContent() {
    Response result = subject.noContent();

    assertEquals(204, result.getStatus());
    assertFalse(result.hasEntity());
  }


}
