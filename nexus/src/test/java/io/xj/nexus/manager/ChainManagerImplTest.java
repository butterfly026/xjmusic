// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.nexus.manager;

import com.google.common.collect.ImmutableList;
import io.xj.hub.HubTopology;
import io.xj.hub.enums.TemplateType;
import io.xj.hub.tables.pojos.Account;
import io.xj.hub.tables.pojos.Template;
import io.xj.lib.app.AppEnvironment;
import io.xj.lib.entity.EntityFactoryImpl;
import io.xj.lib.json.JsonProvider;
import io.xj.lib.json.JsonProviderImpl;
import io.xj.lib.notification.NotificationProvider;
import io.xj.lib.util.Values;
import io.xj.nexus.NexusTopology;
import io.xj.nexus.model.Chain;
import io.xj.nexus.model.ChainState;
import io.xj.nexus.model.ChainType;
import io.xj.nexus.model.Segment;
import io.xj.nexus.model.SegmentState;
import io.xj.nexus.model.SegmentType;
import io.xj.nexus.persistence.ChainManager;
import io.xj.nexus.persistence.ChainManagerImpl;
import io.xj.nexus.persistence.ManagerExistenceException;
import io.xj.nexus.persistence.ManagerValidationException;
import io.xj.nexus.persistence.NexusEntityStore;
import io.xj.nexus.persistence.NexusEntityStoreImpl;
import io.xj.nexus.persistence.SegmentManager;
import io.xj.nexus.persistence.SegmentManagerImpl;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.Mock;
import org.mockito.junit.MockitoJUnitRunner;

import java.time.Instant;
import java.util.Collection;
import java.util.Optional;
import java.util.UUID;

import static io.xj.hub.IntegrationTestingFixtures.buildAccount;
import static io.xj.hub.IntegrationTestingFixtures.buildLibrary;
import static io.xj.hub.IntegrationTestingFixtures.buildTemplate;
import static io.xj.nexus.NexusIntegrationTestingFixtures.buildChain;
import static io.xj.nexus.NexusIntegrationTestingFixtures.buildSegment;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertNull;
import static org.junit.Assert.assertThrows;
import static org.junit.Assert.assertTrue;
import static org.junit.Assert.fail;

@RunWith(MockitoJUnitRunner.class)
public class ChainManagerImplTest {
  @Mock
  private NotificationProvider notificationProvider;
  private NexusEntityStore store;
  private ChainManager subject;
  private Account account1;
  private Chain chain1;
  private Chain chain2;
  private Template template1;
  private Template template2;

  @Before
  public void setUp() throws Exception {
    var env = AppEnvironment.getDefault();
    JsonProvider jsonProvider = new JsonProviderImpl();
    var entityFactory = new EntityFactoryImpl(jsonProvider);
    HubTopology.buildHubApiTopology(entityFactory);
    NexusTopology.buildNexusApiTopology(entityFactory);

    // Manipulate the underlying entity store
    store = new NexusEntityStoreImpl(entityFactory);
    store.deleteAll();

    // hub entities as basis
    account1 = buildAccount("fish");
    buildLibrary(account1, "test");
    template1 = buildTemplate(account1, "Test Template 1", "test1");
    template2 = buildTemplate(account1, "Test Template 2", "test2");

    // Payload comprising Nexus entities
    chain1 = store.put(buildChain(account1, "school", ChainType.PRODUCTION, ChainState.READY, template1,
      Instant.parse("2014-08-12T12:17:02.527142Z"), Instant.parse("2014-09-11T12:17:01.047563Z"), null));
    chain2 = store.put(buildChain(account1, "bucket", ChainType.PRODUCTION, ChainState.FABRICATE, template2,
      Instant.parse("2015-05-10T12:17:02.527142Z"), Instant.parse("2015-06-09T12:17:01.047563Z"), null));

    // Instantiate the test subject
    SegmentManager segmentManager = new SegmentManagerImpl(entityFactory, store);
    subject = new ChainManagerImpl(
      env,
      entityFactory,
      store,
      segmentManager,
      notificationProvider
    );
  }

  /**
   * Nexus bootstraps Chains from JSON file on startup https://www.pivotaltracker.com/story/show/176285826
   */
  @Test
  public void bootstrap() throws Exception {
    var input = new Chain();
    input.setId(UUID.randomUUID());
    input.setAccountId(account1.getId());
    input.setName("coconuts");
    input.setState(ChainState.DRAFT);
    input.setType(ChainType.PRODUCTION);

    var result = subject.bootstrap(TemplateType.Production, input);

    assertNotNull(result);
    assertEquals(account1.getId(), result.getAccountId());
    assertEquals("coconuts", result.getName());
    assertEquals(ChainState.FABRICATE, result.getState());
    assertEquals(ChainType.PRODUCTION, result.getType());
  }

