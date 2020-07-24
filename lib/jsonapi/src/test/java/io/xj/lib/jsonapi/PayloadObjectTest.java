// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.lib.jsonapi;

import com.google.common.collect.ImmutableList;
import com.google.common.collect.ImmutableMap;
import com.google.common.collect.Maps;
import com.google.inject.Guice;
import com.google.inject.Injector;
import io.xj.lib.entity.EntityFactory;
import io.xj.lib.util.ValueException;
import org.junit.Before;
import org.junit.Test;

import java.io.IOException;
import java.util.Map;
import java.util.UUID;

import static io.xj.lib.jsonapi.AssertPayloadObject.assertPayloadObject;
import static io.xj.lib.util.Assert.assertSameItems;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

/**
 Payload object test
 <p>
 Created by Charney Kaye on 2020/03/09
 */
public class PayloadObjectTest extends TestTemplate {
  PayloadFactory payloadFactory;
  EntityFactory entityFactory;
  PayloadObject subject;

  @Before
  public void setUp() {
    Injector injector = Guice.createInjector(new JsonApiModule());
    payloadFactory = injector.getInstance(PayloadFactory.class);
    entityFactory = injector.getInstance(EntityFactory.class);
    entityFactory.register(MockEntity.class);
    subject = payloadFactory.newPayloadObject();
  }

  @Test
  public void add() throws JsonApiException {
    MockEntity parentEntity1 = createMockEntity("Test MockEntity");
    subject.add("parentEntity", payloadFactory.setDataEntity(payloadFactory.newPayload(), parentEntity1));

    assertTrue(subject.getRelationships().get("parentEntity").getDataOne().isPresent());
    assertEquals(parentEntity1.getId().toString(), subject.getRelationships().get("parentEntity").getDataOne().get().getId());
  }

  @Test
  public void addIfRelated() throws IOException, JsonApiException {
    MockEntity mockEntity1 = createMockEntity("test.jpg");
    MockEntity mockEntity2 = createMockEntity("sham", mockEntity1);
    entityFactory.register(MockEntity.class).belongsTo(MockEntity.class);
    subject = payloadFactory.toPayloadObject(mockEntity1);
    PayloadObject rel = payloadFactory.toPayloadObject(mockEntity2);

    payloadFactory.addIfRelated(subject, rel);

    assertPayloadObject(subject)
      .hasMany(MockEntity.class, ImmutableList.of(mockEntity2));
  }

  @Test
  public void getAttribute_setAttribute() {
    subject
      .setAttribute("swanky", 23)
      .setAttribute("times", 52);

    assertTrue(subject.getAttribute("swanky").isPresent());
    assertEquals(23, subject.getAttribute("swanky").get());
  }

  @Test
  public void toMinimal() throws JsonApiException {
    MockEntity parentEntity1 = createMockEntity("Test MockEntity");
    subject = payloadFactory.toPayloadObject(parentEntity1);

    PayloadObject result = subject.toMinimal();

    assertEquals(subject.getType(), result.getType());
    assertEquals(subject.getId(), result.getId());
    assertFalse(result.getAttributes().containsKey("name"));
  }

  @Test
  public void getAttributes_setAttributes() throws ValueException {
    Map<String, Object> attr = ImmutableMap.of(
      "kittens", "cute",
      "puppies", 5
    );
    subject.setAttributes(attr);

    assertSameItems(attr, subject.getAttributes());
  }

  @Test
  public void getId_setId() {
    subject.setId("15");

    assertEquals("15", subject.getId());
  }

  @Test
  public void getLinks_setLinks() throws ValueException {
    Map<String, String> links = ImmutableMap.of(
      "kittens", "https://kittens.com/",
      "puppies", "https://puppies.com/"
    );
    subject.setLinks(links);

    assertSameItems(links, subject.getLinks());
  }

  @Test
  public void getRelationshipObject() throws JsonApiException {
    MockEntity parentEntity1 = createMockEntity("Test MockEntity");
    subject.add("parentEntity", payloadFactory.setDataEntity(payloadFactory.newPayload(), parentEntity1));

    assertTrue(subject.getRelationshipDataOne("parentEntity").isPresent());
    assertEquals(parentEntity1.getId().toString(), subject.getRelationshipDataOne("parentEntity").get().getId());
  }

  @Test
  public void getRelationships_setRelationships() throws JsonApiException {
    subject.setRelationships(ImmutableMap.of(
      "parentEntity", payloadFactory.setDataEntity(payloadFactory.newPayload(), createMockEntity("Test MockEntity")),
      "childEntity", payloadFactory.setDataEntity(payloadFactory.newPayload(), createMockEntity("Test MockEntity"))
    ));

    assertEquals(2, subject.getRelationships().size());
  }

  @Test
  public void getType_setType() {
    subject.setType("mock-entities");

    assertEquals("mock-entities", subject.getType());
  }

  @Test
  public void setType_fromClass() {
    assertEquals("mock-entities", subject.setType(MockEntity.class).getType());
  }

  @Test
  public void setAttributes_nullValueSetsNullValueInstance() throws ValueException {
    Map<String, Object> attr = Maps.newHashMap();
    attr.put("kittens", "cute");
    attr.put("puppies", null);
    subject.setAttributes(attr);

    assertSameItems(attr, subject.getAttributes());
  }

  @Test
  public void isSame() {
    UUID id = UUID.randomUUID();
    subject.setId(id.toString());
    subject.setType("MockEntity");

    assertTrue(subject.isSame(createMockEntity(id)));
    assertFalse(subject.isSame(createMockEntity(UUID.randomUUID())));
  }

  @Test
  public void isSame_subjectStringId_compareToUuid() {
    UUID id = UUID.randomUUID();
    subject.setId(id.toString());
    subject.setType("MockSuperEntity");
    MockSuperEntity compareTo = new MockSuperEntity();
    compareTo.setId(id);

    assertTrue(subject.isSame(compareTo));
  }

}