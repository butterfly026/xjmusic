// Copyright (c) 2017, Outright Mental Inc. (http://outright.io) All Rights Reserved.
package io.outright.xj.core.dao;

import io.outright.xj.core.CoreModule;
import io.outright.xj.core.app.access.impl.AccessControl;
import io.outright.xj.core.app.exception.BusinessException;
import io.outright.xj.core.integration.IntegrationTestEntity;
import io.outright.xj.core.integration.IntegrationTestService;
import io.outright.xj.core.model.chain.Chain;
import io.outright.xj.core.model.link.Link;
import io.outright.xj.core.model.link.LinkWrapper;
import io.outright.xj.core.tables.records.LinkRecord;

import org.jooq.types.ULong;

import com.google.common.collect.ImmutableMap;
import com.google.inject.Guice;
import com.google.inject.Injector;

import org.json.JSONArray;
import org.json.JSONObject;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import java.math.BigInteger;
import java.sql.Timestamp;

import static io.outright.xj.core.tables.Link.LINK;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertNull;
import static org.junit.Assert.assertTrue;

public class LinkIT {
  private Injector injector = Guice.createInjector(new CoreModule());
  private LinkDAO testDAO;

  @Before
  public void setUp() throws Exception {
    IntegrationTestEntity.deleteAll();

    // Account "Testing" has chain "Test Print #1"
    IntegrationTestEntity.insertAccount(1, "Testing");
    IntegrationTestEntity.insertChain(1, 1, "Test Print #1", Chain.PRODUCTION, Timestamp.valueOf("2014-08-12 12:17:02.527142"), null);

    // Chain "Test Print #1" has 5 sequential links
    IntegrationTestEntity.insertLink(1, 1, 0, Link.DUBBED, Timestamp.valueOf("2017-02-14 12:01:00.000001"), Timestamp.valueOf("2017-02-14 12:01:32.000001"), "D major", 64, 0.73, 120);
    IntegrationTestEntity.insertLink(2, 1, 1, Link.DUBBING, Timestamp.valueOf("2017-02-14 12:01:32.000001"), Timestamp.valueOf("2017-02-14 12:02:04.000001"), "Db minor", 64, 0.85, 120);
    IntegrationTestEntity.insertLink(3, 1, 2, Link.CRAFTED, Timestamp.valueOf("2017-02-14 12:02:04.000001"), Timestamp.valueOf("2017-02-14 12:02:36.000001"), "F major", 64, 0.30, 120);
    IntegrationTestEntity.insertLink(4, 1, 3, Link.CRAFTING, Timestamp.valueOf("2017-02-14 12:02:36.000001"), Timestamp.valueOf("2017-02-14 12:03:08.000001"), "E minor", 64, 0.41, 120);
    IntegrationTestEntity.insertLink(5, 1, 4, Link.PLANNED, Timestamp.valueOf("2017-02-14 12:03:08.000001"), null, "A major", 64, 0.52, 120);

    // Instantiate the test subject
    testDAO = injector.getInstance(LinkDAO.class);
  }

  @After
  public void tearDown() throws Exception {
    testDAO = null;
  }

  @Test
  public void create() throws Exception {
    AccessControl access = new AccessControl(ImmutableMap.of(
      "roles", "admin"
    ));
    LinkWrapper inputDataWrapper = new LinkWrapper()
      .setLink(new Link()
        .setChainId(BigInteger.valueOf(1))
        .setOffset(BigInteger.valueOf(5))
        .setState(Link.PLANNED)
        .setBeginAt("1995-04-28 11:23:00.000001")
        .setEndAt("1995-04-28 11:23:32.000001")
        .setTotal(64)
        .setDensity(0.74)
        .setKey("C# minor 7 b9")
        .setTempo(120.0)
      );

    JSONObject actualResult = testDAO.create(access, inputDataWrapper);

    assertNotNull(actualResult);
    assertEquals(ULong.valueOf(1), actualResult.get("chainId"));
    assertEquals(ULong.valueOf(5), actualResult.get("offset"));
    assertEquals(Link.PLANNED, actualResult.get("state"));
    assertEquals(Timestamp.valueOf("1995-04-28 11:23:00.000001"), actualResult.get("beginAt"));
    assertEquals(Timestamp.valueOf("1995-04-28 11:23:32.000001"), actualResult.get("endAt"));
    assertEquals(64, actualResult.get("total"));
    assertEquals(0.74, actualResult.get("density"));
    assertEquals("C# minor 7 b9", actualResult.get("key"));
    assertEquals(120.0, actualResult.get("tempo"));
  }