  @Test
  public void create() throws Exception {
    var input = new Chain();
    input.setId(UUID.randomUUID());
    input.setAccountId(account1.getId());
    input.setName("coconuts");
    input.setState(ChainState.DRAFT);
    input.setType(ChainType.PRODUCTION);
    input.startAt("2009-08-12T12:17:02.527142Z");
    input.stopAt("2009-09-11T12:17:01.047563Z");

    var result = subject.create(input);

    assertNotNull(result);
    assertEquals(account1.getId(), result.getAccountId());
    assertEquals("coconuts", result.getName());
    assertEquals(ChainState.DRAFT, result.getState());
    assertEquals(ChainType.PRODUCTION, result.getType());
    assertEquals("2009-08-12T12:17:02.527142Z", result.getStartAt());
    assertEquals("2009-09-11T12:17:01.047563Z", result.getStopAt());
  }

  @Test
  public void create_typeNotSpecified_defaultsToPreview() throws Exception {
    var input = new Chain();
    input.setId(UUID.randomUUID());
    input.setAccountId(account1.getId());
    input.setName("coconuts");
    input.setState(ChainState.DRAFT);
    input.startAt("2009-08-12T12:17:02.527142Z");
    input.stopAt("2009-09-11T12:17:01.047563Z");

    var result = subject.create(input);

    assertNotNull(result);
    assertEquals(ChainType.PREVIEW, result.getType());
  }

  @Test
  public void create_withShipKey() throws Exception {
    var input = new Chain();
    input.setId(UUID.randomUUID());
    input.setAccountId(account1.getId());
    input.setName("coconuts");
    input.setState(ChainState.DRAFT);
    input.shipKey("my $% favorite THINGS");
    input.setType(ChainType.PRODUCTION);
    input.startAt("2009-08-12T12:17:02.527142Z");
    input.stopAt("2009-09-11T12:17:01.047563Z");

    var result = subject.create(input);

    assertNotNull(result);
    assertEquals(account1.getId(), result.getAccountId());
    assertEquals("coconuts", result.getName());
    assertEquals(ChainState.DRAFT, result.getState());
    assertEquals(ChainType.PRODUCTION, result.getType());
    assertEquals("my_favorite_things", result.getShipKey());
    assertEquals("2009-08-12T12:17:02.527142Z", result.getStartAt());
    assertEquals("2009-09-11T12:17:01.047563Z", result.getStopAt());
  }

  @Test
  public void create_withShipKey_failsIfShipKeyAlreadyExists() throws Exception {
    var first = buildChain(account1, "bucket", ChainType.PRODUCTION, ChainState.FABRICATE, template1, Instant.parse("2015-05-10T12:17:02.527142Z"), Instant.parse("2015-06-09T12:17:01.047563Z"), "my_favorite_things");
    var second = buildChain(account1, "bucket", ChainType.PRODUCTION, ChainState.FABRICATE, template2, Instant.parse("2015-05-10T12:17:02.527142Z"), Instant.parse("2015-06-09T12:17:01.047563Z"), "my_favorite_things");
    subject.create(first);

    Exception thrown = assertThrows(ManagerValidationException.class, () -> subject.create(second));

    assertEquals("Chain already exists with ship key 'my_favorite_things'!", thrown.getMessage());
  }

  @Test
  public void create_PreviewType() throws Exception {
    var input = new Chain();
    input.setId(UUID.randomUUID());
    input.setAccountId(account1.getId());
    input.setName("coconuts");
    input.setState(ChainState.DRAFT);
    input.setType(ChainType.PREVIEW);
    input.startAt("2009-08-12T12:17:02.527142Z");
    input.stopAt("2009-09-11T12:17:01.047563Z");

    var result = subject.create(input);

    assertNotNull(result);
    assertEquals(account1.getId(), result.getAccountId());
    assertEquals("coconuts", result.getName());
    assertEquals(ChainState.DRAFT, result.getState());
    assertEquals(ChainType.PREVIEW, result.getType());
  }


  @Test
  public void create_PreviewType_asArtist() throws Exception {
    var input = new Chain();
    input.setId(UUID.randomUUID());
    input.setAccountId(account1.getId());
    input.startAt("2009-08-12T12:17:02.527142Z");
    input.setState(ChainState.DRAFT);
    input.setType(ChainType.PREVIEW);
    input.setName("coconuts");

    var result = subject.create(input);

    assertNotNull(result);
    assertEquals(account1.getId(), result.getAccountId());
    assertEquals("coconuts", result.getName());
    assertEquals(ChainState.DRAFT, result.getState());
    assertEquals(ChainType.PREVIEW, result.getType());
  }

  @Test
  // [#126] Chains are always readMany in DRAFT state
  public void create_createdInDraftState() throws Exception {
    var input = new Chain();
    input.setId(UUID.randomUUID());
    input.setAccountId(account1.getId());
    input.setName("coconuts");
    input.setType(ChainType.PRODUCTION);
    input.setState(ChainState.FABRICATE);
    input.startAt("2009-08-12T12:17:02.527142Z");
    input.stopAt("2009-09-11T12:17:01.047563Z");

    var result = subject.create(input);

    assertNotNull(result);
    assertEquals(account1.getId(), result.getAccountId());
    assertEquals("coconuts", result.getName());
    assertEquals(ChainType.PRODUCTION, result.getType());
    assertEquals(ChainState.DRAFT, result.getState());
    assertEquals("2009-08-12T12:17:02.527142Z", result.getStartAt());
    assertEquals("2009-09-11T12:17:01.047563Z", result.getStopAt());
  }

