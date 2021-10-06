// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.nexus.fabricator;

import com.google.common.collect.ImmutableList;
import com.google.inject.Inject;
import com.google.inject.assistedinject.Assisted;
import io.xj.api.Segment;
import io.xj.api.SegmentChoice;
import io.xj.api.SegmentChoiceArrangementPick;
import io.xj.hub.enums.InstrumentType;
import io.xj.hub.enums.ProgramType;
import io.xj.lib.entity.Entities;
import io.xj.lib.entity.EntityStore;
import io.xj.lib.entity.EntityStoreException;
import io.xj.nexus.NexusException;
import io.xj.nexus.hub_client.client.HubContent;
import io.xj.nexus.persistence.ManagerExistenceException;
import io.xj.nexus.persistence.ManagerFatalException;
import io.xj.nexus.persistence.ManagerPrivilegeException;
import io.xj.nexus.persistence.SegmentManager;

import java.util.*;
import java.util.stream.Collectors;

/**
 The SegmentRetrospective is a delegate to look back on previous segments, read-only
 */
class SegmentRetrospectiveImpl implements SegmentRetrospective {
  private final EntityStore store;
  private Segment previousSegment;

  @Inject
  public SegmentRetrospectiveImpl(
    @Assisted("segment") Segment segment,
    @Assisted("sourceMaterial") HubContent sourceMaterial,
    SegmentManager segmentManager,
    EntityStore entityStore
  ) throws NexusException {
    this.store = entityStore;

    // begin by getting the previous segment
    // only can build retrospective if there is at least one previous segment
    // the previous segment is the first one cached here. we may cache even further back segments below if found
    if (segment.getOffset() <= 0) return;
    try {
      // begin by getting the previous segment
      // the previous segment is the first one cached here. we may cache even further back segments below if found
      previousSegment = store.put(segmentManager.readOneAtChainOffset(
        segment.getChainId(), segment.getOffset() - 1));
      store.putAll(segmentManager.readManySubEntities(ImmutableList.of(previousSegment.getId()), true));

      // previous segment must have a main choice to continue past here.
      SegmentChoice previousSegmentMainChoice = store.getAll(SegmentChoice.class).stream()
        .filter(segmentChoice -> ProgramType.Main.toString().equals(segmentChoice.getProgramType()))
        .findFirst()
        .orElseThrow(() -> new NexusException("Retrospective sees no main choice!"));

      // if relevant populate the retrospective with the previous segments with the same main sequence as this one
      long sequenceBindingOffset = sourceMaterial
        .getProgramSequenceBinding(previousSegmentMainChoice.getProgramSequenceBindingId())
        .orElseThrow(() -> new ManagerExistenceException("Retrospective cannot find sequence binding"))
        .getOffset();
      if (0 >= sequenceBindingOffset) return;
      long oF = segment.getOffset() - sequenceBindingOffset;
      long oT = segment.getOffset() - 1;
      if (0 > oF || 0 > oT) return;
      Collection<Segment> previousMany = segmentManager.readManyFromToOffset(segment.getChainId(), oF, oT);
      store.putAll(previousMany);
      store.putAll(segmentManager.readManySubEntities(Entities.idsOf(previousMany), true));

    } catch (ManagerExistenceException | ManagerFatalException | ManagerPrivilegeException | EntityStoreException e) {
      throw new NexusException(e);
    }
  }

  @Override
  public Optional<SegmentChoice> getPreviousChoiceOfType(Segment segment, ProgramType type) {
    return
      store.getAll(SegmentChoice.class).stream()
        .filter(c -> c.getSegmentId().equals(segment.getId())
          && type.toString().equals(c.getProgramType()))
        .findFirst();
  }

  @Override
  public Optional<SegmentChoice> getPreviousChoiceOfType(Segment segment, UUID programVoiceId) {
    return
      store.getAll(SegmentChoice.class).stream()
        .filter(c -> Objects.nonNull(c.getProgramVoiceId())
          && c.getSegmentId().equals(segment.getId())
          && programVoiceId.equals(c.getProgramVoiceId()))
        .findFirst();
  }

  @Override
  public Collection<SegmentChoiceArrangementPick> getPicks() {
    return new ArrayList<>(store.getAll(SegmentChoiceArrangementPick.class));
  }

  @Override
  public Optional<Segment> getPreviousSegment() {
    return Optional.ofNullable(previousSegment);
  }

  @Override
  public Optional<SegmentChoice> getPreviousChoiceOfType(ProgramType type) {
    Optional<Segment> seg = getPreviousSegment();
    if (seg.isEmpty()) return Optional.empty();
    return getPreviousChoiceOfType(seg.get(), type);
  }

  @Override
  public List<SegmentChoice> getPreviousChoicesOfType(InstrumentType instrumentType) {
    Optional<Segment> seg = getPreviousSegment();
    if (seg.isEmpty()) return List.of();
    return
      store.getAll(SegmentChoice.class).stream()
        .filter(c -> c.getSegmentId().equals(seg.get().getId())
          && Objects.nonNull(c.getInstrumentType())
          && c.getInstrumentType().equals(instrumentType.toString()))
        .collect(Collectors.toList());
  }

  @Override
  public Optional<SegmentChoice> getPreviousChoiceOfVoice(UUID programVoiceId) {
    Optional<Segment> seg = getPreviousSegment();
    if (seg.isEmpty()) return Optional.empty();
    return getPreviousChoiceOfType(seg.get(), programVoiceId);
  }

  @Override
  public Collection<Segment> getSegments() {
    return store.getAll(Segment.class);
  }

  @Override
  public Collection<SegmentChoice> getChoices() {
    return store.getAll(SegmentChoice.class);
  }
}
