// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.

package io.xj.nexus.persistence;

import com.google.common.collect.ImmutableList;
import com.google.common.collect.Maps;
import com.google.inject.Inject;
import com.google.inject.Singleton;
import io.xj.api.Chain;
import io.xj.api.TemplateBinding;
import io.xj.api.Segment;
import io.xj.api.SegmentChoice;
import io.xj.api.SegmentChoiceArrangement;
import io.xj.api.SegmentChoiceArrangementPick;
import io.xj.api.SegmentChord;
import io.xj.api.SegmentChordVoicing;
import io.xj.api.SegmentMeme;
import io.xj.api.SegmentMessage;
import io.xj.lib.entity.Entities;
import io.xj.lib.entity.EntityException;
import io.xj.lib.entity.EntityFactory;
import io.xj.lib.entity.EntityStoreImpl;
import io.xj.lib.util.Value;
import io.xj.nexus.NexusException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Map;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;

/**
 [#175880468] NexusEntityStore segments and child entities partitioned by segment id for rapid addressing
 <p>
 [#171553408] XJ Lab Distributed Architecture
 Chains, ChainBindings, TemplateConfigs, Segments and all Segment content sub-entities persisted in JSON:API record stored keyed by chain or segment id in memory
 */
@Singleton
public class NexusEntityStoreImpl implements NexusEntityStore {
  private static final Logger LOG = LoggerFactory.getLogger(EntityStoreImpl.class);
  private static final String SEGMENT_ID_ATTRIBUTE = Entities.toIdAttribute(Entities.toBelongsTo(Segment.class));
  private final Map<UUID/*ID*/, Chain> chainMap = Maps.newConcurrentMap();
  private final Map<UUID/*ID*/, TemplateBinding> chainBindingMap = Maps.newConcurrentMap();
  private final Map<UUID/*ID*/, Segment> segmentMap = Maps.newConcurrentMap();
  private final Map<UUID/*SegID*/, Map<Class<?>/*Type*/, Map<UUID/*ID*/, Object>>> store = Maps.newConcurrentMap();
  private final EntityFactory entityFactory;

  @Inject
  public NexusEntityStoreImpl(EntityFactory entityFactory) {
    this.entityFactory = entityFactory;
  }

  @Override
  public void deleteChain(UUID id) {
    chainMap.remove(id);
  }

  @Override
  public void deleteChainBinding(UUID id) {
    chainBindingMap.remove(id);
  }

  @Override
  public void deleteSegment(UUID id) {
    store.remove(id);
    segmentMap.remove(id);
  }

  @Override
  public <N> void delete(UUID segmentId, Class<N> type, UUID id) {
    if (store.containsKey(segmentId) && store.get(segmentId).containsKey(type))
      store.get(segmentId).get(type).remove(id);
  }

  @Override
  public <N> void deleteAll(UUID segmentId, Class<N> type) throws NexusException {
    for (N entity : getAll(segmentId, type)) {
      try {
        delete(segmentId, type, Entities.getId(entity));
      } catch (EntityException e) {
        throw new NexusException(e);
      }
    }
  }

  @Override
  public void deleteAll() {
    store.clear();
    segmentMap.clear();
    chainBindingMap.clear();
    chainMap.clear();
    LOG.debug("Did delete all records in store");
  }

  @Override
  public Optional<Chain> getChain(UUID id) throws NexusException {
    if (!chainMap.containsKey(id)) return Optional.empty();
    return Optional.of(chainMap.get(id));
  }

  @Override
  public Optional<TemplateBinding> getChainBinding(UUID id) {
    if (!chainBindingMap.containsKey(id)) return Optional.empty();
    return Optional.of(chainBindingMap.get(id));
  }

  @Override
  public Optional<Segment> getSegment(UUID id) throws NexusException {
    if (!segmentMap.containsKey(id)) return Optional.empty();
    return Optional.of(segmentMap.get(id));
  }