  @Test
  // [#126] Links are always created in PLANNED state
  public void create_alwaysInPlannedState() throws Exception {
    AccessControl access = new AccessControl(ImmutableMap.of(
      "roles", "admin"
    ));
    LinkWrapper inputDataWrapper = new LinkWrapper()
      .setLink(new Link()
        .setChainId(BigInteger.valueOf(1))
        .setOffset(BigInteger.valueOf(5))
        .setState(Link.CRAFTING)
        .setBeginAt("1995-04-28 11:23:00.000001")
        .setEndAt("1995-04-28 11:23:32.000001")
        .setTotal(64)
        .setDensity(0.74)
        .setKey("C# minor 7 b9")
        .setTempo(120.0)
      );

    JSONObject actualResult = testDAO.create(access, inputDataWrapper);

    assertNotNull(actualResult);
    assertEquals(ULong.valueOf(1), actualResult.get("chainId"));
    assertEquals(ULong.valueOf(5), actualResult.get("offset"));
    assertEquals(Link.PLANNED, actualResult.get("state"));
    assertEquals(Timestamp.valueOf("1995-04-28 11:23:00.000001"), actualResult.get("beginAt"));
    assertEquals(Timestamp.valueOf("1995-04-28 11:23:32.000001"), actualResult.get("endAt"));
    assertEquals(64, actualResult.get("total"));
    assertEquals(0.74, actualResult.get("density"));
    assertEquals("C# minor 7 b9", actualResult.get("key"));
    assertEquals(120.0, actualResult.get("tempo"));
  }

  @Test(expected = BusinessException.class)
  public void create_FailsIfNotUniqueChainOffset() throws Exception {
    AccessControl access = new AccessControl(ImmutableMap.of(
      "roles", "admin"
    ));
    LinkWrapper inputDataWrapper = new LinkWrapper()
      .setLink(new Link()
        .setChainId(BigInteger.valueOf(1))
        .setOffset(BigInteger.valueOf(4))
        .setState(Link.CRAFTING)
        .setBeginAt("1995-04-28 11:23:00.000001")
        .setEndAt("1995-04-28 11:23:32.000001")
        .setTotal(64)
        .setDensity(0.74)
        .setKey("C# minor 7 b9")
        .setTempo(120.0)
      );

    try {
      testDAO.create(access, inputDataWrapper);

    } catch (Exception e) {
      assertNotNull(e);
      String msg = e.getMessage();
      assertTrue(msg.startsWith("Cannot create record"));
      assertTrue(msg.contains("Duplicate entry"));
      throw e;
    }
  }

  @Test(expected = BusinessException.class)
  public void create_FailsWithoutTopLevelAccess() throws Exception {
    AccessControl access = new AccessControl(ImmutableMap.of(
      "roles", "user"
    ));
    LinkWrapper inputDataWrapper = new LinkWrapper()
      .setLink(new Link()
        .setChainId(BigInteger.valueOf(1))
        .setOffset(BigInteger.valueOf(4))
        .setState(Link.CRAFTING)
        .setBeginAt("1995-04-28 11:23:00.000001")
        .setEndAt("1995-04-28 11:23:32.000001")
        .setTotal(64)
        .setDensity(0.74)
        .setKey("C# minor 7 b9")
        .setTempo(120.0)
      );

    testDAO.create(access, inputDataWrapper);
  }

