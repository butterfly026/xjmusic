// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.hub.dao;

import io.xj.hub.access.HubAccess;
import io.xj.hub.tables.pojos.Instrument;

import java.util.Collection;
import java.util.UUID;

public interface InstrumentDAO extends DAO<Instrument> {

  /**
   Clone an Instrument into a new Instrument
   [#170290553] Clone sub-entities of instruments

   @param hubAccess control
   @param cloneId   of instrument to clone
   @param entity    for the new Instrument
   @return newly readMany record
   */
  Instrument clone(HubAccess hubAccess, UUID cloneId, Instrument entity) throws DAOException;

  /**
   Fetch many instrument for one Account by id, if accessible

   @param hubAccess control
   @param accountId to fetch instruments for.
   @return Collection of instruments.
   @throws DAOException on failure
   */
  Collection<Instrument> readManyInAccount(HubAccess hubAccess, String accountId) throws DAOException;

  /**
   Fetch all instrument visible to given hubAccess

   @param hubAccess control
   @return Collection of instruments.
   @throws DAOException on failure
   */
  Collection<Instrument> readMany(HubAccess hubAccess) throws DAOException;

  /**
   Read all ids of Instruments in the specified Library ids

   @param hubAccess  control
   @param libraryIds of which to get all instrument ids
   @return instrument ids in the specified library ids
   */
  Collection<UUID> readIdsInLibraries(HubAccess hubAccess, Collection<UUID> libraryIds) throws DAOException;

  /**
   Read many instruments including all child entities

   @param hubAccess     control
   @param instrumentIds to read
   @return collection of entities
   */
  <N> Collection<N> readManyWithChildEntities(HubAccess hubAccess, Collection<UUID> instrumentIds) throws DAOException;

  /**
   Read child entities of many instruments

   @param hubAccess  control
   @param instrumentIds to read
   @param types      of entities to include
   @return collection of entities
   */
  Collection<Object> readChildEntities(HubAccess hubAccess, Collection<UUID> instrumentIds, Collection<String> types) throws DAOException;
}
