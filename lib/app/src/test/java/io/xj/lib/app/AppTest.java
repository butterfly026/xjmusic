// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.

package io.xj.lib.app;

import com.google.common.collect.ImmutableSet;
import com.google.inject.Injector;
import com.typesafe.config.Config;
import com.typesafe.config.ConfigValueFactory;
import org.eclipse.jetty.client.HttpClient;
import org.eclipse.jetty.client.api.ContentResponse;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.junit.MockitoJUnitRunner;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

@RunWith(MockitoJUnitRunner.class)
public class AppTest {
  private App subject;

  @Before
  public void setUp() throws Exception {
    Config config = AppConfiguration.getDefault()
      .withValue("app.port", ConfigValueFactory.fromAnyRef(1903))
      .withValue("prometheus.enabled", ConfigValueFactory.fromAnyRef(true));
    Injector injector = AppConfiguration.inject(config, ImmutableSet.of());
    subject = new App(ImmutableSet.of(), injector, "test");
    subject.start();
  }

  @After
  public void tearDown() {
    subject.stop();
  }

  @Test
  public void checkApp() throws Exception {
    HttpClient client = new HttpClient();
    client.start();

    ContentResponse res = client.GET("http://localhost:1903/o2");

    assertEquals(200, res.getStatus());
    client.stop();

    assertEquals("test", subject.getName());
    assertEquals("primary", subject.fallback("primary", () -> "secondary"));
    assertEquals("secondary", subject.fallback(null, () -> "secondary"));
    assertNotNull(subject.getInetHostname("n/a"));
    assertEquals(1903, subject.getRestPort());
    assertNotNull(subject.getRestHostname());
    subject.setRestPort(125);
    assertEquals(125, subject.getRestPort());
  }
}