  @Test
  public void create_WithoutStopAt() throws Exception {
    var input = new Chain();
    input.setId(UUID.randomUUID());
    input.setAccountId(account1.getId());
    input.setName("coconuts");
    input.setType(ChainType.PRODUCTION);
    input.setState(ChainState.DRAFT);
    input.startAt("2009-08-12T12:17:02.527142Z");

    var result = subject.create(input);

    assertNotNull(result);
    assertEquals(account1.getId(), result.getAccountId());
    assertEquals("coconuts", result.getName());
    assertEquals(ChainState.DRAFT, result.getState());
    assertEquals(ChainType.PRODUCTION, result.getType());
    assertEquals("2009-08-12T12:17:02.527142Z", result.getStartAt());
    assertNull(result.getStopAt());
  }

  @Test
  public void create_WithEmptyStopAt() throws Exception {
    var input = new Chain();
    input.setId(UUID.randomUUID());
    input.setAccountId(account1.getId());
    input.setName("coconuts");
    input.setState(ChainState.DRAFT);
    input.setType(ChainType.PRODUCTION);
    input.startAt("2009-08-12T12:17:02.527142Z");

    var result = subject.create(input);

    assertNotNull(result);
    assertEquals(account1.getId(), result.getAccountId());
    assertEquals("coconuts", result.getName());
    assertEquals(ChainState.DRAFT, result.getState());
    assertEquals(ChainType.PRODUCTION, result.getType());
    assertEquals("2009-08-12T12:17:02.527142Z", result.getStartAt());
    assertNull(result.getStopAt());
  }

  @Test
  public void create_FailsWithoutAccountID() {
    var input = new Chain();
    input.setName("coconuts");
    input.setState(ChainState.DRAFT);
    input.setType(ChainType.PRODUCTION);
    input.startAt("2009-08-12T12:17:02.527142Z");
    input.stopAt("2009-09-11T12:17:01.047563Z");

    Exception thrown = assertThrows(ManagerValidationException.class, () ->
      subject.create(input));

    assertEquals("Account ID is required.", thrown.getMessage());
  }

  @Test
  public void readOne() throws Exception {
    var result = subject.readOne(chain2.getId());

    assertNotNull(result);
    assertEquals(chain2.getId(), result.getId());
    assertEquals(account1.getId(), result.getAccountId());
    assertEquals("bucket", result.getName());
    assertEquals(ChainState.FABRICATE, result.getState());
    assertEquals(ChainType.PRODUCTION, result.getType());
    assertEquals("2015-05-10T12:17:02.527142Z", result.getStartAt());
    assertEquals("2015-06-09T12:17:01.047563Z", result.getStopAt());
  }

  /**
   * Unauthenticated or specifically-authenticated public Client wants to access a Chain by ship key (as alias for chain id) in order to provide data for playback. https://www.pivotaltracker.com/story/show/150279540
   */
  @Test
  public void readOne_byShipKey_unauthenticatedOk() throws Exception {
    var chain = subject.create(buildChain(account1, "cats test", ChainType.PRODUCTION, ChainState.DRAFT, template1, Instant.parse("2015-05-10T12:17:02.527142Z"), Instant.parse("2015-06-09T12:17:01.047563Z"), "cats"));

    var result = subject.readOneByShipKey("cats");

    assertNotNull(result);
    assertEquals(chain.getId(), result.getId());
    assertEquals(account1.getId(), result.getAccountId());
    assertEquals("cats test", result.getName());
    assertEquals(ChainState.DRAFT, result.getState());
    assertEquals(ChainType.PRODUCTION, result.getType());
    assertEquals("2015-05-10T12:17:02.527142Z", result.getStartAt());
    assertEquals("2015-06-09T12:17:01.047563Z", result.getStopAt());
    assertEquals("cats", result.getShipKey());
  }

  @Test
  public void readMany() throws Exception {
    Collection<Chain> result = subject.readMany(ImmutableList.of(account1.getId()));

    assertEquals(2L, result.size());
  }

  @Test
  public void readAllFabricating() throws Exception {
    store.put(buildChain(template2, ChainState.FABRICATE));
    store.put(buildChain(template2, ChainState.FABRICATE));
    store.put(buildChain(template2, ChainState.FABRICATE));
    store.put(buildChain(template2, ChainState.DRAFT));
    store.put(buildChain(template2, ChainState.COMPLETE));
    store.put(buildChain(template2, ChainState.READY));
    store.put(buildChain(template2, ChainState.FAILED));

    Collection<Chain> result = subject.readAllFabricating();

    assertEquals(4L, result.size());
  }

