// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.lib.jsonapi;

import com.google.common.collect.ImmutableList;
import com.google.common.collect.Lists;
import io.xj.lib.entity.Entities;
import io.xj.lib.entity.EntityException;
import io.xj.lib.util.ValueException;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Optional;

import static io.xj.lib.util.Assert.assertEquals;
import static io.xj.lib.util.Assert.assertFalse;
import static io.xj.lib.util.Assert.assertTrue;


/**
 Assertion utilities for testing Payload sent/received to/from a XJ Music REST JSON:API service
 <p>
 Created by Charney Kaye on 2020/03/05
 */
public class AssertPayload {
  private final JsonapiPayload jsonapiPayload;

  /**
   of instance of payload assertion utility object

   @param jsonapiPayload to make assertions on
   */
  public AssertPayload(JsonapiPayload jsonapiPayload) {
    this.jsonapiPayload = jsonapiPayload;
  }

  /**
   of instance of payload assertion utility object of Payload

   @param jsonapiPayload to make assertions on
   @return payload assertion utility
   */
  public static AssertPayload assertPayload(JsonapiPayload jsonapiPayload) {
    return new AssertPayload(jsonapiPayload);
  }

  /**
   Assert the Payload has-many data, with the specified class + ids

   @param resourceType to assert
   @param resourceIds  to assert
   @return this Payload assertion utility (for chaining methods)
   @throws JsonApiException if assertion fails
   */
  public AssertPayload hasDataMany(String resourceType, Collection<String> resourceIds) throws JsonApiException {
    try {
      assertEquals("payload data type", PayloadDataType.Many, jsonapiPayload.getDataType());
      assertEquals("same number of ids", resourceIds.size(), jsonapiPayload.getDataMany().size());
      Collection<String> foundIds = Lists.newArrayList();
      for (JsonapiPayloadObject jsonapiPayloadObject : jsonapiPayload.getDataMany()) {
        assertFalse("already found id", foundIds.contains(jsonapiPayloadObject.getId()));
        assertEquals(String.format("unexpected %s", jsonapiPayloadObject.getType()), resourceType, jsonapiPayloadObject.getType());
        assertTrue(String.format("unexpected %s id=%s", resourceType, jsonapiPayloadObject.getId()), resourceIds.contains(jsonapiPayloadObject.getId()));
        foundIds.add(jsonapiPayloadObject.getId());
      }
      return this;

    } catch (ValueException e) {
      throw new JsonApiException(e);
    }
  }

  /**
   Assert the Payload has-many data, with an empty set

   @throws JsonApiException if assertion fails
   */
  public void hasDataManyEmpty() throws JsonApiException {
    try {
      assertEquals("payload data type", PayloadDataType.Many, jsonapiPayload.getDataType());
      assertEquals("empty set", 0, jsonapiPayload.getDataMany().size());

    } catch (ValueException e) {
      throw new JsonApiException(e);
    }
  }

  /**
   Assert the Payload has-one data, with the specified class + id

   @param resourceType to assert
   @param resourceId   to assert
   @return PayloadObject assertion utility, for further assertions on that payload object
   @throws JsonApiException if assertion fails
   */
  public AssertPayloadObject hasDataOne(String resourceType, String resourceId) throws JsonApiException {
    try {
      assertEquals("payload data type", PayloadDataType.One, jsonapiPayload.getDataType());
      Optional<JsonapiPayloadObject> dataOne = jsonapiPayload.getDataOne();
      assertTrue("has one data", dataOne.isPresent());
      assertEquals("payload object type", resourceType, dataOne.orElseThrow().getType());
      assertEquals("payload object id", resourceId, dataOne.get().getId());
      return new AssertPayloadObject(dataOne.get());

    } catch (ValueException e) {
      throw new JsonApiException(e);
    }
  }

