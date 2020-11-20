// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.service.hub.dao;

import com.google.common.collect.ImmutableSet;
import com.google.inject.Inject;
import io.xj.ProgramSequence;
import io.xj.lib.entity.EntityFactory;
import io.xj.lib.jsonapi.JsonApiException;
import io.xj.lib.jsonapi.PayloadFactory;
import io.xj.lib.util.Value;
import io.xj.lib.util.ValueException;
import io.xj.service.hub.access.HubAccess;
import io.xj.service.hub.persistence.HubDatabaseProvider;
import org.jooq.DSLContext;
import org.jooq.impl.DSL;

import javax.annotation.Nullable;
import java.util.Collection;
import java.util.Map;
import java.util.Objects;
import java.util.UUID;
import java.util.concurrent.atomic.AtomicReference;

import static io.xj.service.hub.Tables.LIBRARY;
import static io.xj.service.hub.Tables.PROGRAM;
import static io.xj.service.hub.Tables.PROGRAM_SEQUENCE;
import static io.xj.service.hub.Tables.PROGRAM_SEQUENCE_BINDING;
import static io.xj.service.hub.Tables.PROGRAM_SEQUENCE_BINDING_MEME;
import static io.xj.service.hub.Tables.PROGRAM_SEQUENCE_CHORD;
import static io.xj.service.hub.Tables.PROGRAM_SEQUENCE_PATTERN;
import static io.xj.service.hub.Tables.PROGRAM_SEQUENCE_PATTERN_EVENT;
import static io.xj.service.hub.tables.ProgramSequenceChordVoicing.PROGRAM_SEQUENCE_CHORD_VOICING;

public class ProgramSequenceDAOImpl extends DAOImpl<ProgramSequence> implements ProgramSequenceDAO {

  @Inject
  public ProgramSequenceDAOImpl(
    PayloadFactory payloadFactory,
    EntityFactory entityFactory,
    HubDatabaseProvider dbProvider
  ) {
    super(payloadFactory, entityFactory);
    this.dbProvider = dbProvider;
  }

  @Override
  public ProgramSequence create(HubAccess hubAccess, ProgramSequence entity) throws DAOException, JsonApiException, ValueException {
    ProgramSequence.Builder builder = validate(entity.toBuilder());
    DSLContext db = dbProvider.getDSL();
    requireProgramModification(db, hubAccess, builder.getProgramId());
    return modelFrom(ProgramSequence.class,
      executeCreate(dbProvider.getDSL(), PROGRAM_SEQUENCE, builder.build()));
  }