  @Test(expected = BusinessException.class)
  public void create_FailsWithoutChainID() throws Exception {
    AccessControl access = new AccessControl(ImmutableMap.of(
      "roles", "admin"
    ));
    LinkWrapper inputDataWrapper = new LinkWrapper()
      .setLink(new Link()
        .setOffset(BigInteger.valueOf(4))
        .setState(Link.CRAFTING)
        .setBeginAt("1995-04-28 11:23:00.000001")
        .setEndAt("1995-04-28 11:23:32.000001")
        .setTotal(64)
        .setDensity(0.74)
        .setKey("C# minor 7 b9")
        .setTempo(120.0)
      );

    testDAO.create(access, inputDataWrapper);
  }

  @Test(expected = BusinessException.class)
  public void create_FailsWithInvalidState() throws Exception {
    AccessControl access = new AccessControl(ImmutableMap.of(
      "roles", "admin"
    ));
    LinkWrapper inputDataWrapper = new LinkWrapper()
      .setLink(new Link()
        .setChainId(BigInteger.valueOf(1))
        .setOffset(BigInteger.valueOf(4))
        .setState("mushamush")
        .setBeginAt("1995-04-28 11:23:00.000001")
        .setEndAt("1995-04-28 11:23:32.000001")
        .setTotal(64)
        .setDensity(0.74)
        .setKey("C# minor 7 b9")
        .setTempo(120.0)
      );

    testDAO.create(access, inputDataWrapper);
  }

  @Test
  public void readOne() throws Exception {
    AccessControl access = new AccessControl(ImmutableMap.of(
      "roles", "user",
      "accounts", "1"
    ));

    JSONObject actualResult = testDAO.readOne(access, ULong.valueOf(2));

    assertNotNull(actualResult);
    assertEquals(ULong.valueOf(2), actualResult.get("id"));
    assertEquals(ULong.valueOf(1), actualResult.get("chainId"));
    assertEquals(ULong.valueOf(1), actualResult.get("offset"));
    assertEquals(Link.DUBBING, actualResult.get("state"));
    assertEquals(Timestamp.valueOf("2017-02-14 12:01:32.000001"), actualResult.get("beginAt"));
    assertEquals(Timestamp.valueOf("2017-02-14 12:02:04.000001"), actualResult.get("endAt"));
    assertEquals(ULong.valueOf(64), actualResult.get("total"));
    assertEquals(0.85, actualResult.get("density"));
    assertEquals("Db minor", actualResult.get("key"));
    assertEquals(120.0, actualResult.get("tempo"));
  }

  @Test
  public void readOne_FailsWhenUserIsNotInChain() throws Exception {
    AccessControl access = new AccessControl(ImmutableMap.of(
      "roles", "user",
      "accounts", "326"
    ));

    JSONObject actualResult = testDAO.readOne(access, ULong.valueOf(1));

    assertNull(actualResult);
  }

  @Test
  public void readAll() throws Exception {
    AccessControl access = new AccessControl(ImmutableMap.of(
      "roles", "user",
      "accounts", "1"
    ));

    JSONArray actualResultList = testDAO.readAllIn(access, ULong.valueOf(1));

    assertNotNull(actualResultList);
    assertEquals(5, actualResultList.length());

    JSONObject actualResult4 = (JSONObject) actualResultList.get(4);
    assertEquals(Link.DUBBED, actualResult4.get("state"));
    JSONObject actualResult3 = (JSONObject) actualResultList.get(3);
    assertEquals(Link.DUBBING, actualResult3.get("state"));
    JSONObject actualResult2 = (JSONObject) actualResultList.get(2);
    assertEquals(Link.CRAFTED, actualResult2.get("state"));
    JSONObject actualResult1 = (JSONObject) actualResultList.get(1);
    assertEquals(Link.CRAFTING, actualResult1.get("state"));
    JSONObject actualResult0 = (JSONObject) actualResultList.get(0);
    assertEquals(Link.PLANNED, actualResult0.get("state"));
  }