  @Override
  public <N> Optional<N> get(UUID segmentId, Class<N> type, UUID id) throws NexusException {
    try {
      if (!store.containsKey(segmentId) || !store.get(segmentId).containsKey(type))
        if (!store.get(segmentId).get(type).containsKey(id)) return Optional.empty();
      //noinspection unchecked
      return (Optional<N>) Optional.of(store.get(segmentId).get(type).get(id));

    } catch (Exception e) {
      throw new NexusException(e);
    }
  }

  @Override
  public <N> Collection<N> getAll(UUID segmentId, Class<N> type) throws NexusException {
    try {
      if (!store.containsKey(segmentId) || !store.get(segmentId).containsKey(type))
        return ImmutableList.of();
      //noinspection unchecked
      return (Collection<N>) store.get(segmentId).get(type).values().stream()
        .filter(entity -> type.equals(entity.getClass()))
        .collect(Collectors.toList());

    } catch (Exception e) {
      throw new NexusException(e);
    }
  }

  @Override
  public <N, B> Collection<N> getAll(UUID segmentId, Class<N> type, Class<B> belongsToType, Collection<UUID> belongsToIds) throws NexusException {
    try {
      if (!store.containsKey(segmentId) || !store.get(segmentId).containsKey(type))
        return ImmutableList.of();
      //noinspection unchecked
      return (Collection<N>) store.get(segmentId).get(type).values().stream()
        .filter(entity -> Entities.isChild(entity, belongsToType, belongsToIds))
        .collect(Collectors.toList());

    } catch (Exception e) {
      throw new NexusException(e);
    }
  }

  @Override
  public Collection<Chain> getAllChains() {
    return new ArrayList<>(chainMap.values());
  }

  @Override
  public Collection<Segment> getAllSegments(UUID chainId) {
    return segmentMap.values().stream()
      .filter(segment -> chainId.equals(segment.getChainId()))
      .collect(Collectors.toList());
  }

  @Override
  public <N> N put(N entity) throws NexusException {
    // fail to store entity without id
    UUID id;
    try {
      id = Entities.getId(entity);
    } catch (EntityException e) {
      throw new NexusException(String.format("Can't get id of %s-type entity",
        entity.getClass().getSimpleName()));
    }

    // fail to store entity with unset id
    if (!Value.isSet(id))
      throw new NexusException(String.format("Can't store %s with null id",
        entity.getClass().getSimpleName()));

    if (entity instanceof Chain)
      chainMap.put(id, (Chain) entity);

    else if (entity instanceof TemplateBinding)
      chainBindingMap.put(id, (TemplateBinding) entity);

    else if (entity instanceof Segment)
      segmentMap.put(id, (Segment) entity);

    else if (entity instanceof SegmentMeme ||
      entity instanceof SegmentChord ||
      entity instanceof SegmentChordVoicing ||
      entity instanceof SegmentChoice ||
      entity instanceof SegmentMessage ||
      entity instanceof SegmentChoiceArrangement ||
      entity instanceof SegmentChoiceArrangementPick)
      try {
        var segmentIdValue = Entities.get(entity, SEGMENT_ID_ATTRIBUTE)
          .orElseThrow(() -> new NexusException(String.format("Can't store %s without Segment ID!",
            entity.getClass().getSimpleName())));
        UUID segmentId = UUID.fromString(String.valueOf(segmentIdValue));
        store.putIfAbsent(segmentId, Maps.newConcurrentMap());
        store.get(segmentId).putIfAbsent(entity.getClass(), Maps.newConcurrentMap());
        store.get(segmentId).get(entity.getClass()).put(id, entity);
      } catch (EntityException e) {
        throw new NexusException(e);
      }
    else throw new NexusException(String.format("Can't store %s!", entity.getClass().getSimpleName()));

    try {
      return entityFactory.clone(entity);
    } catch (EntityException e) {
      throw new NexusException(e);
    }
  }

  @Override
  public <N> Collection<N> putAll(Collection<N> entities) throws NexusException {
    for (N entity : entities) put(entity);
    return entities;
  }

  @Override
  public int size() {
    return 0;
  }
}