// Copyright (c) 2018, XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.craft.ingest.cache;

import io.xj.core.access.impl.Access;
import io.xj.craft.ingest.Ingest;
import io.xj.core.model.entity.Entity;

import java.util.Collection;

/**
 [#154350346] Architect wants a universal Ingest Factory, to modularize graph mathematics used during craft to evaluate any combination of Library, Sequence, and Instrument for any purpose.
 Ingest ingest = evaluationFactory.of(...any combination of libraries, instruments, and sequences...);
 */
@FunctionalInterface
public interface IngestCacheProvider {

  /**
   Evaluate any combination of Entities for ingest. Assumes inclusion of child entities of all entities provided
   CACHES the result for any access+entities signature, for N seconds.
   Where N is configurable in system properties `ingest.cache.seconds`

   @param access control
   @return entities to be evaluated
   @throws Exception on failure to of target entities
   */
  Ingest evaluate(Access access, Collection<Entity> entities) throws Exception;
}
