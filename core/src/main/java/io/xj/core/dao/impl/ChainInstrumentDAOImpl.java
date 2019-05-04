// Copyright (c) 2018, XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.core.dao.impl;

import io.xj.core.access.impl.Access;
import io.xj.core.dao.ChainInstrumentDAO;
import io.xj.core.exception.CoreException;
import io.xj.core.exception.CoreException;
import io.xj.core.model.chain_instrument.ChainInstrument;
import io.xj.core.persistence.sql.SQLDatabaseProvider;
import io.xj.core.persistence.sql.impl.SQLConnection;

import org.jooq.DSLContext;
import org.jooq.Field;
import org.jooq.types.ULong;

import com.google.api.client.util.Maps;
import com.google.inject.Inject;

import java.math.BigInteger;
import java.util.Collection;
import java.util.Map;

import static io.xj.core.tables.Chain.CHAIN;
import static io.xj.core.tables.ChainInstrument.CHAIN_INSTRUMENT;
import static io.xj.core.tables.Instrument.INSTRUMENT;
import static io.xj.core.tables.Library.LIBRARY;

public class ChainInstrumentDAOImpl extends DAOImpl implements ChainInstrumentDAO {

  @Inject
  public ChainInstrumentDAOImpl(
    SQLDatabaseProvider dbProvider
  ) {
    this.dbProvider = dbProvider;
  }

  /**
   Create a new Chain Instrument record

   @param db     context
   @param entity for new ChainInstrument
   @return new record
   @throws CoreException         if database failure
   @throws CoreException   if not configured properly
   @throws CoreException if fails business rule
   */
  private static ChainInstrument create(DSLContext db, Access access, ChainInstrument entity) throws CoreException {
    entity.validate();

    Map<Field, Object> fieldValues = fieldValueMap(entity);

    if (access.isTopLevel()) {
      requireExists("Chain", db.selectCount().from(CHAIN)
        .where(CHAIN.ID.eq(ULong.valueOf(entity.getChainId())))
        .fetchOne(0, int.class));
      requireExists("Instrument", db.selectCount().from(INSTRUMENT)
        .where(INSTRUMENT.ID.eq(ULong.valueOf(entity.getInstrumentId())))
        .fetchOne(0, int.class));
    } else {
      requireExists("Chain", db.selectCount().from(CHAIN)
        .where(CHAIN.ACCOUNT_ID.in(access.getAccountIds()))
        .and(CHAIN.ID.eq(ULong.valueOf(entity.getChainId())))
        .fetchOne(0, int.class));
      requireExists("Instrument", db.selectCount().from(INSTRUMENT)
        .join(LIBRARY).on(LIBRARY.ID.eq(INSTRUMENT.LIBRARY_ID))
        .where(INSTRUMENT.ID.eq(ULong.valueOf(entity.getInstrumentId())))
        .and(LIBRARY.ACCOUNT_ID.in(access.getAccountIds()))
        .fetchOne(0, int.class));
    }

    if (null != db.selectFrom(CHAIN_INSTRUMENT)
      .where(CHAIN_INSTRUMENT.CHAIN_ID.eq(ULong.valueOf(entity.getChainId())))
      .and(CHAIN_INSTRUMENT.INSTRUMENT_ID.eq(ULong.valueOf(entity.getInstrumentId())))
      .fetchOne())
      throw new CoreException("Instrument already added to Chain!");

    return modelFrom(executeCreate(db, CHAIN_INSTRUMENT, fieldValues), ChainInstrument.class);
  }

  /**
   Read one record

   @param db     context
   @param access control
   @param id     of record
   @return record
   */
  private static ChainInstrument readOne(DSLContext db, Access access, ULong id) throws CoreException {
    if (access.isTopLevel())
      return modelFrom(db.selectFrom(CHAIN_INSTRUMENT)
        .where(CHAIN_INSTRUMENT.ID.eq(id))
        .fetchOne(), ChainInstrument.class);
    else
      return modelFrom(db.select(CHAIN_INSTRUMENT.fields()).from(CHAIN_INSTRUMENT)
        .join(INSTRUMENT).on(INSTRUMENT.ID.eq(CHAIN_INSTRUMENT.INSTRUMENT_ID))
        .join(LIBRARY).on(LIBRARY.ID.eq(INSTRUMENT.LIBRARY_ID))
        .where(CHAIN_INSTRUMENT.ID.eq(id))
        .and(LIBRARY.ACCOUNT_ID.in(access.getAccountIds()))
        .fetchOne(), ChainInstrument.class);
  }

