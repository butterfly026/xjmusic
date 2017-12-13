package io.xj.core.timestamp;// Copyright (c) 2017, Outright Mental Inc. (http://outright.io) All Rights Reserved.

import org.junit.Before;
import org.junit.Test;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.ZoneId;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.is;
import static org.hamcrest.Matchers.lessThan;

public class TimestampUTCTest {
  private Timestamp now;
  private static final Long MATCH_THRESHOLD_MILLIS = 100L;
  private static final Long MILLIS_PER_SECOND = 1000L;

  @Before
  public void setUp() throws Exception {
    now = Timestamp.valueOf(LocalDateTime.now(ZoneId.of("UTC")));
  }

  @Test
  public void now() throws Exception {
    Timestamp actual = TimestampUTC.now();

    assertThat("now",
      actual.getTime() - now.getTime(),
      lessThan(MATCH_THRESHOLD_MILLIS));
  }

  @Test
  public void nowPlusSeconds() throws Exception {
    Timestamp actual = TimestampUTC.nowPlusSeconds(5);

    assertThat("5 seconds from now",
      actual.getTime() - (now.getTime() + 5 * MILLIS_PER_SECOND),
      lessThan(MATCH_THRESHOLD_MILLIS));
  }

  @Test
  public void nowMinusSeconds() throws Exception {
    Timestamp actual = TimestampUTC.nowMinusSeconds(3);

    assertThat("3 seconds ago",
      actual.getTime() - (now.getTime() - 3 * MILLIS_PER_SECOND),
      lessThan(MATCH_THRESHOLD_MILLIS));
  }

  @Test
  public void valueOf_regularTimestamp() throws Exception {
    Timestamp actual = TimestampUTC.valueOf("2014-08-12 12:17:02.527142");

    assertThat("value of time string",
      actual,
      is(Timestamp.valueOf("2014-08-12 12:17:02.527142")));
  }

  @Test(expected = IllegalArgumentException.class)
  public void valueOf_invalidTimestamp() throws Exception {
    TimestampUTC.valueOf("terrible pattern for a timestamp");
  }

  /**
   [#150279615] For any timestamp field, enter "now" for current timestamp utc
   */
  @Test
  public void valueOf_now() throws Exception {
    Timestamp actual = TimestampUTC.valueOf("   NO!w!!    ");

    assertThat("value of string 'now' (stripped of non-alphanumeric characters; case insensitive)",
      actual.getTime() - now.getTime(),
      lessThan(MATCH_THRESHOLD_MILLIS));
  }

}