// Copyright Outright Mental, Inc. All Rights Reserved.
package io.outright.xj.core.dao;

import io.outright.xj.core.app.access.impl.AccessControl;
import io.outright.xj.core.model.link.LinkWrapper;

import org.jooq.types.ULong;

import org.json.JSONArray;
import org.json.JSONObject;

import javax.annotation.Nullable;
import java.sql.Timestamp;

public interface LinkDAO {
  /**
   * Create a new Link
   *
   * @param data for the new Link.
   * @return newly created Link record.
   */
  JSONObject create(AccessControl access, LinkWrapper data) throws Exception;

  /**
   * Fetch one Link by id, if accessible
   *
   * @param access control
   * @param linkId to fetch
   * @return Link if found
   * @throws Exception on failure
   */
  @Nullable
  JSONObject readOne(AccessControl access, ULong linkId) throws Exception;

  /**
   * Fetch one Link by chainId and state, if present
   *
   * @param access          control
   * @param chainId         to find link in
   * @param linkState       linkState to find link in
   * @param linkBeginBefore ahead to look for links
   * @return Link if found
   * @throws Exception on failure
   */
  @Nullable
  JSONObject readOneInState(AccessControl access, ULong chainId, String linkState, Timestamp linkBeginBefore) throws Exception;

  /**
   * Read all Links that are accessible
   *
   * @param access control
   * @return array of links as JSON
   * @throws Exception on failure
   */
  @Nullable
  JSONArray readAllIn(AccessControl access, ULong chainId) throws Exception;

  /**
   * [INTERNAL USE ONLY]
   * Read array of Ids of Chains needing a Link appended to the end.
   *
   * @param chainId         to read pilot link template for
   * @param chainStartAt    when the chain start
   * @param chainStopAt     when the chain stops
   * @param linkBeginBefore ahead to create Link before end of previous Link  @return array of chain Ids
   */
  JSONObject readPilotTemplateFor(AccessControl access, ULong chainId, Timestamp chainStartAt, Timestamp chainStopAt, Timestamp linkBeginBefore) throws Exception;

  /**
   * Update a specified Link
   *
   * @param linkId of specific Link to update.
   * @param data   for the updated Link.
   */
  void update(AccessControl access, ULong linkId, LinkWrapper data) throws Exception;

  /**
   * Delete a specified Link
   *
   * @param linkId of specific Link to delete.
   */
  void delete(AccessControl access, ULong linkId) throws Exception;
}
