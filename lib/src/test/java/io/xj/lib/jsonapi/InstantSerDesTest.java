// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.

package io.xj.lib.jsonapi;


import io.xj.lib.entity.EntityException;
import io.xj.lib.entity.EntityFactory;
import io.xj.lib.entity.EntityFactoryImpl;
import io.xj.lib.json.JsonProviderImpl;
import org.junit.Before;
import org.junit.Test;

import java.time.Instant;

import static org.junit.Assert.assertEquals;

public class InstantSerDesTest {
  Instant subject;
  String subjectJson;
  EntityFactory entityFactory;

  @Before
  public void setUp() {
    var jsonProvider = new JsonProviderImpl();
    entityFactory = new EntityFactoryImpl(jsonProvider);
    subject = Instant.parse("2014-09-11T12:17:00.679314Z");
    subjectJson = "\"2014-09-11T12:17:00.679314Z\"";
  }

  @Test
  public void serialize() throws EntityException {
    assertEquals(subjectJson, entityFactory.serialize(subject));
  }

  @Test
  public void deserialize() throws EntityException {
    assertEquals(subject, entityFactory.deserialize(Instant.class, subjectJson));
  }

}