  @Test
  public void readOneInState() throws Exception {
    AccessControl access = new AccessControl(ImmutableMap.of(
      "roles", "internal"
    ));

    JSONObject actualResult = testDAO.readOneInState(access, ULong.valueOf(1), Link.PLANNED, Timestamp.valueOf("2017-02-14 12:03:08.000001"));

    assertNotNull(actualResult);
    assertEquals(ULong.valueOf(5), actualResult.get("id"));
    assertEquals(ULong.valueOf(1), actualResult.get("chainId"));
    assertEquals(ULong.valueOf(4), actualResult.get("offset"));
    assertEquals(Link.PLANNED, actualResult.get("state"));
    assertEquals(Timestamp.valueOf("2017-02-14 12:03:08.000001"), actualResult.get("beginAt"));
    assertFalse(actualResult.has("endAt"));
  }

  @Test
  public void readOneInState_nullIfNoneInChain() throws Exception {
    AccessControl access = new AccessControl(ImmutableMap.of(
      "roles", "internal"
    ));
    IntegrationTestEntity.insertChain(2, 1, "Test Print #2", Chain.PRODUCTION, Timestamp.valueOf("2014-08-12 12:17:02.527142"), null);

    JSONObject actualResult = testDAO.readOneInState(access, ULong.valueOf(2), Link.PLANNED, Timestamp.valueOf("2017-02-14 12:03:08.000001"));

    assertNull(actualResult);
  }



  @Test
  public void readAll_SeesNothingOutsideOfChain() throws Exception {
    AccessControl access = new AccessControl(ImmutableMap.of(
      "roles", "user",
      "accounts", "345"
    ));

    JSONArray actualResultList = testDAO.readAllIn(access, ULong.valueOf(1));

    assertNotNull(actualResultList);
    assertEquals(0, actualResultList.length());
  }

  @Test
  public void update() throws Exception {
    AccessControl access = new AccessControl(ImmutableMap.of(
      "roles", "admin"
    ));
    LinkWrapper inputDataWrapper = new LinkWrapper()
      .setLink(new Link()
        .setChainId(BigInteger.valueOf(1))
        .setOffset(BigInteger.valueOf(5))
        .setState(Link.DUBBED)
        .setBeginAt("1995-04-28 11:23:00.000001")
        .setEndAt("1995-04-28 11:23:32.000001")
        .setTotal(64)
        .setDensity(0.74)
        .setKey("C# minor 7 b9")
        .setTempo(120.0)
      );

    testDAO.update(access, ULong.valueOf(2), inputDataWrapper);

    LinkRecord updatedRecord = IntegrationTestService.getDb()
      .selectFrom(LINK)
      .where(LINK.ID.eq(ULong.valueOf(2)))
      .fetchOne();
    assertNotNull(updatedRecord);
    assertEquals("C# minor 7 b9", updatedRecord.getKey());
    assertEquals(ULong.valueOf(1), updatedRecord.getChainId());
    assertEquals(Link.DUBBED, updatedRecord.getState());
    assertEquals(Timestamp.valueOf("1995-04-28 11:23:00.000001"), updatedRecord.getBeginAt());
    assertEquals(Timestamp.valueOf("1995-04-28 11:23:32.000001"), updatedRecord.getEndAt());
  }

  @Test(expected =  BusinessException.class)
  public void update_failsToTransitionFromDubbingToCrafting() throws Exception {
    AccessControl access = new AccessControl(ImmutableMap.of(
      "roles", "admin"
    ));
    LinkWrapper inputDataWrapper = new LinkWrapper()
      .setLink(new Link()
        .setChainId(BigInteger.valueOf(1))
        .setOffset(BigInteger.valueOf(5))
        .setState(Link.CRAFTING)
        .setBeginAt("1995-04-28 11:23:00.000001")
        .setEndAt("1995-04-28 11:23:32.000001")
        .setTotal(64)
        .setDensity(0.74)
        .setKey("C# minor 7 b9")
        .setTempo(120.0)
      );

    try {
      testDAO.update(access, ULong.valueOf(2), inputDataWrapper);

    } catch(Exception e) {
      assertTrue(e.getMessage().contains("transition to crafting not allowed"));
      throw e;
    }
  }