  @Test
  public void readMany_excludesChainsInFabricateState() throws Exception {
    buildChain(account1, "sham", ChainType.PRODUCTION, ChainState.FABRICATE, template1, Instant.parse("2015-05-10T12:17:02.527142Z"), Instant.parse("2015-06-09T12:17:01.047563Z"), null);

    Collection<Chain> result = subject.readMany(ImmutableList.of(account1.getId()));

    assertEquals(2L, result.size());
  }

  @Test
  public void readManyInState() throws Exception {
    Collection<Chain> result = subject.readManyInState(ChainState.FABRICATE);

    assertNotNull(result);
    assertEquals(1L, result.size());
    var result0 = result.iterator().next();

    assertEquals("bucket", result0.getName());
  }

  @Test
  public void update() throws Exception {
    var input = new Chain();
    input.setId(UUID.randomUUID());
    input.setAccountId(account1.getId());
    input.setName("coconuts");
    input.setType(ChainType.PRODUCTION);
    input.setState(ChainState.COMPLETE);
    input.startAt("2009-08-12T12:17:02.687327Z");
    input.stopAt("2009-09-11T12:17:01.989941Z");

    subject.update(chain2.getId(), input);

    var result = subject.readOne(chain2.getId());
    assertNotNull(result);
    assertEquals("coconuts", result.getName());
    assertEquals(account1.getId(), result.getAccountId());
    assertEquals(ChainState.COMPLETE, result.getState());
    assertEquals(ChainType.PRODUCTION, result.getType());
    assertEquals("2009-08-12T12:17:02.687327Z", result.getStartAt());
    assertEquals("2009-09-11T12:17:01.989941Z", result.getStopAt());
  }

  @Test
  public void update_cantChangeEndOfPreviewChain() throws Exception {
    var previewChain = new Chain();
    previewChain.setId(UUID.randomUUID());
    previewChain.setAccountId(account1.getId());
    previewChain.setName("coconuts");
    previewChain.setType(ChainType.PREVIEW);
    previewChain.setState(ChainState.FABRICATE);
    previewChain.startAt("2009-08-12T12:17:02.687327Z");
    previewChain.stopAt("2009-09-11T12:17:01.989941Z");
    store.put(previewChain);
    var input = new Chain();
    input.setId(UUID.randomUUID());
    input.setAccountId(account1.getId());
    input.setName("coconuts");
    input.setType(ChainType.PREVIEW);
    input.setState(ChainState.FABRICATE);
    input.startAt("2009-08-12T12:17:02.687327Z");
    input.stopAt("2009-09-12T12:17:01.989941Z");

    subject.update(previewChain.getId(), input);

    var result = subject.readOne(previewChain.getId());
    assertNotNull(result);
    assertEquals("coconuts", result.getName());
    assertEquals(account1.getId(), result.getAccountId());
    assertEquals(ChainState.FABRICATE, result.getState());
    assertEquals(ChainType.PREVIEW, result.getType());
    assertEquals("2009-08-12T12:17:02.687327Z", result.getStartAt());
    assertEquals("2009-09-11T12:17:01.989941Z", result.getStopAt());
  }

  @Test
  public void update_addShipKey() throws Exception {
    var input = new Chain();
    input.setId(UUID.randomUUID());
    input.setAccountId(account1.getId());
    input.setName("coconuts");
    input.setType(ChainType.PRODUCTION);
    input.shipKey("twenty %$** four HOURS");
    input.setState(ChainState.COMPLETE);
    input.startAt("2009-08-12T12:17:02.687327Z");
    input.stopAt("2009-09-11T12:17:01.989941Z");

    subject.update(chain2.getId(), input);

    var result = subject.readOne(chain2.getId());
    assertNotNull(result);
    assertEquals("coconuts", result.getName());
    assertEquals("twenty_four_hours", result.getShipKey());
    assertEquals(account1.getId(), result.getAccountId());
    assertEquals(ChainState.COMPLETE, result.getState());
    assertEquals(ChainType.PRODUCTION, result.getType());
    assertEquals("2009-08-12T12:17:02.687327Z", result.getStartAt());
    assertEquals("2009-09-11T12:17:01.989941Z", result.getStopAt());
  }

  @Test
  public void update_removeShipKey() throws Exception {
    var chain3 = store.put(buildChain(account1, "bucket", ChainType.PRODUCTION, ChainState.FABRICATE, template1, Instant.parse("2015-05-10T12:17:02.527142Z"), Instant.parse("2015-06-09T12:17:01.047563Z"), "twenty_four_hours"));
    var input = new Chain();
    input.setId(UUID.randomUUID());
    input.setAccountId(account1.getId());
    input.setName("coconuts");
    input.shipKey(null);
    input.setType(ChainType.PRODUCTION);
    input.setState(ChainState.COMPLETE);
    input.startAt("2009-08-12T12:17:02.687327Z");
    input.stopAt("2009-09-11T12:17:01.989941Z");

    subject.update(chain3.getId(), input);

    var result = subject.readOne(chain3.getId());
    assertNotNull(result);
    assertEquals("coconuts", result.getName());
    assertNull(result.getShipKey());
    assertEquals(account1.getId(), result.getAccountId());
    assertEquals(ChainState.COMPLETE, result.getState());
    assertEquals(ChainType.PRODUCTION, result.getType());
    assertEquals("2009-08-12T12:17:02.687327Z", result.getStartAt());
    assertEquals("2009-09-11T12:17:01.989941Z", result.getStopAt());
  }

