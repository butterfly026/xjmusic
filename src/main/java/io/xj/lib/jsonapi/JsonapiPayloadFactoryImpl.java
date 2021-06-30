// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.

package io.xj.lib.jsonapi;

import com.google.common.collect.ImmutableList;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.google.inject.Inject;
import com.google.inject.Singleton;
import com.google.protobuf.MessageLite;
import io.xj.lib.entity.Entities;
import io.xj.lib.entity.EntityException;
import io.xj.lib.entity.EntityFactory;

import java.io.BufferedReader;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Comparator;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Optional;
import java.util.function.Function;
import java.util.function.Predicate;
import java.util.stream.Collectors;

/**
 Implementation of JSON:API
 and a wrapper for all generic JSON ser/des
 FUTURE: deprecate all JSON:API in favor of only generic JSON
 <p>
 Created by Charney Kaye on 2020/03/09
 */
@Singleton
public class JsonapiPayloadFactoryImpl implements JsonapiPayloadFactory {
  private final EntityFactory entityFactory;

  @Inject
  JsonapiPayloadFactoryImpl(
    EntityFactory entityFactory
  ) {
    this.entityFactory = entityFactory;
  }

  @Override
  public <N extends MessageLite> N consume(N target, JsonapiPayload jsonapiPayload) throws JsonApiException {
    return consume(target, extractPrimaryObject(jsonapiPayload, Entities.toType(target)));
  }

  @Override
  public <N extends MessageLite> N consume(N instance, JsonapiPayloadObject jsonapiPayloadObject) throws JsonApiException {
    try {
      String targetType = Entities.toType(instance);
      if (!Objects.equals(jsonapiPayloadObject.getType(), targetType))
        throw new JsonApiException(String.format("Cannot set single %s-type entity create %s-type payload object!", targetType, jsonapiPayloadObject.getType()));
      MessageLite.Builder target = instance.toBuilder();

      for (Map.Entry<String, Object> entry : jsonapiPayloadObject.getAttributes().entrySet())
        Entities.set(target, entry.getKey(), entry.getValue());

      // consume all belongs-to relationships
      entityFactory.getBelongsTo(targetType).forEach(key -> {
        Optional<JsonapiPayloadObject> obj = jsonapiPayloadObject.getRelationshipDataOne(key);
        obj.ifPresent(object -> {
          try {
            Entities.set(target, Entities.toIdAttribute(key), object.getId());
          } catch (EntityException ignored) {
            // n/a -- objects can be created with missing relationships
          }
        });
      });

      // consume if if set
      if (Objects.nonNull(jsonapiPayloadObject.getId())) try {
        Entities.set(target, "id", jsonapiPayloadObject.getId());
      } catch (IllegalArgumentException ignored) {
        // n/a -- objects can be created without ID
      }

      //noinspection unchecked
      return (N) target.build();
    } catch (EntityException e) {
      throw new JsonApiException(e);
    }
  }

  @Override
  public <N> JsonapiPayloadObject toPayloadObject(N target) throws JsonApiException {
    return toPayloadObject(target, ImmutableList.of());
  }

  @Override
  public <N> Collection<JsonapiPayloadObject> toPayloadObjects(Collection<N> targets) throws JsonApiException {
    List<JsonapiPayloadObject> list = new ArrayList<>();
    for (N target : targets) list.add(toPayloadObject(target));
    return list;
  }

  @Override
  public <N> JsonapiPayloadObject toPayloadObject(N target, Collection<N> childResources) throws JsonApiException {
    try {
      String targetType = Entities.toType(target);
      JsonapiPayloadObject obj = toPayloadReferenceObject(target);
      obj.setAttributes(entityFactory.getResourceAttributes(target));

      // add belongs-to
      for (String s : entityFactory.getBelongsTo(targetType)) {
        Optional<Object> value = Entities.get(target, Entities.toIdAttribute(s));
        value.ifPresent(id -> obj.add(Entities.toBelongsTo(s),
          new JsonapiPayload().setDataReference(Entities.toType(s), String.valueOf(id))));
      }

      // add has-many
      Map<String, Collection<N>> hasMany = Maps.newConcurrentMap();
      childResources.forEach(resource -> {
        String type = Entities.toType(resource);
        if (!hasMany.containsKey(type)) hasMany.put(type, Lists.newArrayList());
        hasMany.get(type).add(resource);
      });
      for (String key : entityFactory.getHasMany(targetType)) {
        String type = Entities.toType(key);
        if (hasMany.containsKey(type) && !hasMany.get(type).isEmpty())
          obj.add(Entities.toHasMany(key),
            setDataReferences(newJsonapiPayload(), hasMany.containsKey(type) ?
              hasMany.get(type).stream().filter(r -> belongsTo(r, target)).collect(Collectors.toList()) :
              ImmutableList.of()));
      }

      return obj;
    } catch (EntityException e) {
      throw new JsonApiException(e);
    }
  }

