// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.

package io.xj.ship.source;

import com.google.inject.Guice;
import io.xj.api.*;
import io.xj.hub.enums.TemplateType;
import org.junit.Before;
import org.junit.Test;

import java.time.Instant;

import static io.xj.hub.IntegrationTestingFixtures.buildAccount;
import static io.xj.hub.IntegrationTestingFixtures.buildTemplate;
import static io.xj.nexus.NexusIntegrationTestingFixtures.buildChain;
import static io.xj.nexus.NexusIntegrationTestingFixtures.buildSegment;
import static org.junit.Assert.*;

public class SegmentAudioTest {
  private Segment segment1;
  private Chain chain1;
  private SegmentAudio subject;
  private SourceFactory factory;

  @Before
  public void setUp() {
    var account1 = buildAccount("Test");
    var template1 = buildTemplate(account1, TemplateType.Production, "Test 123", "test123");
    chain1 = buildChain(
      account1,
      template1,
      "Test Print #1",
      ChainType.PRODUCTION,
      ChainState.FABRICATE,
      Instant.parse("2014-08-12T12:17:02.527142Z"));
    segment1 = buildSegment(
      chain1,
      1,
      SegmentState.CRAFTED,
      Instant.parse("2017-12-12T01:00:08.000000Z"),
      Instant.parse("2017-12-12T01:00:16.000000Z"),
      "F major",
      8,
      0.6,
      120.0,
      "seg123.ogg",
      "wav");
    segment1.setWaveformPreroll(1.7306228);
    segment1.setWaveformPostroll(1.205893);
    var injector = Guice.createInjector(new SourceModule());
    factory = injector.getInstance(SourceFactory.class);
    subject = factory.segmentAudio(chain1.getShipKey(), segment1);
  }

  @Test
  public void from() {
    var result = factory.segmentAudio(chain1.getShipKey(), segment1);

    assertEquals(result.getSegment(), subject.getSegment());
    assertEquals(SegmentAudioState.Pending, result.getState());
  }

  @Test
  public void getState() {
    assertEquals(SegmentAudioState.Pending, subject.getState());
  }

  @Test
  public void setState() {
    subject.setState(SegmentAudioState.Failed);

    assertEquals(SegmentAudioState.Failed, subject.getState());
  }

  @Test
  public void getId() {
    assertEquals(segment1.getId(), subject.getId());
  }

  @Test
  public void getSegment() {
    assertEquals(segment1, subject.getSegment());
  }

  @Test
  public void intersects() {
    assertTrue(subject.intersects(chain1.getShipKey(), Instant.parse("2017-12-12T01:00:09.000000Z"), Instant.parse("2017-12-12T01:00:15.000000Z")));
    assertTrue(subject.intersects(chain1.getShipKey(), Instant.parse("2017-12-12T01:00:00.000000Z"), Instant.parse("2017-12-12T01:00:12.000000Z")));
    assertTrue(subject.intersects(chain1.getShipKey(), Instant.parse("2017-12-12T01:00:10.000000Z"), Instant.parse("2017-12-12T01:00:30.000000Z")));
    assertFalse(subject.intersects(chain1.getShipKey(), Instant.parse("2017-12-12T01:00:04.000000Z"), Instant.parse("2017-12-12T01:00:05.000000Z")));
    assertFalse(subject.intersects(chain1.getShipKey(), Instant.parse("2017-12-12T01:00:18.000000Z"), Instant.parse("2017-12-12T01:00:21.000000Z")));
    // true because of waveform pre-roll
    assertTrue(subject.intersects(chain1.getShipKey(), Instant.parse("2017-12-12T01:00:01.000000Z"), Instant.parse("2017-12-12T01:00:07.000000Z")));
    // true because of waveform post-roll
    assertTrue(subject.intersects(chain1.getShipKey(), Instant.parse("2017-12-12T01:00:17.000000Z"), Instant.parse("2017-12-12T01:00:26.000000Z")));
  }
}