  @Test
  public void update_addShipKey_failsIfShipKeyAlreadyExists() throws Exception {
    store.put(buildChain(account1, "bucket", ChainType.PRODUCTION, ChainState.FABRICATE, template1, Instant.parse("2015-05-10T12:17:02.527142Z"), Instant.parse("2015-06-09T12:17:01.047563Z"), "twenty_four_hours"));
    var input = new Chain();
    input.setId(UUID.randomUUID());
    input.setAccountId(account1.getId());
    input.setName("coconuts");
    input.setType(ChainType.PRODUCTION);
    input.shipKey("twenty_four_hours");
    input.setState(ChainState.COMPLETE);
    input.startAt("2009-08-12T12:17:02.687327Z");
    input.stopAt("2009-09-11T12:17:01.989941Z");

    Exception thrown = assertThrows(ManagerValidationException.class, () ->
      subject.update(chain2.getId(), input));

    assertEquals("Chain already exists with ship key 'twenty_four_hours'!", thrown.getMessage());
  }

  @Test
  public void update_okayWithShipKey() throws Exception {
    var chain = store.put(buildChain(account1, "school", ChainType.PRODUCTION, ChainState.READY, template1, Instant.parse("2014-08-12T12:17:02.527142Z"), Instant.parse("2014-09-11T12:17:01.047563Z"), "jabberwocky"));
    var input = new Chain();
    input.setId(UUID.randomUUID());
    input.setAccountId(account1.getId());
    input.setName("coconuts");
    input.setType(ChainType.PRODUCTION);
    input.setState(ChainState.READY);
    input.shipKey("jabberwocky");
    input.startAt("2009-08-12T12:17:02.687327Z");
    input.stopAt("2009-09-11T12:17:01.989941Z");

    subject.update(chain.getId(), input);

    var result = subject.readOne(chain.getId());
    assertNotNull(result);
    assertEquals("coconuts", result.getName());
    assertEquals("jabberwocky", result.getShipKey());
    assertEquals(account1.getId(), result.getAccountId());
    assertEquals(ChainState.READY, result.getState());
    assertEquals(ChainType.PRODUCTION, result.getType());
    assertEquals("2009-08-12T12:17:02.687327Z", result.getStartAt());
    assertEquals("2009-09-11T12:17:01.989941Z", result.getStopAt());
  }

  @Test
  public void existsForShipKey() throws Exception {
    store.put(buildChain(account1, "school", ChainType.PRODUCTION, ChainState.READY, template1, Instant.parse("2014-08-12T12:17:02.527142Z"), Instant.parse("2014-09-11T12:17:01.047563Z"), "jabberwocky"));
    var input = new Chain();
    input.setId(UUID.randomUUID());
    input.setAccountId(account1.getId());
    input.setName("coconuts");
    input.setType(ChainType.PRODUCTION);
    input.setState(ChainState.READY);
    input.shipKey("jabberwocky");
    input.startAt("2009-08-12T12:17:02.687327Z");
    input.stopAt("2009-09-11T12:17:01.989941Z");
  }


  @Test
  public void update_cannotChangeType() {
    var input = new Chain();
    input.setId(UUID.randomUUID());
    input.setAccountId(account1.getId());
    input.setName("coconuts");
    input.setType(ChainType.PREVIEW);
    input.setState(ChainState.COMPLETE);
    input.startAt("2009-08-12T12:17:02.687327Z");
    input.stopAt("2009-09-11T12:17:01.989941Z");

    Exception thrown = assertThrows(ManagerValidationException.class, () ->
      subject.update(chain2.getId(), input));

    assertEquals("Cannot modify Chain Type", thrown.getMessage());

  }

  @Test
  public void update_failsToChangeStartAt_whenChainsHasSegment() throws Exception {
    store.put(buildSegment(
      chain2,
      5,
      SegmentState.CRAFTED,
      Instant.parse("2015-05-10T12:17:03.527142Z"),
      Instant.parse("2015-06-09T12:17:01.047563Z"),
      "A major",
      64,
      0.52f,
      120.0f,
      "chains-1-segments-9f7s89d8a7892.wav",
      "wav"));
    var input = buildChain(
      account1,
      "bucket",
      ChainType.PRODUCTION,
      ChainState.FABRICATE,
      buildTemplate(buildAccount(), "Test"),
      Instant.parse("2015-05-10T12:17:03.527142Z"),
      Instant.parse("2015-06-09T12:17:01.047563Z"),
      "key123");

    Exception thrown = assertThrows(ManagerValidationException.class, () ->
      subject.update(chain2.getId(), input));

    assertEquals("cannot change chain startAt time after it has segments", thrown.getMessage());

  }