  @Override
  public JsonapiPayload newJsonapiPayload() {
    return new JsonapiPayload();
  }

  @Override
  public JsonapiPayloadObject newPayloadObject() {
    return new JsonapiPayloadObject();
  }

  @Override
  public PayloadError newPayloadError() {
    return new PayloadError();
  }

  @Override
  public <N> JsonapiPayloadObject toPayloadReferenceObject(N target) throws JsonApiException {
    return new JsonapiPayloadObject()
      .setId(getResourceId(target))
      .setType(Entities.toType(target));
  }

  @Override
  public <N> JsonapiPayload addIncluded(JsonapiPayload jsonapiPayload, Collection<N> resources) throws JsonApiException {
    for (N resource : resources) {
      JsonapiPayloadObject jsonapiPayloadObject = toPayloadObject(resource, resources);
      addIncluded(jsonapiPayload, jsonapiPayloadObject);
    }
    return jsonapiPayload;
  }

  @Override
  public JsonapiPayload addIncluded(JsonapiPayload jsonapiPayload, JsonapiPayloadObject jsonapiPayloadObject) throws JsonApiException {
    switch (jsonapiPayload.getDataType()) {
      case Many:
        for (JsonapiPayloadObject obj : jsonapiPayload.getDataMany())
          addIfRelated(obj, jsonapiPayloadObject);
        break;
      case One:
        if (jsonapiPayload.getDataOne().isPresent())
          addIfRelated(jsonapiPayload.getDataOne().get(), jsonapiPayloadObject);
        break;
      case Ambiguous:
        break;
    }
    jsonapiPayload.getIncluded().add(jsonapiPayloadObject);
    return jsonapiPayload;
  }

  @Override
  public void addIfRelated(JsonapiPayloadObject obj, JsonapiPayloadObject rel) throws JsonApiException {
    String hasMany = Entities.toHasManyFromType(rel.getType());
    String belongsTo = Entities.toBelongsToFromType(obj.getType());
    if (rel.getRelationships().containsKey(belongsTo)) {
      Optional<JsonapiPayloadObject> search = rel.getRelationships().get(belongsTo).getDataOne();
      if (search.isPresent()
        && search.get().getType().equals(obj.getType())
        && search.get().getId().equals(obj.getId())) {
        add(obj, hasMany, rel.toMinimal());
      }
    }
  }


  @Override
  public <N> JsonapiPayload setDataEntities(JsonapiPayload jsonapiPayload, Collection<N> entities) throws JsonApiException {
    jsonapiPayload.clear();
    jsonapiPayload.setDataType(PayloadDataType.Many);
    for (N entity : entities)
      jsonapiPayload.addData(toPayloadObject(entity));
    return jsonapiPayload;
  }

  @Override
  public <N> JsonapiPayload setDataEntity(JsonapiPayload jsonapiPayload, N entity) throws JsonApiException {
    jsonapiPayload.clear();
    jsonapiPayload.setDataOne(toPayloadObject(entity));
    return jsonapiPayload;
  }

  @Override
  public <N> JsonapiPayload setDataReferences(JsonapiPayload jsonapiPayload, Collection<N> entities) throws JsonApiException {
    jsonapiPayload.setDataType(PayloadDataType.Many);
    for (N resource : entities) {
      JsonapiPayloadObject jsonapiPayloadObject = toPayloadReferenceObject(resource);
      jsonapiPayload.addData(jsonapiPayloadObject);
    }
    return jsonapiPayload;
  }

  @Override
  public JsonapiPayloadObject add(JsonapiPayloadObject obj, String relationshipName, JsonapiPayloadObject jsonapiPayloadObject) throws JsonApiException {
    if (!obj.getRelationships().containsKey(relationshipName))
      obj.getRelationships().put(relationshipName, setDataReferences(newJsonapiPayload(), ImmutableList.of()));
    obj.getRelationships().get(relationshipName).addToDataMany(jsonapiPayloadObject);
    return obj;
  }

