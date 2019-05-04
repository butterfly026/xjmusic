//  Copyright (c) 2019, XJ Music Inc. (https://xj.io) All Rights Reserved.

package io.xj.core.model.segment_chord;

import com.google.gson.Gson;
import com.google.inject.Guice;
import io.xj.core.CoreModule;
import io.xj.core.transport.GsonProvider;
import org.junit.Before;
import org.junit.Test;

import java.math.BigInteger;
import java.util.UUID;

import static org.junit.Assert.assertEquals;

/**
 [#166132897] Segment model handles all of its own entities
 [#166273140] Segment Child Entities are identified and related by UUID (not id)
 */
public class SegmentChordSerializationTest {
  Gson gson = Guice.createInjector(new CoreModule()).getInstance(GsonProvider.class).gson();
  private SegmentChord subject;
  private String subjectJson;

  private static void assertEquivalent(SegmentChord c1, SegmentChord c2) {
    assertEquals(c1.getPosition(), c2.getPosition());
    assertEquals(c1.getSegmentId(), c2.getSegmentId());
    assertEquals(c1.getName(), c2.getName());
    assertEquals(c1.getUuid(), c2.getUuid());
  }

  @Before
  public void setUp() {
    subject = new SegmentChord()
      .setPosition(1.5)
      .setSegmentId(BigInteger.valueOf(982))
      .setName("C#7 min")
      .setUuid(UUID.fromString("12345678-9a75-48b0-9aa0-86409121465a"));
    subjectJson = "{\"uuid\":\"12345678-9a75-48b0-9aa0-86409121465a\",\"name\":\"C#7 min\",\"position\":1.5,\"segmentId\":982}";
  }

  @Test
  public void serialize() {
    String result = gson.toJson(subject);

    assertEquals(subjectJson, result);
  }

  @Test
  public void deserialize() {
    SegmentChord result = gson.fromJson(subjectJson, SegmentChord.class);

    assertEquivalent(subject, result);
  }

}
