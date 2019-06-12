// Copyright (c) 2018, XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.core.dao.impl;

import com.google.api.client.util.Maps;
import com.google.inject.Inject;
import io.xj.core.access.impl.Access;
import io.xj.core.dao.LibraryDAO;
import io.xj.core.exception.CoreException;
import io.xj.core.model.library.Library;
import io.xj.core.persistence.sql.SQLDatabaseProvider;
import io.xj.core.persistence.sql.impl.SQLConnection;
import org.jooq.DSLContext;
import org.jooq.Field;
import org.jooq.types.ULong;

import javax.annotation.Nullable;
import java.math.BigInteger;
import java.util.Collection;
import java.util.Map;
import java.util.Objects;

import static io.xj.core.Tables.LIBRARY;
import static io.xj.core.Tables.PROGRAM;
import static io.xj.core.Tables.SEQUENCE;
import static io.xj.core.tables.Account.ACCOUNT;
import static io.xj.core.tables.Instrument.INSTRUMENT;

public class LibraryDAOImpl extends DAOImpl implements LibraryDAO {

  @Inject
  public LibraryDAOImpl(
    SQLDatabaseProvider dbProvider
  ) {
    this.dbProvider = dbProvider;
  }

  /**
   Create a new record

   @param db     context
   @param access control
   @param entity for new record
   @return newly readMany record
   @throws CoreException if a Business Rule is violated
   */
  private static Library create(DSLContext db, Access access, Library entity) throws CoreException {
    entity.validate();

    Map<Field, Object> fieldValues = fieldValueMap(entity);

    if (!access.isTopLevel())
      requireExists("Account",
        db.selectCount().from(ACCOUNT)
          .where(ACCOUNT.ID.in(access.getAccountIds()))
          .fetchOne(0, int.class));

    return modelFrom(executeCreate(db, LIBRARY, fieldValues), Library.class);
  }

  /**
   Read one record

   @param db     context
   @param access control
   @param id     of record
   @return record
   */
  private static Library readOne(DSLContext db, Access access, ULong id) throws CoreException {
    if (access.isTopLevel())
      return modelFrom(db.selectFrom(LIBRARY)
        .where(LIBRARY.ID.eq(id))
        .fetchOne(), Library.class);
    else
      return modelFrom(db.select(LIBRARY.fields())
        .from(LIBRARY)
        .where(LIBRARY.ID.eq(id))
        .and(LIBRARY.ACCOUNT_ID.in(access.getAccountIds()))
        .fetchOne(), Library.class);
  }

  /**
   Read all records in parent by id

   @param db         context
   @param access     control
   @param accountIds of parent
   @return array of records
   */
  private static Collection<Library> readAll(DSLContext db, Access access, Collection<ULong> accountIds) throws CoreException {
    if (access.isTopLevel())
      return modelsFrom(db.select(LIBRARY.fields())
        .from(LIBRARY)
        .where(LIBRARY.ACCOUNT_ID.in(accountIds))
        .fetch(), Library.class);
    else
      return modelsFrom(db.select(LIBRARY.fields())
        .from(LIBRARY)
        .where(LIBRARY.ACCOUNT_ID.in(accountIds))
        .and(LIBRARY.ACCOUNT_ID.in(access.getAccountIds()))
        .fetch(), Library.class);
  }

  /**
   Read all records visible to user

   @param db     context
   @param access control
   @return array of records
   */
  private static Collection<Library> readAll(DSLContext db, Access access) throws CoreException {
    if (access.isTopLevel())
      return modelsFrom(db.select(LIBRARY.fields())
        .from(LIBRARY)
        .fetch(), Library.class);
    else
      return modelsFrom(db.select(LIBRARY.fields())
        .from(LIBRARY)
        .where(LIBRARY.ACCOUNT_ID.in(access.getAccountIds()))
        .fetch(), Library.class);
  }

