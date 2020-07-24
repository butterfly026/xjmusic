// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.service.hub.dao;

import com.google.common.collect.ImmutableSet;
import com.google.common.collect.Lists;
import com.google.inject.Inject;
import io.xj.lib.entity.Entity;
import io.xj.lib.entity.EntityFactory;
import io.xj.lib.jsonapi.PayloadFactory;
import io.xj.lib.jsonapi.JsonApiException;
import io.xj.lib.util.ValueException;
import io.xj.service.hub.access.HubAccess;
import io.xj.service.hub.entity.*;
import io.xj.service.hub.persistence.HubDatabaseProvider;
import org.jooq.DSLContext;
import org.jooq.impl.DSL;

import javax.annotation.Nullable;
import java.util.Collection;
import java.util.Objects;
import java.util.UUID;
import java.util.concurrent.atomic.AtomicReference;

import static io.xj.service.hub.Tables.*;

public class InstrumentDAOImpl extends DAOImpl<Instrument> implements InstrumentDAO {

  @Inject
  public InstrumentDAOImpl(
    PayloadFactory payloadFactory,
    EntityFactory entityFactory,
    HubDatabaseProvider dbProvider
  ) {
    super(payloadFactory, entityFactory);
    this.dbProvider = dbProvider;
  }

  @Override
  public Instrument create(HubAccess hubAccess, Instrument entity) throws DAOException, JsonApiException, ValueException {
    entity.validate();// This entity's parent is a Library
    requireArtist(hubAccess);
    DSLContext db = dbProvider.getDSL();
    requireParentExists(db, hubAccess, entity);
    return modelFrom(Instrument.class, executeCreate(db, INSTRUMENT, entity));
  }

  @Override
  public Instrument clone(HubAccess hubAccess, UUID cloneId, Instrument entity) throws DAOException {
    requireArtist(hubAccess);
    AtomicReference<Instrument> result = new AtomicReference<>();
    dbProvider.getDSL().transaction(ctx -> {
      DSLContext db = DSL.using(ctx);

      Instrument from = readOne(db, hubAccess, cloneId);
      if (Objects.isNull(from))
        throw new DAOException("Can't clone nonexistent Instrument");

      // Inherits state, type if none specified
      if (Objects.isNull(entity.getType())) entity.setTypeEnum(from.getType());
      if (Objects.isNull(entity.getState())) entity.setStateEnum(from.getState());
      if (Objects.isNull(entity.getDensity())) entity.setDensity(from.getDensity());
      if (Objects.isNull(entity.getName())) entity.setName(from.getName());
      entity.setUserId(from.getUserId());
      entity.validate();
      requireParentExists(db, hubAccess, entity);

      result.set(modelFrom(Instrument.class, executeCreate(db, INSTRUMENT, entity)));

      DAOCloner<Entity> cloner = new DAOCloner<>(result.get(), this);
      cloner.clone(db, INSTRUMENT_MEME, INSTRUMENT_MEME.ID, ImmutableSet.of(), INSTRUMENT_MEME.INSTRUMENT_ID, cloneId, result.get().getId());
      cloner.clone(db, INSTRUMENT_AUDIO, INSTRUMENT_AUDIO.ID, ImmutableSet.of(), INSTRUMENT_AUDIO.INSTRUMENT_ID, cloneId, result.get().getId());
      cloner.clone(db, INSTRUMENT_AUDIO_EVENT, INSTRUMENT_AUDIO_EVENT.ID, ImmutableSet.of(INSTRUMENT_AUDIO_EVENT.INSTRUMENT_AUDIO_ID), INSTRUMENT_AUDIO_EVENT.INSTRUMENT_ID, cloneId, result.get().getId());
      cloner.clone(db, INSTRUMENT_AUDIO_CHORD, INSTRUMENT_AUDIO_CHORD.ID, ImmutableSet.of(INSTRUMENT_AUDIO_CHORD.INSTRUMENT_AUDIO_ID), INSTRUMENT_AUDIO_CHORD.INSTRUMENT_ID, cloneId, result.get().getId());
    });
    return result.get();
  }

  @Override
  @Nullable
  public Instrument readOne(HubAccess hubAccess, UUID id) throws DAOException {
    return readOne(dbProvider.getDSL(), hubAccess, id);
  }