  @Test(expected = BusinessException.class)
  public void update_FailsWithoutChainID() throws Exception {
    AccessControl access = new AccessControl(ImmutableMap.of(
      "roles", "admin"
    ));
    LinkWrapper inputDataWrapper = new LinkWrapper()
      .setLink(new Link()
        .setOffset(BigInteger.valueOf(4))
        .setState(Link.CRAFTING)
        .setBeginAt("1995-04-28 11:23:00.000001")
        .setEndAt("1995-04-28 11:23:32.000001")
        .setTotal(64)
        .setDensity(0.74)
        .setKey("C# minor 7 b9")
        .setTempo(120.0)
      );

    testDAO.update(access, ULong.valueOf(2), inputDataWrapper);
  }

  @Test(expected = BusinessException.class)
  public void update_FailsWithInvalidState() throws Exception {
    AccessControl access = new AccessControl(ImmutableMap.of(
      "roles", "admin"
    ));
    LinkWrapper inputDataWrapper = new LinkWrapper()
      .setLink(new Link()
        .setChainId(BigInteger.valueOf(1))
        .setOffset(BigInteger.valueOf(4))
        .setState("what a dumb-ass state")
        .setBeginAt("1995-04-28 11:23:00.000001")
        .setEndAt("1995-04-28 11:23:32.000001")
        .setDensity(0.74)
        .setKey("C# minor 7 b9")
        .setTempo(120.0)
      );

    testDAO.update(access, ULong.valueOf(2), inputDataWrapper);
  }

  @Test(expected = BusinessException.class)
  public void update_FailsToChangeChain() throws Exception {
    AccessControl access = new AccessControl(ImmutableMap.of(
      "roles", "admin"
    ));
    LinkWrapper inputDataWrapper = new LinkWrapper()
      .setLink(new Link()
        .setChainId(BigInteger.valueOf(12))
        .setOffset(BigInteger.valueOf(4))
        .setState(Link.CRAFTING)
        .setBeginAt("1995-04-28 11:23:00.000001")
        .setEndAt("1995-04-28 11:23:32.000001")
        .setTotal(64)
        .setDensity(0.74)
        .setKey("C# minor 7 b9")
        .setTempo(120.0)
      );

    try {
      testDAO.update(access, ULong.valueOf(2), inputDataWrapper);

    } catch (Exception e) {
      LinkRecord updatedRecord = IntegrationTestService.getDb()
        .selectFrom(LINK)
        .where(LINK.ID.eq(ULong.valueOf(2)))
        .fetchOne();
      assertNotNull(updatedRecord);
      assertEquals("Db minor", updatedRecord.getKey());
      assertEquals(ULong.valueOf(1), updatedRecord.getChainId());
      throw e;
    }
  }

  @Test
  public void delete() throws Exception {
    AccessControl access = new AccessControl(ImmutableMap.of(
      "roles", "admin"
    ));

    testDAO.delete(access, ULong.valueOf(1));

    LinkRecord deletedRecord = IntegrationTestService.getDb()
      .selectFrom(LINK)
      .where(LINK.ID.eq(ULong.valueOf(1)))
      .fetchOne();
    assertNull(deletedRecord);
  }

  @Test(expected = BusinessException.class)
  public void delete_FailsIfLinkHasChildRecords() throws Exception {
    AccessControl access = new AccessControl(ImmutableMap.of(
      "roles", "admin"
    ));
    IntegrationTestEntity.insertLinkChord(1, 1, 1.5, "C minor");

    try {
      testDAO.delete(access, ULong.valueOf(1));

    } catch (Exception e) {
      LinkRecord stillExistingRecord = IntegrationTestService.getDb()
        .selectFrom(LINK)
        .where(LINK.ID.eq(ULong.valueOf(1)))
        .fetchOne();
      assertNotNull(stillExistingRecord);
      throw e;
    }
  }
}