  /**
   Update a record

   @param db     context
   @param access control
   @param id     of record
   @param entity to update with
   @throws CoreException if a Business Rule is violated
   */
  private static void update(DSLContext db, Access access, ULong id, Library entity) throws CoreException {
    entity.validate();
    Map<Field, Object> fieldValues = fieldValueMap(entity);
    fieldValues.put(LIBRARY.ID, id);

    if (!access.isTopLevel()) {
      requireExists("Library",
        db.selectCount().from(LIBRARY)
          .where(LIBRARY.ID.eq(id))
          .fetchOne(0, int.class));
      requireExists("Account",
        db.selectCount().from(ACCOUNT)
          .where(ACCOUNT.ID.in(access.getAccountIds()))
          .fetchOne(0, int.class));
    }

    if (0 == executeUpdate(db, LIBRARY, fieldValues))
      throw new CoreException("No records updated.");
  }

  /**
   Delete a Library

   @param db        context
   @param access    control
   @param libraryId to delete
   @throws CoreException if database failure
   @throws CoreException if not configured properly
   @throws CoreException if fails business rule
   */
  private static void delete(DSLContext db, Access access, ULong libraryId) throws CoreException {
    requireTopLevel(access);

    requireNotExists("Program in Library", db.select(PROGRAM.ID)
      .from(PROGRAM)
      .where(PROGRAM.LIBRARY_ID.eq(libraryId))
      .fetch().into(PROGRAM));

    requireNotExists("Instrument in Library", db.select(INSTRUMENT.ID)
      .from(INSTRUMENT)
      .where(INSTRUMENT.LIBRARY_ID.eq(libraryId))
      .fetch().into(INSTRUMENT));

    db.deleteFrom(LIBRARY)
      .where(LIBRARY.ID.eq(libraryId))
      .andNotExists(
        db.select(PROGRAM.ID)
          .from(PROGRAM)
          .where(PROGRAM.LIBRARY_ID.eq(libraryId))
      )
      .andNotExists(
        db.select(INSTRUMENT.ID)
          .from(INSTRUMENT)
          .where(INSTRUMENT.LIBRARY_ID.eq(libraryId))
      )
      .execute();
  }

  /**
   Only certain (writable) fields are mapped back to jOOQ records--
   Read-only fields are excluded from here.

   @param entity to source values from
   @return values mapped to record fields
   */
  private static Map<Field, Object> fieldValueMap(Library entity) {
    Map<Field, Object> fieldValues = Maps.newHashMap();
    fieldValues.put(LIBRARY.NAME, entity.getName());
    fieldValues.put(LIBRARY.ACCOUNT_ID, entity.getAccountId());
    return fieldValues;
  }

  @Override
  public Library create(Access access, Library entity) throws CoreException {
    SQLConnection tx = dbProvider.getConnection();
    try {
      return tx.success(create(tx.getContext(), access, entity));
    } catch (CoreException e) {
      throw tx.failure(e);
    }
  }

  @Override
  @Nullable
  public Library readOne(Access access, BigInteger id) throws CoreException {
    SQLConnection tx = dbProvider.getConnection();
    try {
      return tx.success(readOne(tx.getContext(), access, ULong.valueOf(id)));
    } catch (CoreException e) {
      throw tx.failure(e);
    }
  }

  @Override
  public Collection<Library> readMany(Access access, Collection<BigInteger> parentIds) throws CoreException {
    SQLConnection tx = dbProvider.getConnection();
    try {
      if (Objects.nonNull(parentIds) && !parentIds.isEmpty()) {
        return tx.success(readAll(tx.getContext(), access, uLongValuesOf(parentIds)));
      } else {
        return tx.success(readAll(tx.getContext(), access));
      }

    } catch (CoreException e) {
      throw tx.failure(e);
    }
  }

  @Override
  public void update(Access access, BigInteger id, Library entity) throws CoreException {
    SQLConnection tx = dbProvider.getConnection();
    try {
      update(tx.getContext(), access, ULong.valueOf(id), entity);
      tx.success();
    } catch (CoreException e) {
      throw tx.failure(e);
    }
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

  @Override
  public Library newInstance() {
    return new Library();
  }
}
