// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.

package io.xj.hub.entity;

import io.xj.hub.json.JsonProvider;
import io.xj.hub.util.ValueUtils;
import org.reflections.ReflectionUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.lang.reflect.Modifier;
import java.util.Collection;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Optional;
import java.util.Set;
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;
import java.util.function.Supplier;

/**
 Implementation of Entity Factory
 <p>
 Created by Charney Kaye on 2020/03/09
 */
public class EntityFactoryImpl implements EntityFactory {
  static final Logger LOG = LoggerFactory.getLogger(EntityFactoryImpl.class);
  static final List<String> IGNORE_ATTRIBUTES = List.of("id", "class");
  final JsonProvider jsonProvider;
  Map<String, EntitySchema> schema = new ConcurrentHashMap<>();

  public EntityFactoryImpl(
    JsonProvider jsonProvider
  ) {
    this.jsonProvider = jsonProvider;
  }

  @Override
  public EntitySchema register(String type) {
    String key = EntityUtils.toType(type);
    if (schema.containsKey(key)) return schema.get(key);
    EntitySchema entitySchema = EntitySchema.of(type);
    schema.put(key, entitySchema);
    return entitySchema;
  }

  @Override
  public EntitySchema register(Class<?> typeClass) {
    String key = EntityUtils.toType(typeClass);
    if (schema.containsKey(key)) return schema.get(key);
    EntitySchema entitySchema = EntitySchema.of(typeClass);
    schema.put(key, entitySchema);
    return entitySchema;
  }

  @Override
  public <N> N getInstance(String type) throws EntityException {
    String key = EntityUtils.toType(type);
    ensureSchemaExists("get instance", key);
    @SuppressWarnings("unchecked") Supplier<N> creator = (Supplier<N>) schema.get(key).getCreator();
    if (Objects.isNull(creator))
      throw new EntityException(String.format("Failed to locate instance provider for %s", type));
    return creator.get();
  }

  @Override
  public <N> N getInstance(Class<N> type) throws EntityException {
    return getInstance(EntityUtils.toType(type));
  }

  @Override
  public Set<String> getBelongsTo(String type) throws EntityException {
    String key = EntityUtils.toType(type);
    ensureSchemaExists("get belongs-to type", key);
    return schema.get(key).getBelongsTo();
  }

  @Override
  public Set<String> getHasMany(String type) throws EntityException {
    String key = EntityUtils.toType(type);
    ensureSchemaExists("get has-many type", key);
    return schema.get(key).getHasMany();
  }

  @Override
  public Set<String> getAttributes(String type) throws EntityException {
    String key = EntityUtils.toType(type);
    ensureSchemaExists("get attribute", key);
    return schema.get(key).getAttributes();
  }

  @Override
  public <N> Map<String, Object> getResourceAttributes(N target) {
    Map<String, Object> attributes = new HashMap<>();
    //noinspection unchecked
    ReflectionUtils.getAllMethods(target.getClass(),
      ReflectionUtils.withModifier(Modifier.PUBLIC),
      ReflectionUtils.withPrefix("get"),
      ReflectionUtils.withParametersCount(0)).forEach(method -> {
      try {
        String attributeName = EntityUtils.toAttributeName(method);
        if (!IGNORE_ATTRIBUTES.contains(attributeName))
          EntityUtils.get(target, method).ifPresentOrElse(value -> attributes.put(attributeName, value),
            () -> attributes.put(attributeName, null));
      } catch (Exception e) {
        LOG.warn("Failed to transmogrify value create method {} create entity {}", method, target, e);
      }
    });
    return attributes;
  }

  @Override
  public <N> void setAllAttributes(N source, N target) {
    getResourceAttributes(source).forEach((Object name, Object attribute) -> {
      try {
        EntityUtils.set(target, String.valueOf(name), attribute);
      } catch (Exception e) {
        LOG.error("Failed to set {}", attribute, e);
      }
    });
  }

  @Override
  public <N> void setAllEmptyAttributes(N source, N target) {
    getResourceAttributes(source).forEach((Object name, Object value) -> {
      try {
        var tgtVal = EntityUtils.get(target, String.valueOf(name));
        if (tgtVal.isEmpty() || ValueUtils.isEmpty(tgtVal.get()))
          EntityUtils.set(target, String.valueOf(name), value);
      } catch (Exception e) {
        LOG.error("Failed to set {}", value, e);
      }
    });
  }

  @Override
  public <N> N clone(N from) throws EntityException {
    var clone = copy(from);
    EntityUtils.setId(clone, UUID.randomUUID());
    return clone;
  }

  @Override
  public <N> Map<UUID, N> cloneAll(Collection<N> entities) throws EntityException {
    try {
      Map<UUID, N> clones = new HashMap<>();
      for (N entity : entities) clones.put(EntityUtils.getId(entity), clone(entity));
      return clones;
    } catch (Exception e) {
      throw new EntityException(e);
    }
  }

  @Override
  public <N> Map<UUID, N> cloneAll(Collection<N> entities, Collection<?> newRelationships) throws EntityException {
    try {
      Map<UUID, N> clones = new HashMap<>();
      for (N entity : entities) {
        var clone = clone(entity);
        for (Object newRelationship : newRelationships)
          EntityUtils.set(clone, EntityUtils.toIdAttribute(newRelationship.getClass().getSimpleName()), EntityUtils.getId(newRelationship));
        clones.put(EntityUtils.getId(entity), clone);
      }
      return clones;
    } catch (Exception e) {
      throw new EntityException(e);
    }
  }

  @Override
  public <N> N copy(N from) throws EntityException {
    try {
      String className = from.getClass().getSimpleName();
      Object builder = getInstance(className);
      EntityUtils.setId(builder, EntityUtils.getId(from));
      setAllAttributes(from, builder);
      for (String belongsTo : getBelongsTo(className)) {
        Optional<UUID> belongsToId = EntityUtils.getBelongsToId(from, belongsTo);
        if (belongsToId.isPresent())
          EntityUtils.set(builder, EntityUtils.toIdAttribute(belongsTo), belongsToId.get());
      }
      //noinspection unchecked
      return (N) builder;
    } catch (Exception e) {
      throw new EntityException(e);
    }
  }

  @Override
  public <N> Collection<N> copyAll(Collection<N> entities) throws EntityException {
    try {
      Collection<N> copies = new HashSet<>();
      for (N entity : entities) copies.add(copy(entity));
      return copies;
    } catch (Exception e) {
      throw new EntityException(e);
    }
  }

  @Override
  public <N> N deserialize(Class<N> valueType, String json) throws EntityException {
    try {
      return jsonProvider.getMapper().readValue(String.valueOf(json), valueType);
    } catch (Exception e) {
      throw new EntityException("Failed to deserialize JSON", e);
    }
  }

  @Override
  public String serialize(Object obj) throws EntityException {
    try {
      return jsonProvider.getMapper().writeValueAsString(obj);
    } catch (Exception e) {
      throw new EntityException("Failed to serialize JSON", e);
    }
  }

  @Override
  public EntityStore createEntityStore() {
    return new EntityStoreImpl();
  }

  /**
   Ensure the given type exists in the inner schema, else add it

   @param message on failure
   @param type    to ensure existence of
   */
  void ensureSchemaExists(Object message, String type) throws EntityException {
    if (!schema.containsKey(type))
      throw new EntityException(String.format("Cannot %s unknown type: %s", message, type));
  }

}
