// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.service.nexus.fabricator;

import com.google.common.collect.ImmutableList;
import com.google.inject.Inject;
import com.google.inject.assistedinject.Assisted;
import io.xj.lib.entity.Entity;
import io.xj.lib.entity.EntityStore;
import io.xj.lib.entity.EntityStoreException;
import io.xj.service.hub.client.HubClientAccess;
import io.xj.service.hub.client.HubContent;
import io.xj.service.hub.entity.ProgramType;
import io.xj.service.nexus.dao.SegmentDAO;
import io.xj.service.nexus.dao.exception.DAOExistenceException;
import io.xj.service.nexus.dao.exception.DAOFatalException;
import io.xj.service.nexus.dao.exception.DAOPrivilegeException;
import io.xj.service.nexus.entity.Segment;
import io.xj.service.nexus.entity.SegmentChoice;
import io.xj.service.nexus.entity.SegmentChoiceArrangement;
import io.xj.service.nexus.entity.SegmentChoiceArrangementPick;
import io.xj.service.nexus.entity.SegmentMeme;

import java.util.Collection;
import java.util.Optional;
import java.util.stream.Collectors;

/**
 The SegmentRetrospective is a delegate to look back on previous segments, read-only
 */
class SegmentRetrospectiveImpl implements SegmentRetrospective {
  private final EntityStore store;
  private Segment previousSegment;

  @Inject
  public SegmentRetrospectiveImpl(
    @Assisted("access") HubClientAccess access,
    @Assisted("currentSegment") Segment segment,
    @Assisted("sourceMaterial") HubContent sourceMaterial,
    SegmentDAO segmentDAO,
    EntityStore entityStore
  ) throws FabricationException {
    this.store = entityStore;
    try {
      // begin by getting the previous segment
      // only can build retrospective if there is at least one previous segment
      // the previous segment is the first one cached here. we may cache even further back segments below if found
      if (segment.getOffset() <= 0) return;
      previousSegment = store.put(segmentDAO.readOneAtChainOffset(access,
        segment.getChainId(), segment.getOffset() - 1));
      store.putAll(segmentDAO.readManySubEntities(access, ImmutableList.of(previousSegment.getId()), true));

      // previous segment must have a main choice to continue past here.
      SegmentChoice previousSegmentMainChoice = store.getAll(SegmentChoice.class).stream()
        .filter(segmentChoice -> ProgramType.Main.equals(segmentChoice.getType()))
        .findFirst().orElseThrow(() -> new FabricationException("No main choice!"));

      // if relevant populate the retrospective with the previous segments with the same main sequence as this one
      Long sequenceBindingOffset = sourceMaterial.getProgramSequenceBinding(previousSegmentMainChoice.getProgramSequenceBindingId()).getOffset();
      if (0 >= sequenceBindingOffset) return;
      long oF = segment.getOffset() - sequenceBindingOffset;
      long oT = segment.getOffset() - 1;
      if (0 > oF || 0 > oT) return;
      Collection<Segment> previousMany = segmentDAO.readManyFromToOffset(access, segment.getChainId(), oF, oT);
      store.putAll(previousMany);
      store.putAll(segmentDAO.readManySubEntities(access,
        previousMany.stream().map(Entity::getId).collect(Collectors.toList()), true));

    } catch (DAOExistenceException | DAOFatalException | DAOPrivilegeException | EntityStoreException e) {
      throw new FabricationException(e);
    }
  }

  @Override
  public Collection<SegmentChoiceArrangementPick> getSegmentPicks(Segment segment) throws FabricationException {
    try {
      return store.getAll(SegmentChoiceArrangementPick.class).stream().filter(e ->
        e.getSegmentId().equals(segment.getId()))
        .collect(Collectors.toList());
    } catch (EntityStoreException e) {
      throw new FabricationException(e);
    }
  }

  @Override
  public Collection<SegmentChoice> getSegmentChoices(Segment segment) throws FabricationException {
    try {
      return store.getAll(SegmentChoice.class).stream().filter(e ->
        e.getSegmentId().equals(segment.getId()))
        .collect(Collectors.toList());
    } catch (EntityStoreException e) {
      throw new FabricationException(e);
    }
  }

  @Override
  public Collection<SegmentMeme> getSegmentMemes(Segment segment) throws FabricationException {
    try {
      return store.getAll(SegmentMeme.class).stream().filter(e ->
        e.getSegmentId().equals(segment.getId()))
        .collect(Collectors.toList());

    } catch (EntityStoreException e) {
      throw new FabricationException(e);
    }
  }

  @Override
  public Collection<Segment> getSegments() throws FabricationException {
    try {
      return store.getAll(Segment.class);

    } catch (EntityStoreException e) {
      throw new FabricationException(e);
    }
  }

  @Override
  public SegmentChoice getChoiceOfType(Segment segment, ProgramType type) throws FabricationException {
    try {
      Optional<SegmentChoice> choice =
        store.getAll(SegmentChoice.class).stream().filter(c ->
          c.getSegmentId().equals(segment.getId()) &&
            c.getType().equals(type)).findFirst();
      if (choice.isEmpty())
        throw new FabricationException(String.format("No %s-type choice in retrospective %s", type, segment));
      return choice.get();

    } catch (EntityStoreException e) {
      throw new FabricationException(e);
    }
  }

  @Override
  public Collection<SegmentChoiceArrangement> getArrangements(SegmentChoice segmentChoice) throws FabricationException {
    try {
      return store.getAll(SegmentChoiceArrangement.class).stream().filter(a ->
        a.getSegmentChoiceId().equals(segmentChoice.getId()))
        .collect(Collectors.toList());

    } catch (EntityStoreException e) {
      throw new FabricationException(e);
    }
  }

  @Override
  public Optional<Segment> getPreviousSegment() {
    return Optional.ofNullable(previousSegment);
  }

  @Override
  public SegmentChoice getPreviousChoiceOfType(ProgramType type) throws FabricationException {
    Optional<Segment> seg = getPreviousSegment();
    if (seg.isEmpty()) throw new FabricationException("Cannot get previous segment to get choice create");
    return getChoiceOfType(seg.get(), type);
  }

  @Override
  public <N extends Entity> N add(N entity) throws FabricationException {
    try {
      return store.put(entity);
    } catch (EntityStoreException e) {
      throw new FabricationException(e);
    }
  }

}