  @Override
  public DAOCloner<ProgramSequence> clone(HubAccess hubAccess, String rawCloneId, ProgramSequence rawEntity) throws DAOException {
    requireArtist(hubAccess);
    AtomicReference<ProgramSequence> result = new AtomicReference<>();
    AtomicReference<DAOCloner<ProgramSequence>> cloner = new AtomicReference<>();
    dbProvider.getDSL().transaction(ctx -> {
      DSLContext db = DSL.using(ctx);
      requireModification(db, hubAccess, rawCloneId);

      var from = readOne(db, hubAccess, rawCloneId);
      if (Objects.isNull(from))
        throw new DAOException("Can't clone nonexistent ProgramSequence");

      // Inherits attributes if none specified
      ProgramSequence.Builder builder = rawEntity.toBuilder();
      if (Value.isEmpty(builder.getTotal())) builder.setTotal(from.getTotal());
      if (Value.isEmpty(builder.getName())) builder.setName(from.getName());
      if (Value.isEmpty(builder.getTempo())) builder.setTempo(from.getTempo());
      if (Value.isEmpty(builder.getDensity())) builder.setDensity(from.getDensity());
      if (Value.isEmpty(builder.getKey())) builder.setKey(from.getKey());
      var record = validate(builder).build();
      requireParentExists(db, hubAccess, record);

      // Create main entity
      result.set(modelFrom(ProgramSequence.class, executeCreate(db, PROGRAM_SEQUENCE, record)));
      UUID cloneId = UUID.fromString(rawCloneId);
      UUID sourceId = UUID.fromString(result.get().getId());

      // Prepare to clone sub-entities
      cloner.set(new DAOCloner<>(result.get(), this));

      // Clone ProgramSequenceChord belongs to ProgramSequence
      cloner.get().clone(db, PROGRAM_SEQUENCE_CHORD, PROGRAM_SEQUENCE_CHORD.ID,
        ImmutableSet.of(PROGRAM_SEQUENCE_CHORD.PROGRAM_SEQUENCE_ID),
        PROGRAM_SEQUENCE_CHORD.PROGRAM_SEQUENCE_ID, cloneId, sourceId);

      // Clone ProgramSequenceBinding belongs to ProgramSequence
      Map<UUID, UUID> clonedProgramSequenceBindings = cloner.get().clone(db, PROGRAM_SEQUENCE_BINDING, PROGRAM_SEQUENCE_BINDING.ID,
        ImmutableSet.of(PROGRAM_SEQUENCE_BINDING.PROGRAM_SEQUENCE_ID),
        PROGRAM_SEQUENCE_BINDING.PROGRAM_SEQUENCE_ID, cloneId, sourceId);

      // Clone ProgramSequenceBindingMeme belongs to newly cloned ProgramSequenceBindings
      for (UUID originalId : clonedProgramSequenceBindings.keySet())
        cloner.get().clone(db, PROGRAM_SEQUENCE_BINDING_MEME, PROGRAM_SEQUENCE_BINDING_MEME.ID,
          ImmutableSet.of(PROGRAM_SEQUENCE_BINDING_MEME.PROGRAM_SEQUENCE_BINDING_ID),
          PROGRAM_SEQUENCE_BINDING_MEME.PROGRAM_SEQUENCE_BINDING_ID,
          originalId, clonedProgramSequenceBindings.get(originalId));

      // Clone ProgramSequencePattern belongs to ProgramSequence and ProgramVoice
      Map<UUID, UUID> clonedProgramSequencePatterns = cloner.get().clone(db, PROGRAM_SEQUENCE_PATTERN, PROGRAM_SEQUENCE_PATTERN.ID,
        ImmutableSet.of(PROGRAM_SEQUENCE_PATTERN.PROGRAM_SEQUENCE_ID, PROGRAM_SEQUENCE_PATTERN.PROGRAM_VOICE_ID),
        PROGRAM_SEQUENCE_PATTERN.PROGRAM_SEQUENCE_ID, cloneId, sourceId);

      // Clone ProgramSequencePatternEvent belongs to newly cloned ProgramSequencePattern and ProgramVoiceTrack
      for (UUID originalId : clonedProgramSequencePatterns.keySet())
        cloner.get().clone(db, PROGRAM_SEQUENCE_PATTERN_EVENT, PROGRAM_SEQUENCE_PATTERN_EVENT.ID,
          ImmutableSet.of(PROGRAM_SEQUENCE_PATTERN_EVENT.PROGRAM_SEQUENCE_PATTERN_ID, PROGRAM_SEQUENCE_PATTERN_EVENT.PROGRAM_VOICE_TRACK_ID),
          PROGRAM_SEQUENCE_PATTERN_EVENT.PROGRAM_SEQUENCE_PATTERN_ID,
          originalId, clonedProgramSequencePatterns.get(originalId));

    });
    return cloner.get();
  }

  @Override
  @Nullable
  public ProgramSequence readOne(HubAccess hubAccess, String id) throws DAOException {
    requireArtist(hubAccess);
    return readOne(dbProvider.getDSL(), hubAccess, id);
  }