  @Test
  public void update_canChangeName_whenChainsHasSegment() throws Exception {
    var seg = new Segment();
    seg.setId(UUID.randomUUID());
    seg.setChainId(chain1.getId());
    seg.setOffset(5L);
    seg.setState(SegmentState.CRAFTED);
    seg.setKey("A major");
    seg.setTotal(64);
    seg.setDensity(0.52);
    seg.setTempo(120.0);
    seg.setBeginAt(Values.formatIso8601UTC(Instant.now()));
    seg.setType(SegmentType.NEXTMAIN);
    seg.storageKey("chains-1-segments-9f7s89d8a7892.wav");

    store.put(seg);
    var input = new Chain();
    input.setId(UUID.randomUUID());
    input.setAccountId(account1.getId());
    input.setName("coconuts");
    input.setState(ChainState.FABRICATE);
    input.setType(ChainType.PRODUCTION);
    input.startAt("2015-05-10T12:17:02.527142Z");
    input.stopAt("2015-06-09T12:17:01.047563Z");

    subject.update(chain2.getId(), input);

    var result = subject.readOne(chain2.getId());
    assertNotNull(result);
    assertEquals("coconuts", result.getName());
    assertEquals(account1.getId(), result.getAccountId());
    assertEquals(ChainState.FABRICATE, result.getState());
    assertEquals(ChainType.PRODUCTION, result.getType());
    assertEquals("2015-05-10T12:17:02.527142Z", result.getStartAt());
    assertEquals("2015-06-09T12:17:01.047563Z", result.getStopAt());
  }

  @Test
  public void update_RemoveStopAt() throws Exception {
    var input = new Chain();
    input.setId(UUID.randomUUID());
    input.setAccountId(account1.getId());
    input.setName("coconuts");
    input.setType(ChainType.PRODUCTION);
    input.setState(ChainState.COMPLETE);
    input.startAt("2009-08-12T12:17:02.687327Z");

    subject.update(chain2.getId(), input);

    var result = subject.readOne(chain2.getId());
    assertNotNull(result);
    assertEquals("coconuts", result.getName());
    assertEquals(account1.getId(), result.getAccountId());
    assertEquals(ChainState.COMPLETE, result.getState());
    assertEquals(ChainType.PRODUCTION, result.getType());
    assertEquals("2009-08-12T12:17:02.687327Z", result.getStartAt());
    assertNull(result.getStopAt());
  }

  @Test
  public void update_FailsWithoutAccountID() {
    var input = new Chain();
    input.setName("coconuts");
    input.setState(ChainState.FABRICATE);
    input.setType(ChainType.PRODUCTION);
    input.startAt("2009-08-12T12:17:02.527142Z");
    input.stopAt("2009-09-11T12:17:01.047563Z");

    Exception thrown = assertThrows(ManagerValidationException.class, () ->
      subject.update(chain2.getId(), input));

    assertEquals("Account ID is required.", thrown.getMessage());

  }

  @Test
  public void update_FailsWithoutName() {
    var input = new Chain();
    input.setId(UUID.randomUUID());
    input.setAccountId(account1.getId());
    input.setState(ChainState.DRAFT);
    input.setType(ChainType.PRODUCTION);
    input.startAt("2009-08-12T12:17:02.527142Z");
    input.stopAt("2009-09-11T12:17:01.047563Z");

    Exception thrown = assertThrows(ManagerValidationException.class, () ->
      subject.update(chain2.getId(), input));

    assertEquals("Name is required.", thrown.getMessage());

  }

  @Test
  public void update_CannotChangeAccount() throws Exception {
    var input = new Chain();
    input.setId(UUID.randomUUID());
    input.setAccountId(account1.getId());
    input.setName("coconuts");
    input.setState(ChainState.COMPLETE);
    input.setType(ChainType.PRODUCTION);
    input.startAt("2009-08-12T12:17:02.527142Z");
    input.stopAt("2009-09-11T12:17:01.047563Z");

    subject.update(chain2.getId(), input);

    var result = subject.readOne(chain2.getId());
    assertNotNull(result);
    assertEquals(account1.getId(), result.getAccountId());
  }

  @Test
  public void updateState() throws Exception {
    subject.updateState(chain2.getId(), ChainState.COMPLETE);

    var result = subject.readOne(chain2.getId());
    assertNotNull(result);
    assertEquals(ChainState.COMPLETE, result.getState());
  }

  @Test
  public void updateState_WithAccountAccess() throws Exception {
    subject.updateState(chain2.getId(), ChainState.COMPLETE);

    var result = subject.readOne(chain2.getId());
    assertNotNull(result);
    assertEquals(ChainState.COMPLETE, result.getState());
  }

