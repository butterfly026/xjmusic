// Copyright Outright Mental, Inc. All Rights Reserved.
package io.outright.xj.core.dao.impl;

import io.outright.xj.core.app.access.AccessControl;
import io.outright.xj.core.app.exception.BusinessException;
import io.outright.xj.core.app.exception.ConfigException;
import io.outright.xj.core.dao.VoiceEventDAO;
import io.outright.xj.core.db.sql.SQLConnection;
import io.outright.xj.core.db.sql.SQLDatabaseProvider;
import io.outright.xj.core.model.voice_event.VoiceEvent;
import io.outright.xj.core.model.voice_event.VoiceEventWrapper;
import io.outright.xj.core.tables.Voice;
import io.outright.xj.core.transport.JSON;

import org.jooq.DSLContext;
import org.jooq.Field;
import org.jooq.types.ULong;

import com.google.inject.Inject;

import org.json.JSONArray;
import org.json.JSONObject;

import javax.annotation.Nullable;
import java.sql.SQLException;
import java.util.Map;

import static io.outright.xj.core.Tables.VOICE;
import static io.outright.xj.core.Tables.VOICE_EVENT;
import static io.outright.xj.core.tables.Idea.IDEA;
import static io.outright.xj.core.tables.Library.LIBRARY;
import static io.outright.xj.core.tables.Phase.PHASE;

public class VoiceEventDAOImpl extends DAOImpl implements VoiceEventDAO {

  @Inject
  public VoiceEventDAOImpl(
    SQLDatabaseProvider dbProvider
  ) {
    this.dbProvider = dbProvider;
  }

  @Override
  public JSONObject create(AccessControl access, VoiceEventWrapper data) throws Exception {
    SQLConnection tx = dbProvider.getConnection();
    try {
      return tx.success(create(tx.getContext(), access, data));
    } catch (Exception e) {
      throw tx.failure(e);
    }
  }

  @Override
  @Nullable
  public JSONObject readOne(AccessControl access, ULong id) throws Exception {
    SQLConnection tx = dbProvider.getConnection();
    try {
      return tx.success(readOne(tx.getContext(), access, id));
    } catch (Exception e) {
      throw tx.failure(e);
    }
  }

  @Override
  @Nullable
  public JSONArray readAllIn(AccessControl access, ULong voiceId) throws Exception {
    SQLConnection tx = dbProvider.getConnection();
    try {
      return tx.success(readAllIn(tx.getContext(), access, voiceId));
    } catch (Exception e) {
      throw tx.failure(e);
    }
  }

  @Override
  public void update(AccessControl access, ULong id, VoiceEventWrapper data) throws Exception {
    SQLConnection tx = dbProvider.getConnection();
    try {
      update(tx.getContext(), access, id, data);
      tx.success();
    } catch (Exception e) {
      throw tx.failure(e);
    }
  }

  @Override
  public void delete(AccessControl access, ULong id) throws Exception {
    SQLConnection tx = dbProvider.getConnection();
    try {
      delete(access, tx.getContext(), id);
      tx.success();
    } catch (Exception e) {
      throw tx.failure(e);
    }
  }

  /**
   * Create a new Voice Event
   *
   * @param db     context
   * @param access control
   * @param data   for new voice
   * @return newly created record
   * @throws BusinessException if failure
   */
  private JSONObject create(DSLContext db, AccessControl access, VoiceEventWrapper data) throws BusinessException {
    VoiceEvent model = data.validate();
    Map<Field, Object> fieldValues = model.intoFieldValueMap();

    if (access.isTopLevel()) {
      requireRecordExists("Voice", db.select(VOICE.ID).from(VOICE)
        .where(VOICE.ID.eq(model.getVoiceId()))
        .fetchOne());
    } else {
      requireRecordExists("Voice", db.select(VOICE.ID).from(VOICE)
        .join(PHASE).on(PHASE.ID.eq(VOICE.PHASE_ID))
        .join(IDEA).on(IDEA.ID.eq(PHASE.IDEA_ID))
        .join(LIBRARY).on(LIBRARY.ID.eq(IDEA.LIBRARY_ID))
        .where(LIBRARY.ACCOUNT_ID.in(access.getAccounts()))
        .and(VOICE.ID.eq(model.getVoiceId()))
        .fetchOne());
    }

    return JSON.objectFromRecord(executeCreate(db, VOICE_EVENT, fieldValues));
  }