  /**
   Read all records in parent record

   @param db      context
   @param access  control
   @param chainId of parent
   @return array of child records
   */
  private static Collection<ChainInstrument> readAll(DSLContext db, Access access, Collection<ULong> chainId) throws CoreException {
    if (access.isTopLevel())
      return modelsFrom(db.selectFrom(CHAIN_INSTRUMENT)
        .where(CHAIN_INSTRUMENT.CHAIN_ID.in(chainId))
        .fetch(), ChainInstrument.class);
    else
      return modelsFrom(db.select(CHAIN_INSTRUMENT.fields()).from(CHAIN_INSTRUMENT)
        .join(INSTRUMENT).on(INSTRUMENT.ID.eq(CHAIN_INSTRUMENT.INSTRUMENT_ID))
        .join(LIBRARY).on(LIBRARY.ID.eq(INSTRUMENT.LIBRARY_ID))
        .where(CHAIN_INSTRUMENT.CHAIN_ID.in(chainId))
        .and(LIBRARY.ACCOUNT_ID.in(access.getAccountIds()))
        .fetch(), ChainInstrument.class);
  }

  /**
   Delete a record

   @param db     context
   @param access control
   @param id     of record
   @throws CoreException on failure
   */
  private static void delete(DSLContext db, Access access, ULong id) throws CoreException {
    if (access.isTopLevel())
      requireExists("Chain Instrument", db.selectCount().from(CHAIN_INSTRUMENT)
        .where(CHAIN_INSTRUMENT.ID.eq(id))
        .fetchOne(0, int.class));
    else
      requireExists("Chain Instrument", db.selectCount().from(CHAIN_INSTRUMENT)
        .join(INSTRUMENT).on(INSTRUMENT.ID.eq(CHAIN_INSTRUMENT.INSTRUMENT_ID))
        .join(LIBRARY).on(LIBRARY.ID.eq(INSTRUMENT.LIBRARY_ID))
        .where(CHAIN_INSTRUMENT.ID.eq(id))
        .and(LIBRARY.ACCOUNT_ID.in(access.getAccountIds()))
        .fetchOne(0, int.class));

    db.deleteFrom(CHAIN_INSTRUMENT)
      .where(CHAIN_INSTRUMENT.ID.eq(id))
      .execute();
  }

  /**
   Only certain (writable) fields are mapped back to jOOQ records--
   Read-only fields are excluded from here.

   @param entity to source values from
   @return values mapped to record fields
   */
  private static Map<Field, Object> fieldValueMap(ChainInstrument entity) {
    Map<Field, Object> fieldValues = Maps.newHashMap();
    fieldValues.put(CHAIN_INSTRUMENT.CHAIN_ID, ULong.valueOf(entity.getChainId()));
    fieldValues.put(CHAIN_INSTRUMENT.INSTRUMENT_ID, ULong.valueOf(entity.getInstrumentId()));
    return fieldValues;
  }

  @Override
  public ChainInstrument create(Access access, ChainInstrument entity) throws CoreException {
    SQLConnection tx = dbProvider.getConnection();
    try {
      return tx.success(create(tx.getContext(), access, entity));
    } catch (CoreException e) {
      throw tx.failure(e);
    }
  }

  @Override
  public ChainInstrument readOne(Access access, BigInteger id) throws CoreException {
    SQLConnection tx = dbProvider.getConnection();
    try {
      return tx.success(readOne(tx.getContext(), access, ULong.valueOf(id)));
    } catch (CoreException e) {
      throw tx.failure(e);
    }
  }

  @Override
  public Collection<ChainInstrument> readAll(Access access, Collection<BigInteger> parentIds) throws CoreException {
    SQLConnection tx = dbProvider.getConnection();
    try {
      return tx.success(readAll(tx.getContext(), access, uLongValuesOf(parentIds)));
    } catch (CoreException e) {
      throw tx.failure(e);
    }
  }

  @Override
  public void update(Access access, BigInteger id, ChainInstrument entity) throws CoreException {
    throw new CoreException("Not allowed to update ChainInstrument record.");
  }

  @Override
  public void destroy(Access access, BigInteger id) throws CoreException {
    SQLConnection tx = dbProvider.getConnection();
    try {
      delete(tx.getContext(), access, ULong.valueOf(id));
      tx.success();
    } catch (CoreException e) {
      throw tx.failure(e);
    }
  }

}
