// Copyright (c) 2017, Outright Mental Inc. (http://outright.io) All Rights Reserved.
package io.xj.core.dao;

import io.xj.core.app.access.impl.Access;
import io.xj.core.model.chain.Chain;
import io.xj.core.model.chain.ChainState;
import io.xj.core.tables.records.ChainRecord;

import org.jooq.Result;
import org.jooq.types.ULong;

import org.json.JSONObject;

import javax.annotation.Nullable;
import java.sql.Timestamp;

public interface ChainDAO {
  /**
   Create a new Chain

   @param entity for the new Chain.
   @return newly readMany Chain record.
   */
  ChainRecord create(Access access, Chain entity) throws Exception;

  /**
   Fetch one Chain (as JSON Object) by id, if accessible

   @param access  control
   @param chainId to fetch
   @return Chain if found
   @throws Exception on failure
   */
  @Nullable
  ChainRecord readOne(Access access, ULong chainId) throws Exception;

  /**
   Read all Chains that are accessible

   @param access control
   @return array of chains as JSON
   @throws Exception on failure
   */
  Result<ChainRecord> readAll(Access access, ULong accountId) throws Exception;


  /**
   [INTERNAL USE ONLY]
   Read all records in a given state

   @return array of chains as JSON
   @throws Exception on failure
    @param access     control
   @param state to read chains in
   @param limit records max
   */
  Result<ChainRecord> readAllInState(Access access, ChainState state, Integer limit) throws Exception;

  /**
   [INTERNAL USE ONLY]
   Read IDs of all Chains that are in fabricating-state at a given instant

   @param access     control
   @param atOrBefore time to check for chains in fabricating-state
   @return array of chains as JSON
   @throws Exception on failure
   */
  Result<ChainRecord> readAllInStateFabricating(Access access, Timestamp atOrBefore) throws Exception;

  /**
   Update a specified Chain

   @param id     of specific Chain to update.
   @param entity for the updated Chain.
   */
  void update(Access access, ULong id, Chain entity) throws Exception;

  /**
   Update the state of a specified Chain

   @param id    of specific Chain to update.
   @param state for the updated Chain.
   */
  void updateState(Access access, ULong id, ChainState state) throws Exception;

  /**
   [INTERNAL USE ONLY]
   Build a JSON Object template for the next link in this Chain,
   or setContent the Chain state to COMPLETE.

   @param linkBeginBefore         ahead to create Link before end of previous Link  @return array of chain Ids
   @param chainStopCompleteBefore behind to consider a chain complete
   */
  JSONObject
  buildNextLinkOrComplete(Access access, ChainRecord chain, Timestamp linkBeginBefore, Timestamp chainStopCompleteBefore) throws Exception;

  /**
   Delete a specified Chain

   @param chainId of specific Chain to delete.
   */
  void delete(Access access, ULong chainId) throws Exception;

  /**
   Erase a specified Chain (mark it for deletion by worker)

   @param chainId of specific Chain to erase.
   */
  void erase(Access access, ULong chainId) throws Exception;
}