  @Override
  @Nullable
  public Collection<ProgramSequence> readMany(HubAccess hubAccess, Collection<String> parentIds) throws DAOException {
    requireArtist(hubAccess);
    if (hubAccess.isTopLevel())
      return modelsFrom(ProgramSequence.class,
        dbProvider.getDSL().selectFrom(PROGRAM_SEQUENCE)
          .where(PROGRAM_SEQUENCE.PROGRAM_ID.in(parentIds))
          .fetch());
    else
      return modelsFrom(ProgramSequence.class,
        dbProvider.getDSL().select(PROGRAM_SEQUENCE.fields()).from(PROGRAM_SEQUENCE)
          .join(PROGRAM).on(PROGRAM.ID.eq(PROGRAM_SEQUENCE.PROGRAM_ID))
          .join(LIBRARY).on(LIBRARY.ID.eq(PROGRAM.LIBRARY_ID))
          .where(PROGRAM_SEQUENCE.PROGRAM_ID.in(parentIds))
          .and(LIBRARY.ACCOUNT_ID.in(hubAccess.getAccountIds()))
          .fetch());
  }

  @Override
  public void update(HubAccess hubAccess, String id, ProgramSequence entity) throws DAOException, JsonApiException, ValueException {
    ProgramSequence.Builder builder = validate(entity.toBuilder());
    DSLContext db = dbProvider.getDSL();
    requireModification(db, hubAccess, id);
    executeUpdate(db, PROGRAM_SEQUENCE, id, builder.build());
  }

  @Override
  public void destroy(HubAccess hubAccess, String rawId) throws DAOException {
    DSLContext db = dbProvider.getDSL();
    requireModification(db, hubAccess, rawId);
    UUID id = UUID.fromString(rawId);

    // Delete all ProgramSequenceBindingMeme
    db.deleteFrom(PROGRAM_SEQUENCE_BINDING_MEME)
      .where(PROGRAM_SEQUENCE_BINDING_MEME.PROGRAM_SEQUENCE_BINDING_ID.in(
        db.select(PROGRAM_SEQUENCE_BINDING.ID).from(PROGRAM_SEQUENCE_BINDING)
          .where(PROGRAM_SEQUENCE_BINDING.PROGRAM_SEQUENCE_ID.eq(id))))
      .execute();

    // Delete all ProgramSequenceBinding
    db.deleteFrom(PROGRAM_SEQUENCE_BINDING)
      .where(PROGRAM_SEQUENCE_BINDING.PROGRAM_SEQUENCE_ID.eq(id))
      .execute();

    // Delete all ProgramSequenceChordVoicing
    db.deleteFrom(PROGRAM_SEQUENCE_CHORD_VOICING)
      .where(PROGRAM_SEQUENCE_CHORD_VOICING.PROGRAM_SEQUENCE_CHORD_ID.in(
        db.select(PROGRAM_SEQUENCE_CHORD.ID).from(PROGRAM_SEQUENCE_CHORD)
          .where(PROGRAM_SEQUENCE_CHORD.PROGRAM_SEQUENCE_ID.eq(id))))
      .execute();

    // Delete all ProgramSequenceChord
    db.deleteFrom(PROGRAM_SEQUENCE_CHORD)
      .where(PROGRAM_SEQUENCE_CHORD.PROGRAM_SEQUENCE_ID.eq(id))
      .execute();

    // Delete all ProgramSequencePatternEvent
    db.deleteFrom(PROGRAM_SEQUENCE_PATTERN_EVENT)
      .where(PROGRAM_SEQUENCE_PATTERN_EVENT.PROGRAM_SEQUENCE_PATTERN_ID.in(
        db.select(PROGRAM_SEQUENCE_PATTERN.ID).from(PROGRAM_SEQUENCE_PATTERN)
          .where(PROGRAM_SEQUENCE_PATTERN.PROGRAM_SEQUENCE_ID.eq(id))))
      .execute();

    // Delete all ProgramSequencePattern
    db.deleteFrom(PROGRAM_SEQUENCE_PATTERN)
      .where(PROGRAM_SEQUENCE_PATTERN.PROGRAM_SEQUENCE_ID.eq(id))
      .execute();

    // Delete all ProgramSequence
    db.deleteFrom(PROGRAM_SEQUENCE)
      .where(PROGRAM_SEQUENCE.ID.eq(id))
      .execute();
  }

