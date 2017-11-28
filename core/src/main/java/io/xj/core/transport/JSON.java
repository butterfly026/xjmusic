// Copyright (c) 2017, Outright Mental Inc. (http://outright.io) All Rights Reserved.
package io.xj.core.transport;

import io.xj.core.app.config.Exposure;
import io.xj.core.tables.records.ChainRecord;
import io.xj.core.util.CamelCasify;

import org.jooq.Record;
import org.jooq.Result;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import javax.annotation.Nullable;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.Map;

public abstract class JSON {

  /**
   JSONArray from a SQL ResultSet

   @param rs ResultSet to build JSON of
   @return JSON array
   @throws SQLException  on db failure
   @throws JSONException on failure to construct output
   */
  public static JSONArray arrayOf(ResultSet rs) throws SQLException, JSONException {
    JSONArray result = new JSONArray();
    ResultSetMetaData data = rs.getMetaData();
    int maxCol = data.getColumnCount() + 1;

    /*
     Cache JSON key names for SQL column names
     SQL columns with null values here
     will not be exposed as JSON
    */
    String[] key = new String[maxCol];
    for (int i = 1; i < maxCol; i++) {
      key[i] = CamelCasify.ifNeeded(data.getColumnLabel(i));
    }

    while (rs.next()) {
      JSONObject obj = new JSONObject();

      for (int i = 1; i < maxCol; i++) {
        if (key[i] != null) {
          if (data.getColumnType(i) == java.sql.Types.ARRAY) {
            obj.put(key[i], rs.getArray(i));
          } else if (data.getColumnType(i) == java.sql.Types.BIGINT) {
            obj.put(key[i], rs.getInt(i));
          } else if (data.getColumnType(i) == java.sql.Types.BOOLEAN) {
            obj.put(key[i], rs.getBoolean(i));
          } else if (data.getColumnType(i) == java.sql.Types.BLOB) {
            obj.put(key[i], rs.getBlob(i));
          } else if (data.getColumnType(i) == java.sql.Types.DOUBLE) {
            obj.put(key[i], rs.getDouble(i));
          } else if (data.getColumnType(i) == java.sql.Types.FLOAT) {
            obj.put(key[i], rs.getFloat(i));
          } else if (data.getColumnType(i) == java.sql.Types.INTEGER) {
            obj.put(key[i], rs.getInt(i));
          } else if (data.getColumnType(i) == java.sql.Types.NVARCHAR) {
            obj.put(key[i], rs.getNString(i));
          } else if (data.getColumnType(i) == java.sql.Types.VARCHAR) {
            obj.put(key[i], rs.getString(i));
          } else if (data.getColumnType(i) == java.sql.Types.TINYINT) {
            obj.put(key[i], rs.getInt(i));
          } else if (data.getColumnType(i) == java.sql.Types.SMALLINT) {
            obj.put(key[i], rs.getInt(i));
          } else if (data.getColumnType(i) == java.sql.Types.DATE) {
            obj.put(key[i], rs.getDate(i));
          } else if (data.getColumnType(i) == java.sql.Types.TIMESTAMP) {
            obj.put(key[i], rs.getTimestamp(i));
          } else {
            obj.put(key[i], rs.getObject(i));
          }
        }
      }
      result.put(obj);
    }

    return result;
  }

  /**
   JSONArray from a jOOQ Result

   @param result to build array of
   @param <R>    extends jOOQ Record
   @return JSON array
   */
  public static <R extends Record> JSONArray arrayOf(Result<R> result) {
    JSONArray out = new JSONArray();
    result.forEach(record -> out.put(objectFromRecord(record)));
    return out;
  }

  /**
   JSONArray from a single jOOQ Result

   @param record to put into array
   @return array of a single result
   */
  public static JSONArray arrayOf(ChainRecord record) {
    JSONArray out = new JSONArray();
    out.put(objectFromRecord(record));
    return out;
  }

  /**
   JSONObject of many keys mapped to JSONObject

   @param data map to build object of arrays from
   @return JSONObject
   */
  public static JSONObject wrap(Map<String, JSONArray> data) {
    JSONObject out = new JSONObject();
    data.forEach(out::put);
    return out;
  }

  /**
   JSONObject from a jOOQ Record

   @param record to construct output from
   @return JSON object
   */
  @Nullable
  public static JSONObject objectFromRecord(Record record) {
    if (record == null) {
      return null;
    }
    JSONObject result = new JSONObject();
    record.intoMap().forEach((k, v) -> {
      String colName = CamelCasify.ifNeeded(k);
      if (colName != null) {
        result.put(colName, v);
      }
    });
    return result;
  }

  /**
   JSONObject wrapping an internal object put at a root node

   @param rootName root node name
   @param data     to put in root node
   @return JSON object
   */
  public static JSONObject wrap(String rootName, JSONObject data) {
    JSONObject result = new JSONObject();
    result.put(rootName, data);
    return result;
  }

  /**
   JSONObject wrapping an internal array put at a root node

   @param rootName root node name
   @param data     to put in root node
   @return JSON object
   */
  public static JSONObject wrap(String rootName, JSONArray data) {
    JSONObject result = new JSONObject();
    result.put(rootName, data);
    return result;
  }

  /**
   JSONObject wrapping an error

   @param message to wrap as error
   @return JSON object
   */
  public static JSONObject wrapError(String message) {
    JSONObject error = new JSONObject();
    error.put(Exposure.KEY_ERROR_DETAIL, message);

    JSONArray errorsArr = new JSONArray();
    errorsArr.put(error);

    return wrap(Exposure.KEY_ERRORS, errorsArr);
  }

//  public static JSONObject wrap(String rootName, List<String> data) {
//    JSONObject result = new JSONObject();
//    result.put(rootName, data);
//    return result;
//  }

}