  @Override
  public JsonapiPayload filter(JsonapiPayload jsonapiPayload, Class<?> type, Predicate<? super JsonapiPayloadObject> condition) throws JsonApiException {
    switch (jsonapiPayload.getDataType()) {

      case Many:
        Collection<JsonapiPayloadObject> hasMany =
          jsonapiPayload.getDataMany().stream()
            .filter(condition)
            .collect(Collectors.toList());
        Collection<JsonapiPayloadObject> included =
          jsonapiPayload.getIncluded().stream()
            .filter(obj -> obj.belongsTo(type, hasMany.stream()
              .filter(par -> par.isType(type))
              .map(JsonapiPayloadObject::getId)
              .collect(Collectors.joining())))
            .collect(Collectors.toList());
        return newJsonapiPayload()
          .setDataMany(hasMany)
          .setIncluded(included);

      case Ambiguous:
      case One:
      default:
        throw new JsonApiException("I only know how to filter data-many payloads!");
    }
  }

  @Override
  public JsonapiPayload filterIncluded(JsonapiPayload jsonapiPayload, Predicate<? super JsonapiPayloadObject> condition) throws JsonApiException {
    switch (jsonapiPayload.getDataType()) {

      case One:
        return newJsonapiPayload()
          .setDataOne(jsonapiPayload.getDataOne().orElseThrow(() ->
            new JsonApiException("cannot filter included entities of empty data-one payload!")))
          .setIncluded(jsonapiPayload.getIncluded().stream()
            .filter(condition)
            .collect(Collectors.toList()));

      case Many:
        return newJsonapiPayload()
          .setDataMany(jsonapiPayload.getDataMany())
          .setIncluded(jsonapiPayload.getIncluded().stream()
            .filter(condition)
            .collect(Collectors.toList()));

      case Ambiguous:
      default:
        throw new JsonApiException("cannot filter the included entities of an ambiguous payload!");
    }
  }

  @Override
  public JsonapiPayload sort(JsonapiPayload jsonapiPayload, Class<?> type, Function<? super JsonapiPayloadObject, Long> keyExtractor) throws JsonApiException {
    switch (jsonapiPayload.getDataType()) {

      case Many:
        Collection<JsonapiPayloadObject> hasMany =
          jsonapiPayload.getDataMany().stream()
            .sorted(Comparator.comparing(keyExtractor))
            .collect(Collectors.toList());
        Collection<JsonapiPayloadObject> included =
          jsonapiPayload.getIncluded().stream()
            .filter(obj -> obj.belongsTo(type, hasMany.stream()
              .filter(par -> par.isType(type))
              .map(JsonapiPayloadObject::getId)
              .collect(Collectors.joining())))
            .collect(Collectors.toList());
        return newJsonapiPayload()
          .setDataMany(hasMany)
          .setIncluded(included);

      case Ambiguous:
      case One:
      default:
        throw new JsonApiException("I only know how to filter data-many payloads!");
    }
  }

  @Override
  public JsonapiPayload limit(JsonapiPayload jsonapiPayload, Class<?> type, long limit) throws JsonApiException {
    switch (jsonapiPayload.getDataType()) {

      case Many:
        Collection<JsonapiPayloadObject> hasMany =
          jsonapiPayload.getDataMany().stream()
            .limit(limit)
            .collect(Collectors.toList());
        Collection<JsonapiPayloadObject> included =
          jsonapiPayload.getIncluded().stream()
            .filter(obj -> obj.belongsTo(type, hasMany.stream()
              .filter(par -> par.isType(type))
              .map(JsonapiPayloadObject::getId)
              .collect(Collectors.joining())))
            .collect(Collectors.toList());
        return newJsonapiPayload()
          .setDataMany(hasMany)
          .setIncluded(included);

      case Ambiguous:
      case One:
      default:
        throw new JsonApiException("can only filter data-many payloads!");
    }
  }

  @Override
  public JsonapiPayload find(JsonapiPayload jsonapiPayload, Class<?> type, Predicate<? super JsonapiPayloadObject> condition) throws JsonApiException {
    switch (jsonapiPayload.getDataType()) {

      case Many:
        JsonapiPayloadObject one =
          jsonapiPayload.getDataMany().stream()
            .filter(condition)
            .findFirst()
            .orElseThrow();
        Collection<JsonapiPayloadObject> included =
          jsonapiPayload.getIncluded().stream()
            .filter(obj -> obj.belongsTo(type, ImmutableList.of(one.getId())))
            .collect(Collectors.toList());
        return newJsonapiPayload()
          .setDataOne(one)
          .setIncluded(included);

      case Ambiguous:
      case One:
      default:
        throw new JsonApiException("can only find one from data-many payloads!");
    }
  }

  @Override
  public JsonapiPayload deserialize(String payloadAsJSON) throws JsonApiException {
    try {
      return entityFactory.deserialize(JsonapiPayload.class, payloadAsJSON);
    } catch (EntityException e) {
      throw new JsonApiException(e);
    }
  }