  @Override
  public ProgramSequence newInstance() {
    return ProgramSequence.getDefaultInstance();
  }

  /**
   Require permission to modify the specified program sequence

   @param db        context
   @param hubAccess control
   @param id        of entity to require modification hubAccess to
   @throws DAOException on invalid permissions
   */
  private void requireModification(DSLContext db, HubAccess hubAccess, String id) throws DAOException {
    requireArtist(hubAccess);

    if (hubAccess.isTopLevel())
      requireExists("Sequence", db.selectCount().from(PROGRAM_SEQUENCE)
        .where(PROGRAM_SEQUENCE.ID.eq(UUID.fromString(id)))
        .fetchOne(0, int.class));
    else
      requireExists("Sequence in Program in Account you have hubAccess to", db.selectCount().from(PROGRAM_SEQUENCE)
        .join(PROGRAM).on(PROGRAM_SEQUENCE.PROGRAM_ID.eq(PROGRAM.ID))
        .join(LIBRARY).on(PROGRAM.LIBRARY_ID.eq(LIBRARY.ID))
        .where(PROGRAM_SEQUENCE.ID.eq(UUID.fromString(id)))
        .and(LIBRARY.ACCOUNT_ID.in(hubAccess.getAccountIds()))
        .fetchOne(0, int.class));
  }

  /**
   Require parent ProgramSequence exists of a given possible entity in a DSL context

   @param db        DSL context
   @param hubAccess control
   @param entity    to validate
   @throws DAOException if parent does not exist
   */
  private void requireParentExists(DSLContext db, HubAccess hubAccess, ProgramSequence entity) throws DAOException {
    if (hubAccess.isTopLevel())
      requireExists("Program", db.selectCount().from(PROGRAM)
        .where(PROGRAM.ID.eq(UUID.fromString(entity.getProgramId())))
        .fetchOne(0, int.class));
    else
      requireExists("Program", db.selectCount().from(PROGRAM)
        .join(LIBRARY).on(LIBRARY.ID.eq(PROGRAM.LIBRARY_ID))
        .where(LIBRARY.ACCOUNT_ID.in(hubAccess.getAccountIds()))
        .and(PROGRAM.ID.eq(UUID.fromString(entity.getProgramId())))
        .fetchOne(0, int.class));
  }

  /**
   Read one Program Sequence

   @param db        context
   @param hubAccess control
   @param id        of entity to read
   @return program sequence
   */
  private ProgramSequence readOne(DSLContext db, HubAccess hubAccess, String id) throws DAOException {
    if (hubAccess.isTopLevel())
      return modelFrom(ProgramSequence.class,
        db.selectFrom(PROGRAM_SEQUENCE)
          .where(PROGRAM_SEQUENCE.ID.eq(UUID.fromString(id)))
          .fetchOne());
    else
      return modelFrom(ProgramSequence.class,
        db.select(PROGRAM_SEQUENCE.fields()).from(PROGRAM_SEQUENCE)
          .join(PROGRAM).on(PROGRAM.ID.eq(PROGRAM_SEQUENCE.PROGRAM_ID))
          .join(LIBRARY).on(LIBRARY.ID.eq(PROGRAM.LIBRARY_ID))
          .where(PROGRAM_SEQUENCE.ID.eq(UUID.fromString(id)))
          .and(LIBRARY.ACCOUNT_ID.in(hubAccess.getAccountIds()))
          .fetchOne());
  }

  /**
   validate data

   @param record to validate
   @throws DAOException if invalid
   */
  public ProgramSequence.Builder validate(ProgramSequence.Builder record) throws DAOException {
    try {
      Value.require(record.getProgramId(), "Program ID");
      Value.require(record.getName(), "Name");
      Value.require(record.getKey(), "Key");
      Value.require(record.getDensity(), "Density");
      if (Value.isEmpty(record.getTotal())) record.setTotal(0);
      Value.require(record.getTempo(), "Tempo");
      return record;

    } catch (ValueException e) {
      throw new DAOException(e);
    }
  }

}
