// Copyright (c) 1999-2021, XJ Music Inc. (https://xj.io) All Rights Reserved.

package io.xj.lib.util;

import org.junit.Before;
import org.junit.Test;

import static org.junit.Assert.*;

/**
 Measures a series of named sections of time
 */
public class MultiStopwatchTest {
  MultiStopwatch subject;

  @Before
  public void start() throws Exception {
    subject = MultiStopwatch.start();
  }

  @Test
  public void stop_getTotalSeconds() throws InterruptedException {
    Thread.sleep(10);
    subject.stop();

    assertTrue(0.01 <= subject.getTotalSeconds());
  }

  @Test
  public void section_getSectionTotalSeconds_toString() throws InterruptedException {
    subject.section("One");
    Thread.sleep(10);
    subject.section("Two");
    Thread.sleep(10);
    subject.stop();

    assertTrue(0.02 <= subject.getTotalSeconds());
    assertTrue(0.01 <= subject.getLapSectionSeconds().get("One"));
    assertTrue(0.01 <= subject.getLapSectionSeconds().get("Two"));
    var str = subject.lapToString();
    assertTrue(str.contains("One"));
    assertTrue(str.contains("Two"));
  }

  @Test
  public void lap_section_getLapTimes_toString() throws InterruptedException {
    Thread.sleep(20); // wasted time
    subject.section("Work");
    Thread.sleep(10);
    subject.lap();

    assertTrue(0.03 <= subject.getLapTotalSeconds());

    Thread.sleep(20); // wasted time
    subject.section("Work");
    Thread.sleep(10);
    subject.stop();

    assertTrue(0.03 <= subject.getLapTotalSeconds());
    assertTrue(0.06 <= subject.getTotalSeconds());
    assertTrue(0.01 <= subject.getLapSectionSeconds().get("Work"));
    assertTrue(0.02 <= subject.getLapSectionSeconds().get("Standby"));
    assertTrue(0.02 <= subject.getTotalSectionSeconds().get("Work"));
    assertTrue(0.04 <= subject.getTotalSectionSeconds().get("Standby"));
    assertTrue(0.02 <= subject.getLapSectionSeconds().get(MultiStopwatch.STANDBY));
  }

  @Test
  public void lap_sectionTimesAddUpWithinLap() throws InterruptedException {
    Thread.sleep(10); // standby
    subject.section("Left");
    Thread.sleep(10);
    subject.section("Right");
    Thread.sleep(10);
    subject.section("Left");
    Thread.sleep(10);
    subject.section("Right");
    Thread.sleep(10);
    subject.lap();

    assertTrue(0.05 <= subject.getLapTotalSeconds());
    assertTrue(0.02 <= subject.getLapSectionSeconds().get("Left"));
    assertTrue(0.02 <= subject.getLapSectionSeconds().get("Right"));
    assertTrue(0.01 <= subject.getLapSectionSeconds().get(MultiStopwatch.STANDBY));
  }

}
