//  Copyright (c) 2020, XJ Music Inc. (https://xj.io) All Rights Reserved.

package io.xj.core.transport;

import com.google.gson.Gson;
import com.google.inject.Guice;
import io.xj.core.CoreModule;
import io.xj.core.exception.CoreException;
import org.junit.Before;
import org.junit.Test;

import java.time.Instant;

import static org.junit.Assert.assertEquals;

public class InstantSerializationTest {
  Gson gson = Guice.createInjector(new CoreModule()).getInstance(GsonProvider.class).gson();
  private Instant subject;
  private String subjectJson;

  @Before
  public void setUp() throws CoreException {
    subject = Instant.parse("2014-09-11T12:17:00.679314Z");
    subjectJson = "\"2014-09-11T12:17:00.679314Z\"";
  }

  @Test
  public void serialize() {
    String result = gson.toJson(subject);

    assertEquals(subjectJson, result);
  }

  @Test
  public void deserialize() {
    Instant result = gson.fromJson(subjectJson, Instant.class);

    assertEquals(subject, result);
  }

}