  @Test
  public void buildNextSegmentOrComplete_chainWithSegmentsReadyForNextSegment() throws Exception {
    chain1 = store.put(buildChain(account1, "Test Print #2", ChainType.PRODUCTION, ChainState.FABRICATE, template1, Instant.parse("2014-02-14T12:03:40.000001Z"), Instant.parse("2014-02-14T14:03:40.000001Z"), null));
    var seg = new Segment();
    seg.setId(UUID.randomUUID());
    seg.setChainId(chain1.getId());
    seg.setOffset(5L);
    seg.setState(SegmentState.CRAFTING);
    seg.setKey("E minor");
    seg.setTotal(64);
    seg.setDensity(0.41);
    seg.setType(SegmentType.NEXTMAIN);
    seg.setBeginAt("2014-02-14T12:03:40.000001Z");
    seg.setEndAt("2014-02-14T12:04:10.000001Z");
    seg.setTempo(120.0);
    seg.storageKey("chains-1-segments-9f7s89d8a7892.wav");
    store.put(seg);

    Segment result = subject.buildNextSegmentOrCompleteTheChain(chain1, Instant.parse("2014-02-14T12:03:40.000001Z"), Instant.parse("2014-02-14T11:53:40.000001Z")).orElseThrow();

    assertEquals(chain1.getId(), result.getChainId());
    assertEquals(Long.valueOf(6), result.getOffset());
    assertEquals("2014-02-14T12:04:10.000001Z", result.getBeginAt());
    assertEquals(SegmentType.PENDING, result.getType());
  }

  @Test
  public void buildNextSegmentOrComplete_chainWithSegmentsReadyForNextSegment_butChainIsAlreadyFull_butNotSoLongEnoughToBeComplete() throws Exception {
    chain1 = store.put(buildChain(account1, "Test Print #2", ChainType.PRODUCTION, ChainState.FABRICATE, template2, Instant.parse("2014-02-14T12:03:40.000001Z"), Instant.parse("2014-02-14T14:03:40.000001Z"), null));
    var seg = new Segment();
    seg.setId(UUID.randomUUID());
    seg.setChainId(chain1.getId());
    seg.setOffset(5L);
    seg.setType(SegmentType.NEXTMAIN);
    seg.beginAt("2014-02-14T12:03:40.000001Z");
    seg.endAt("2014-02-14T12:03:50.000001Z");
    seg.setState(SegmentState.CRAFTING);
    seg.setKey("E minor");
    seg.setTotal(64);
    seg.setDensity(0.41);
    seg.setTempo(120.0);
    seg.storageKey("chains-1-segments-9f7s89d8a7892.wav");
    store.put(seg);

    Segment result = subject.buildNextSegmentOrCompleteTheChain(chain1, Instant.parse("2014-02-14T14:03:50.000001Z"), Instant.parse("2014-02-14T13:53:50.000001Z")).orElseThrow();

    var resultChain = subject.readOne(chain1.getId());
    assertNotNull(resultChain);
    assertEquals(ChainState.FABRICATE, resultChain.getState());
    assertEquals(SegmentType.PENDING, result.getType());
  }

  @Test
  public void buildNextSegmentOrComplete_chainWithSegmentsReadyForNextSegment_butChainIsAlreadyFull_andGetsUpdatedToComplete() throws Exception {
    chain1 = store.put(buildChain(account1, "Test Print #2", ChainType.PRODUCTION, ChainState.FABRICATE, template2, Instant.parse("2014-02-14T12:03:40.000001Z"), Instant.parse("2014-02-14T14:03:40.000001Z"), null));
    var seg = new Segment();
    seg.setId(UUID.randomUUID());
    seg.setChainId(chain1.getId());
    seg.setType(SegmentType.NEXTMAIN);
    seg.beginAt("2014-02-14T14:03:35.000001Z");
    seg.endAt("2014-02-14T14:03:55.000001Z");
    seg.setOffset(5L);
    seg.setState(SegmentState.DUBBED);
    seg.setKey("E minor");
    seg.setTotal(64);
    seg.setDensity(0.41);
    seg.setTempo(120.0);
    seg.storageKey("chains-1-segments-9f7s89d8a7892.wav");
    store.put(seg);

    Optional<Segment> result = subject.buildNextSegmentOrCompleteTheChain(chain1, Instant.parse("2014-02-14T14:03:50.000001Z"), Instant.parse("2014-02-14T14:15:50.000001Z"));

    assertTrue(result.isEmpty());
    var resultFinal = subject.readOne(chain1.getId());
    assertNotNull(resultFinal);
    assertEquals(ChainState.COMPLETE, resultFinal.getState());
  }