  /**
   Assert the Payload has-one data, with the specified class + id

   @param resource to assert
   @return PayloadObject assertion utility, for further assertions on that payload object
   @throws JsonApiException if assertion fails
   */
  public <N> AssertPayloadObject hasDataOne(N resource) throws JsonApiException {
    try {
      assertEquals("payload data type", PayloadDataType.One, jsonapiPayload.getDataType());
      Optional<JsonapiPayloadObject> dataOne = jsonapiPayload.getDataOne();
      assertTrue("has one data", dataOne.isPresent());
      assertTrue(String.format("one data same as %s id=%s", Entities.toType(resource), Entities.getId(resource)), dataOne.orElseThrow().isSame(resource));
      return new AssertPayloadObject(dataOne.get());

    } catch (EntityException | ValueException e) {
      throw new JsonApiException(e);
    }
  }

  /**
   Assert the Payload has-one data, with empty (null) specified

   @throws JsonApiException if assertion fails
   */
  public void hasDataOneEmpty() throws JsonApiException {
    try {
      assertEquals("payload data type", PayloadDataType.One, jsonapiPayload.getDataType());
      Optional<JsonapiPayloadObject> dataOne = jsonapiPayload.getDataOne();
      assertTrue("has empty data", dataOne.isEmpty());

    } catch (ValueException e) {
      throw new JsonApiException(e);
    }
  }

  /**
   Assert has specified number of errors

   @param errorCount to assert
   @return this Payload assertion utility (for chaining methods)
   @throws JsonApiException if assertion fails
   */
  public AssertPayload hasErrorCount(int errorCount) throws JsonApiException {
    try {
      assertEquals("payload errors count", errorCount, jsonapiPayload.getErrors().size());
      return this;

    } catch (ValueException e) {
      throw new JsonApiException(e);
    }
  }

  /**
   Assert has included entity, and return a payload object assertion utility to make assertions about it

   @param resource to assert is included
   @param <N>      type of resource
   @return payload object assertion utility
   */
  public <N> AssertPayloadObject hasIncluded(N resource) throws JsonApiException {
    try {
      Optional<JsonapiPayloadObject> payloadObject = jsonapiPayload.getIncluded().stream().filter(obj -> obj.isSame(resource)).findFirst();
      assertTrue(String.format("has included %s id=%s", Entities.toType(resource), Entities.getId(resource)), payloadObject.isPresent());
      assertTrue("payload object exists", payloadObject.isPresent());
      return new AssertPayloadObject(payloadObject.orElseThrow());

    } catch (EntityException | ValueException e) {
      throw new JsonApiException(e);
    }
  }

  /**
   Assert has included entities

   @param resourceType to assert
   @param resources    to assert
   @return this Payload assertion utility (for chaining methods)
   */
  public <N> AssertPayload hasIncluded(String resourceType, ImmutableList<N> resources) throws JsonApiException {
    try {
      Collection<JsonapiPayloadObject> included = jsonapiPayload.getIncludedOfType(resourceType);
      assertEquals("same number of ids", resources.size(), included.size());
      Collection<String> foundIds = Lists.newArrayList();
      Collection<String> resourceIds = new ArrayList<>();
      for (N resource : resources) {
        String resourceId = Entities.getId(resource);
        resourceIds.add(resourceId);
      }
      for (JsonapiPayloadObject jsonapiPayloadObject : included) {
        assertFalse("already found id", foundIds.contains(jsonapiPayloadObject.getId()));
        assertEquals(String.format("unexpected %s", jsonapiPayloadObject.getType()), resourceType, jsonapiPayloadObject.getType());
        assertTrue(String.format("unexpected %s id=%s", resourceType, jsonapiPayloadObject.getId()), resourceIds.contains(jsonapiPayloadObject.getId()));
        foundIds.add(jsonapiPayloadObject.getId());
      }
      return this;
    } catch (EntityException | ValueException e) {
      throw new JsonApiException(e);
    }
  }

}