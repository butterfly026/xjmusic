// Copyright Outright Mental, Inc. All Rights Reserved.
package io.outright.xj.hub.controller.account;

import com.google.inject.Inject;
import io.outright.xj.core.app.db.SQLDatabaseProvider;
import io.outright.xj.core.app.exception.BusinessException;
import io.outright.xj.core.app.exception.ConfigException;
import io.outright.xj.core.app.exception.DatabaseException;
import io.outright.xj.core.app.output.JSONOutputProvider;
import io.outright.xj.core.model.account.AccountWrapper;
import io.outright.xj.core.tables.records.AccountRecord;
import org.jooq.DSLContext;
import org.jooq.types.ULong;
import org.json.JSONArray;
import org.json.JSONObject;

import javax.annotation.Nullable;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import static io.outright.xj.core.Tables.ACCOUNT;
import static io.outright.xj.core.tables.AccountUser.ACCOUNT_USER;
import static io.outright.xj.core.tables.Library.LIBRARY;

public class AccountControllerImpl implements AccountController {
  //  private static Logger log = LoggerFactory.getLogger(AccountControllerImpl.class);
  private SQLDatabaseProvider dbProvider;
  private JSONOutputProvider jsonOutputProvider;

  @Inject
  public AccountControllerImpl(
    SQLDatabaseProvider dbProvider,
    JSONOutputProvider jsonOutputProvider
  ) {
    this.dbProvider = dbProvider;
    this.jsonOutputProvider = jsonOutputProvider;
  }

  @Override
  public JSONObject create(AccountWrapper data) throws DatabaseException, ConfigException, BusinessException {
    Connection conn = dbProvider.getConnectionTransaction();
    DSLContext db = dbProvider.getContext(conn);
    AccountRecord newRecord;

    try {
      data.validate();

      newRecord = db.newRecord(ACCOUNT);
      newRecord.setName(data.getAccount().getName());
      newRecord.store();

      dbProvider.commitAndClose(conn);
    } catch (Exception e) {
      dbProvider.rollbackAndClose(conn);
      throw e;
    }

    return jsonOutputProvider.objectFromRecord(newRecord);
  }

  @Override
  @Nullable
  public JSONObject readOne(ULong accountId) throws DatabaseException {
    Connection conn = dbProvider.getConnection();
    DSLContext db = dbProvider.getContext(conn);

    JSONObject result = jsonOutputProvider.objectFromRecord(db.selectFrom(ACCOUNT)
      .where(ACCOUNT.ID.eq(accountId))
      .fetchOne());

    dbProvider.close(conn);
    return result;
  }

  @Nullable
  @Override
  public JSONObject readOneVisible(ULong fromUserId, ULong accountId) throws DatabaseException {
    Connection conn = dbProvider.getConnection();
    DSLContext db = dbProvider.getContext(conn);

    JSONObject result = jsonOutputProvider.objectFromRecord(db.select()
      .from(ACCOUNT)
      .join(ACCOUNT_USER).on(ACCOUNT_USER.USER_ID.eq(fromUserId)).and(ACCOUNT_USER.ACCOUNT_ID.eq(ACCOUNT.ID))
      .where(ACCOUNT.ID.eq(accountId))
      .fetchOne());

    dbProvider.close(conn);
    return result;
  }

  @Override
  @Nullable
  public JSONArray readAll() throws DatabaseException {
    Connection conn = dbProvider.getConnection();
    DSLContext db = dbProvider.getContext(conn);

    JSONArray result;
    try {
      result = jsonOutputProvider.arrayFromResultSet(db.select(
        ACCOUNT.ID,
        ACCOUNT.NAME
      )
        .from(ACCOUNT)
        .fetchResultSet());
    } catch (SQLException e) {
      dbProvider.close(conn);
      throw new DatabaseException("SQLException: " + e);
    }

    dbProvider.close(conn);
    return result;
  }

  @Nullable
  @Override
  public JSONArray readAllVisible(ULong fromUserId) throws DatabaseException {
    Connection conn = dbProvider.getConnection();
    DSLContext db = dbProvider.getContext(conn);

    JSONArray result;
    try {
      result = jsonOutputProvider.arrayFromResultSet(db.select(
        ACCOUNT.ID,
        ACCOUNT.NAME
      )
        .from(ACCOUNT)
        .join(ACCOUNT_USER).on(ACCOUNT_USER.USER_ID.eq(fromUserId)).and(ACCOUNT_USER.ACCOUNT_ID.eq(ACCOUNT.ID))
        .fetchResultSet());
    } catch (SQLException e) {
      dbProvider.close(conn);
      throw new DatabaseException("SQLException: " + e);
    }

    dbProvider.close(conn);
    return result;
  }

  @Override
  public void update(ULong accountId, AccountWrapper data) throws DatabaseException, ConfigException, BusinessException {
    Connection conn = dbProvider.getConnectionTransaction();
    DSLContext db = dbProvider.getContext(conn);

    try {
      data.validate();

      db.update(ACCOUNT)
        .set(ACCOUNT.NAME, data.getAccount().getName())
        .where(ACCOUNT.ID.eq(accountId))
        .execute();

      dbProvider.commitAndClose(conn);
    } catch (Exception e) {
      dbProvider.rollbackAndClose(conn);
      throw e;
    }
  }

  @Override
  public void delete(ULong accountId) throws DatabaseException, ConfigException, BusinessException {
    Connection conn = dbProvider.getConnectionTransaction();
    DSLContext db = dbProvider.getContext(conn);

    try {
      delete(db, accountId);
      dbProvider.commitAndClose(conn);
    } catch (Exception e) {
      dbProvider.rollbackAndClose(conn);
      throw e;
    }
  }

  /**
   * Delete an Account
   *
   * @param db        context
   * @param accountId to delete
   * @throws DatabaseException if database failure
   * @throws ConfigException   if not configured properly
   * @throws BusinessException if fails business rule
   */
  private void delete(DSLContext db, ULong accountId) throws DatabaseException, ConfigException, BusinessException {
    assertEmptyResultSet(db.select(LIBRARY.ID)
      .from(LIBRARY)
      .where(LIBRARY.ACCOUNT_ID.eq(accountId))
      .fetchResultSet());

    assertEmptyResultSet(db.select(ACCOUNT_USER.ID)
      .from(ACCOUNT_USER)
      .where(ACCOUNT_USER.ACCOUNT_ID.eq(accountId))
      .fetchResultSet());

    db.deleteFrom(ACCOUNT)
      .where(ACCOUNT.ID.eq(accountId))
      .andNotExists(
        db.select(LIBRARY.ID)
          .from(LIBRARY)
          .where(LIBRARY.ACCOUNT_ID.eq(accountId))
      )
      .andNotExists(
        db.select(ACCOUNT_USER.ID)
          .from(ACCOUNT_USER)
          .where(ACCOUNT_USER.ACCOUNT_ID.eq(accountId))
      )
      .execute();
  }

  /**
   * Fail if ResultSet is not empty.
   *
   * @param resultSet to check.
   * @throws BusinessException if result set is not empty.
   * @throws DatabaseException if something goes wrong.
   */
  private void assertEmptyResultSet(ResultSet resultSet) throws BusinessException, DatabaseException {
    try {
      if (resultSet.next()) {
        throw new BusinessException("Cannot delete Account which has one or more " + resultSet.getMetaData().getTableName(1) + ".");
      }
    } catch (SQLException e) {
      throw new DatabaseException("SQLException: " + e.getMessage());
    }
  }

}