  @Override
  public void destroy(HubAccess hubAccess, UUID id) throws DAOException {
    DSLContext db = dbProvider.getDSL();

    if (!hubAccess.isTopLevel())
      requireExists("Instrument belonging to you", db.selectCount().from(INSTRUMENT)
        .join(LIBRARY).on(INSTRUMENT.LIBRARY_ID.eq(LIBRARY.ID))
        .where(INSTRUMENT.ID.eq(id))
        .and(LIBRARY.ACCOUNT_ID.in(hubAccess.getAccountIds()))
        .fetchOne(0, int.class));

    //
    // [#170299297] Cannot delete Instruments that have a Meme-- otherwise, destroy all inner entities
    //

    requireNotExists("Instrument Memes", db.selectCount().from(INSTRUMENT_MEME)
      .where(INSTRUMENT_MEME.INSTRUMENT_ID.eq(id))
      .fetchOne(0, int.class));

    db.deleteFrom(INSTRUMENT_AUDIO_CHORD)
      .where(INSTRUMENT_AUDIO_CHORD.INSTRUMENT_ID.eq(id))
      .execute();

    db.deleteFrom(INSTRUMENT_AUDIO_EVENT)
      .where(INSTRUMENT_AUDIO_EVENT.INSTRUMENT_ID.eq(id))
      .execute();

    db.deleteFrom(INSTRUMENT_AUDIO)
      .where(INSTRUMENT_AUDIO.INSTRUMENT_ID.eq(id))
      .execute();

    db.deleteFrom(INSTRUMENT)
      .where(INSTRUMENT.ID.eq(id))
      .execute();
  }

  @Override
  public Instrument newInstance() {
    return new Instrument();
  }

  @Override
  public Collection<Instrument> readManyInAccount(HubAccess hubAccess, UUID accountId) throws DAOException {
    if (hubAccess.isTopLevel())
      return modelsFrom(Instrument.class, dbProvider.getDSL().select(INSTRUMENT.fields())
        .from(INSTRUMENT)
        .join(LIBRARY).on(INSTRUMENT.LIBRARY_ID.eq(LIBRARY.ID))
        .where(LIBRARY.ACCOUNT_ID.eq(accountId))
        .orderBy(INSTRUMENT.TYPE, INSTRUMENT.NAME)
        .fetch());
    else
      return modelsFrom(Instrument.class, dbProvider.getDSL().select(INSTRUMENT.fields())
        .from(INSTRUMENT)
        .join(LIBRARY).on(INSTRUMENT.LIBRARY_ID.eq(LIBRARY.ID))
        .where(LIBRARY.ACCOUNT_ID.in(accountId))
        .and(LIBRARY.ACCOUNT_ID.in(hubAccess.getAccountIds()))
        .orderBy(INSTRUMENT.TYPE, INSTRUMENT.NAME)
        .fetch());
  }

  @Override
  public Collection<Instrument> readMany(HubAccess hubAccess, Collection<UUID> parentIds) throws DAOException {
    if (hubAccess.isTopLevel())
      return modelsFrom(Instrument.class, dbProvider.getDSL().select(INSTRUMENT.fields())
        .from(INSTRUMENT)
        .where(INSTRUMENT.LIBRARY_ID.in(parentIds))
        .orderBy(INSTRUMENT.TYPE, INSTRUMENT.NAME)
        .fetch());
    else
      return modelsFrom(Instrument.class, dbProvider.getDSL().select(INSTRUMENT.fields())
        .from(INSTRUMENT)
        .join(LIBRARY).on(LIBRARY.ID.eq(INSTRUMENT.LIBRARY_ID))
        .where(INSTRUMENT.LIBRARY_ID.in(parentIds))
        .and(LIBRARY.ACCOUNT_ID.in(hubAccess.getAccountIds()))
        .orderBy(INSTRUMENT.TYPE, INSTRUMENT.NAME)
        .fetch());
  }