  @Test
  public void buildNextSegmentOrComplete_chainWithSegmentsReadyForNextSegment_butChainIsAlreadyFull_butCantKnowBecauseBoundsProvidedAreNull() throws Exception {
    chain1 = store.put(buildChain(account1, "Test Print #2", ChainType.PRODUCTION, ChainState.FABRICATE, template1, Instant.parse("2014-02-14T12:03:40.000001Z"), Instant.parse("2014-02-14T14:03:40.000001Z"), null));
    var seg = new Segment();
    seg.setId(UUID.randomUUID());
    seg.setChainId(chain1.getId());
    seg.beginAt("2014-02-14T14:03:15.000001Z");
    seg.endAt("2014-02-14T14:03:25.000001Z");
    seg.setOffset(5L);
    seg.setType(SegmentType.NEXTMAIN);
    seg.setState(SegmentState.DUBBED);
    seg.setKey("E minor");
    seg.setTotal(64);
    seg.setDensity(0.41);
    seg.setTempo(120.0);
    seg.storageKey("chains-1-segments-9f7s89d8a7892.wav");
    store.put(seg);

    Segment result = subject.buildNextSegmentOrCompleteTheChain(chain1, Instant.parse("2014-02-14T14:03:50.000001Z"), Instant.parse("2014-02-14T14:15:50.000001Z")).orElseThrow();

    var resultFinal = subject.readOne(chain1.getId());
    assertNotNull(resultFinal);
    assertEquals(ChainState.FABRICATE, resultFinal.getState());
    assertEquals(SegmentType.PENDING, result.getType());
  }

  @Test
  public void buildNextSegmentOrComplete_chainWithSegmentsAlreadyHasNextSegment() throws Exception {
    chain1 = store.put(buildChain(account1, "Test Print #2", ChainType.PRODUCTION, ChainState.FABRICATE, template1, Instant.parse("2014-02-14T12:03:40.000001Z"), Instant.parse("2014-02-14T14:03:40.000001Z"), null));
    var seg = new Segment();
    seg.setId(UUID.randomUUID());
    seg.setChainId(chain1.getId());
    seg.beginAt("2014-02-14T14:03:15.000001Z");
    seg.endAt("2014-02-14T14:05:40.000001Z"); // after chain stop-at, that's what triggers the chain to be completed
    seg.setOffset(5L);
    seg.setType(SegmentType.NEXTMAIN);
    seg.setState(SegmentState.DUBBED);
    seg.setKey("E minor");
    seg.setTotal(64);
    seg.setDensity(0.41);
    seg.setTempo(120.0);
    seg.storageKey("chains-1-segments-9f7s89d8a7892.wav");
    store.put(seg);

    Optional<Segment> result = subject.buildNextSegmentOrCompleteTheChain(chain1, Instant.parse("2014-08-12T14:03:38.000001Z"), Instant.parse("2014-08-12T13:53:38.000001Z"));

    assertTrue(result.isEmpty());
  }

  @Test
  public void buildNextSegmentOrComplete_chainEndingInCraftedSegment() throws Exception {
    var fromChain = store.put(buildChain(account1, "Test Print #2", ChainType.PRODUCTION, ChainState.FABRICATE, template1, Instant.parse("2014-08-12T12:17:02.527142Z"), Instant.parse("2014-09-11T12:17:01.047563Z"), null));
    store.put(buildSegment(fromChain, 5, SegmentState.CRAFTED, Instant.parse("2014-08-12T12:17:02.527142Z"), Instant.parse("2014-08-12T14:03:38.000001Z"), "A major", 64, 0.52, 120.0, "chains-1-segments-9f7s89d8a7892.wav", "OGG"));

    Segment result = subject.buildNextSegmentOrCompleteTheChain(fromChain, Instant.parse("2014-08-12T14:03:38.000001Z"), Instant.parse("2014-08-12T13:53:38.000001Z")).orElseThrow();

    assertEquals(fromChain.getId(), result.getChainId());
    assertEquals(Long.valueOf(6), result.getOffset());
    assertEquals("2014-08-12T14:03:38.000001Z", result.getBeginAt());
  }

  @Test
  public void buildNextSegmentOrComplete_newEmptyChain() throws Exception {
    store.put(buildChain(account1, "Test Print #2", ChainType.PRODUCTION, ChainState.READY, template1, Instant.parse("2014-08-12T12:17:02.527142Z"), null, null));
    var fromChain = new Chain();
    fromChain.setId(UUID.randomUUID());
    fromChain.setType(ChainType.PRODUCTION);
    fromChain.startAt("2014-08-12T12:17:02.527142Z");
    store.put(fromChain);

    Segment result = subject.buildNextSegmentOrCompleteTheChain(fromChain, Instant.parse("2014-08-12T14:03:38.000001Z"), Instant.parse("2014-08-12T13:53:38.000001Z")).orElseThrow();

    assertEquals(fromChain.getId(), result.getChainId());
    assertEquals(Long.valueOf(0), result.getOffset());
    assertEquals("2014-08-12T12:17:02.527142Z", result.getBeginAt());
  }

  @Test
  public void destroy() throws Exception {
    subject.destroy(chain1.getId());

    try {
      subject.readOne(chain1.getId());
      fail();
    } catch (ManagerExistenceException e) {
      assertTrue("Record should not exist", e.getMessage().contains("does not exist"));
    }
  }

  @Test
  public void destroy_SucceedsEvenWithChildren() throws Exception {
    buildLibrary(account1, "nerds");

    try {
      subject.destroy(chain1.getId());

    } catch (Exception e) {
      var result = subject.readOne(chain1.getId());
      assertNotNull(result);
      throw e;
    }
  }

}