  /**
   * Read one Event if able
   *
   * @param db     context
   * @param access control
   * @param id     of voice
   * @return voice
   */
  private JSONObject readOne(DSLContext db, AccessControl access, ULong id) {
    if (access.isTopLevel()) {
      return JSON.objectFromRecord(db.selectFrom(VOICE_EVENT)
        .where(VOICE_EVENT.ID.eq(id))
        .fetchOne());
    } else {
      return JSON.objectFromRecord(db.select(VOICE_EVENT.fields())
        .from(VOICE_EVENT)
        .join(VOICE).on(VOICE.ID.eq(VOICE_EVENT.VOICE_ID))
        .join(PHASE).on(PHASE.ID.eq(VOICE.PHASE_ID))
        .join(IDEA).on(IDEA.ID.eq(PHASE.IDEA_ID))
        .join(LIBRARY).on(LIBRARY.ID.eq(IDEA.LIBRARY_ID))
        .where(VOICE_EVENT.ID.eq(id))
        .and(LIBRARY.ACCOUNT_ID.in(access.getAccounts()))
        .fetchOne());
    }
  }

  /**
   * Read all Event able for an Idea
   *
   * @param db      context
   * @param access  control
   * @param voiceId to read all voice of
   * @return array of voices
   * @throws SQLException on failure
   */
  private JSONArray readAllIn(DSLContext db, AccessControl access, ULong voiceId) throws SQLException {
    if (access.isTopLevel()) {
      return JSON.arrayFromResultSet(db.select(VOICE_EVENT.fields())
        .from(VOICE_EVENT)
        .where(VOICE_EVENT.VOICE_ID.eq(voiceId))
        .orderBy(VOICE_EVENT.POSITION)
        .fetchResultSet());
    } else {
      return JSON.arrayFromResultSet(db.select(VOICE_EVENT.fields())
        .from(VOICE_EVENT)
        .join(VOICE).on(VOICE.ID.eq(VOICE_EVENT.VOICE_ID))
        .join(PHASE).on(PHASE.ID.eq(VOICE.PHASE_ID))
        .join(IDEA).on(IDEA.ID.eq(PHASE.IDEA_ID))
        .join(LIBRARY).on(LIBRARY.ID.eq(IDEA.LIBRARY_ID))
        .where(VOICE_EVENT.VOICE_ID.eq(voiceId))
        .and(LIBRARY.ACCOUNT_ID.in(access.getAccounts()))
        .orderBy(VOICE_EVENT.POSITION)
        .fetchResultSet());
    }
  }

  /**
   * Update a Event record
   *
   * @param db     context
   * @param access control
   * @param id     to update
   * @param data   to update with
   * @throws BusinessException if failure
   */
  private void update(DSLContext db, AccessControl access, ULong id, VoiceEventWrapper data) throws Exception {
    VoiceEvent model = data.validate();
    Map<Field, Object> fieldValues = model.intoFieldValueMap();
    fieldValues.put(VOICE_EVENT.ID, id);

    if (access.isTopLevel()) {
      requireRecordExists("Voice", db.select(VOICE.ID).from(VOICE)
        .where(VOICE.ID.eq(model.getVoiceId()))
        .fetchOne());
    } else {
      requireRecordExists("Voice", db.select(VOICE.ID).from(VOICE)
        .join(PHASE).on(PHASE.ID.eq(VOICE.PHASE_ID))
        .join(IDEA).on(IDEA.ID.eq(PHASE.IDEA_ID))
        .join(LIBRARY).on(LIBRARY.ID.eq(IDEA.LIBRARY_ID))
        .where(LIBRARY.ACCOUNT_ID.in(access.getAccounts()))
        .and(VOICE.ID.eq(model.getVoiceId()))
        .fetchOne());
    }

    if (executeUpdate(db, VOICE_EVENT, fieldValues) == 0) {
      throw new BusinessException("No records updated.");
    }
  }

  /**
   * Delete an Event
   *
   * @param db context
   * @param id to delete
   * @throws Exception         if database failure
   * @throws ConfigException   if not configured properly
   * @throws BusinessException if fails business rule
   */
  private void delete(AccessControl access, DSLContext db, ULong id) throws Exception {
    if (!access.isTopLevel()) {
      requireRecordExists("Voice Meme",
        db.select(VOICE_EVENT.ID).from(VOICE_EVENT)
          .join(Voice.VOICE).on(Voice.VOICE.ID.eq(VOICE_EVENT.VOICE_ID))
          .join(PHASE).on(PHASE.ID.eq(VOICE.PHASE_ID))
          .join(IDEA).on(IDEA.ID.eq(PHASE.IDEA_ID))
          .join(LIBRARY).on(IDEA.LIBRARY_ID.eq(LIBRARY.ID))
          .where(VOICE_EVENT.ID.eq(id))
          .and(LIBRARY.ACCOUNT_ID.in(access.getAccounts()))
          .fetchOne());
    }

    db.deleteFrom(VOICE_EVENT)
      .where(VOICE_EVENT.ID.eq(id))
      .execute();
  }

}