  @Override
  public Collection<Entity> readManyWithChildEntities(HubAccess hubAccess, Collection<UUID> instrumentIds) throws DAOException {
    DSLContext db = dbProvider.getDSL();

    if (!hubAccess.isTopLevel())
      for (UUID instrumentId : instrumentIds)
        requireExists("hubAccess via account", db.selectCount().from(INSTRUMENT)
          .join(LIBRARY).on(LIBRARY.ID.eq(INSTRUMENT.LIBRARY_ID))
          .where(INSTRUMENT.ID.eq(instrumentId))
          .and(LIBRARY.ACCOUNT_ID.in(hubAccess.getAccountIds()))
          .fetchOne(0, int.class));

    Collection<Entity> entities = Lists.newArrayList();
    entities.addAll(modelsFrom(Instrument.class, db.selectFrom(INSTRUMENT).where(INSTRUMENT.ID.in(instrumentIds)).fetch()));
    entities.addAll(modelsFrom(InstrumentMeme.class, db.selectFrom(INSTRUMENT_MEME).where(INSTRUMENT_MEME.INSTRUMENT_ID.in(instrumentIds))));
    entities.addAll(modelsFrom(InstrumentAudioChord.class, db.selectFrom(INSTRUMENT_AUDIO_CHORD).where(INSTRUMENT_AUDIO_CHORD.INSTRUMENT_ID.in(instrumentIds))));
    entities.addAll(modelsFrom(InstrumentAudioEvent.class, db.selectFrom(INSTRUMENT_AUDIO_EVENT).where(INSTRUMENT_AUDIO_EVENT.INSTRUMENT_ID.in(instrumentIds))));
    entities.addAll(modelsFrom(InstrumentAudio.class, db.selectFrom(INSTRUMENT_AUDIO).where(INSTRUMENT_AUDIO.INSTRUMENT_ID.in(instrumentIds))));
    return entities;
  }

  @Override
  public Collection<Instrument> readMany(HubAccess hubAccess) throws DAOException {
    if (hubAccess.isTopLevel())
      return modelsFrom(Instrument.class, dbProvider.getDSL().select(INSTRUMENT.fields())
        .from(INSTRUMENT)
        .orderBy(INSTRUMENT.TYPE, INSTRUMENT.NAME)
        .fetch());
    else
      return modelsFrom(Instrument.class, dbProvider.getDSL().select(INSTRUMENT.fields())
        .from(INSTRUMENT)
        .join(LIBRARY).on(LIBRARY.ID.eq(INSTRUMENT.LIBRARY_ID))
        .where(LIBRARY.ACCOUNT_ID.in(hubAccess.getAccountIds()))
        .orderBy(INSTRUMENT.TYPE, INSTRUMENT.NAME)
        .fetch());
  }

  @Override
  public Collection<UUID> readIdsInLibraries(HubAccess hubAccess, Collection<UUID> parentIds) throws DAOException {
    requireArtist(hubAccess);
    return DAO.idsFrom(dbProvider.getDSL().select(INSTRUMENT.ID)
      .from(INSTRUMENT)
      .where(INSTRUMENT.LIBRARY_ID.in(parentIds))
      .and(INSTRUMENT.STATE.equal(InstrumentState.Published.toString()))
      .fetch());
  }

  @Override
  public void update(HubAccess hubAccess, UUID id, Instrument entity) throws DAOException, JsonApiException, ValueException {
    entity.validate();
    entity.setId(id); // prevent changing id
    requireArtist(hubAccess);

    DSLContext db = dbProvider.getDSL();
    requireParentExists(db, hubAccess, entity);
    executeUpdate(db, INSTRUMENT, id, entity);
  }

  /**
   Read one record

   @param db        DSL context
   @param hubAccess control
   @param id        to read
   @return record
   @throws DAOException on failure
   */
  private Instrument readOne(DSLContext db, HubAccess hubAccess, UUID id) throws DAOException {
    if (hubAccess.isTopLevel())
      return modelFrom(Instrument.class, db.selectFrom(INSTRUMENT)
        .where(INSTRUMENT.ID.eq(id))
        .fetchOne());
    else
      return modelFrom(Instrument.class, db.select(INSTRUMENT.fields())
        .from(INSTRUMENT)
        .join(LIBRARY).on(LIBRARY.ID.eq(INSTRUMENT.LIBRARY_ID))
        .where(INSTRUMENT.ID.eq(id))
        .and(LIBRARY.ACCOUNT_ID.in(hubAccess.getAccountIds()))
        .fetchOne());
  }

  /**
   Require parent instrument exists of a given possible entity in a DSL context

   @param db        DSL context
   @param hubAccess control
   @param entity    to validate
   @throws DAOException if parent does not exist
   */
  private void requireParentExists(DSLContext db, HubAccess hubAccess, Instrument entity) throws DAOException {
    if (hubAccess.isTopLevel())
      requireExists("Library", db.selectCount().from(LIBRARY)
        .where(LIBRARY.ID.eq(entity.getLibraryId()))
        .fetchOne(0, int.class));
    else
      requireExists("Library", db.selectCount().from(LIBRARY)
        .where(LIBRARY.ACCOUNT_ID.in(hubAccess.getAccountIds()))
        .and(LIBRARY.ID.eq(entity.getLibraryId()))
        .fetchOne(0, int.class));
  }

}