  @Override
  public JsonapiPayload deserialize(BufferedReader payloadReader) throws JsonApiException {
    String payloadAsJSON = payloadReader.lines().collect(Collectors.joining());
    try {
      return entityFactory.deserialize(JsonapiPayload.class, payloadAsJSON);
    } catch (EntityException e) {
      throw new JsonApiException(e);
    }
  }

  @Override
  public String serialize(Object obj) throws JsonApiException {
    try {
      return entityFactory.serialize(obj);
    } catch (EntityException e) {
      throw new JsonApiException("Failed to serialize JSON", e);
    }
  }

  @Override
  public <N extends MessageLite> N toOne(JsonapiPayloadObject jsonapiPayloadObject) throws JsonApiException {
    try {
      N defaultInstance = entityFactory.getInstance(jsonapiPayloadObject.getType());
      return consume(defaultInstance, jsonapiPayloadObject);
    } catch (EntityException e) {
      throw new JsonApiException(e);
    }
  }

  @Override
  public <N extends MessageLite> N toOne(JsonapiPayload jsonapiPayload) throws JsonApiException {
    return toOne(jsonapiPayload.getDataOne().orElseThrow(() ->
      new JsonApiException("Can only create instance from data-one payload!")));
  }

  @Override
  public <N extends MessageLite> Collection<N> toMany(JsonapiPayload jsonapiPayload) throws JsonApiException {
    if (!PayloadDataType.Many.equals(jsonapiPayload.getDataType()))
      throw new JsonApiException("Can only create instances from data-many payload!");
    Collection<N> instances = Lists.newArrayList();
    for (JsonapiPayloadObject jsonapiPayloadObject : jsonapiPayload.getDataMany())
      instances.add(toOne(jsonapiPayloadObject));
    for (JsonapiPayloadObject jsonapiPayloadObject : jsonapiPayload.getIncluded())
      instances.add(toOne(jsonapiPayloadObject));
    return instances;
  }

  @Override
  public <N extends MessageLite> JsonapiPayload from(N entity) throws JsonApiException {
    return newJsonapiPayload()
      .setDataOne(toPayloadObject(entity));
  }

  @Override
  public <N extends MessageLite> JsonapiPayload from(N entity, Collection<N> included) throws JsonApiException {
    return newJsonapiPayload()
      .setDataOne(toPayloadObject(entity))
      .setIncluded(toPayloadObjects(included));
  }

  @Override
  public <N extends MessageLite> JsonapiPayload from(Collection<N> entities) throws JsonApiException {
    return newJsonapiPayload()
      .setDataMany(toPayloadObjects(entities));
  }

  @Override
  public <N extends MessageLite> JsonapiPayload from(Collection<N> entities, Collection<N> included) throws JsonApiException {
    return newJsonapiPayload()
      .setDataMany(toPayloadObjects(entities))
      .setIncluded(toPayloadObjects(included));
  }

  /**
   Require a payload to have one resource object of a specified type

   @param jsonapiPayload to inspect
   @param resourceType   to require a primary object of
   @throws JsonApiException if there exists NO primary object of the specified type
   */
  private JsonapiPayloadObject extractPrimaryObject(JsonapiPayload jsonapiPayload, String resourceType) throws JsonApiException {
    Optional<JsonapiPayloadObject> obj = jsonapiPayload.getDataOne();
    if (obj.isEmpty())
      throw new JsonApiException("Cannot deserialize single entity create payload without singular data!");
    if (!Objects.equals(resourceType, obj.get().getType()))
      throw new JsonApiException(String.format("Cannot deserialize single %s-type entity create %s-type payload!", resourceType, obj.get().getType()));
    return obj.get();
  }

  /**
   Whether target resource belongs to the specified resource

   @param target   to test for parenthood
   @param resource to test whether target belongs to
   @return true if target belongs to the specified resource
   */
  private <N> boolean belongsTo(N target, N resource) {
    try {
      Optional<Object> id = Entities.get(target, Entities.toIdAttribute(resource));
      return id.isPresent() && id.get().equals(getResourceId(resource));
    } catch (JsonApiException | EntityException e) {
      return false;
    }
  }

  /**
   get Entity ID

   @return Entity Id
   */
  private <N> String getResourceId(N target) throws JsonApiException {
    try {
      Optional<Object> id = Entities.get(target, JsonapiPayloadObject.KEY_ID);
      if (id.isEmpty()) throw new JsonApiException("Has no id");
      return (id.get().toString());
    } catch (EntityException e) {
      throw new JsonApiException(e);
    }
  }
}