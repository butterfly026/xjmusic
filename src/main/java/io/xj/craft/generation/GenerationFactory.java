// Copyright (c) 2020, XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.craft.generation;

import io.xj.core.ingest.Ingest;
import io.xj.core.exception.CoreException;
import io.xj.craft.generation.superpattern.LibrarySupersequenceGeneration;
import io.xj.core.model.ProgramSequence;

import com.google.inject.assistedinject.Assisted;

/**
 Encapsulate generation-related functionality, by providing an Ingest of source entities
 */
@FunctionalInterface
public interface GenerationFactory {

  /**
   [#154548999] Artist wants to generate a Library Supersequence in order to of a Detail sequence that covers the chord progressions of all existing Main Sequences in a Library.

   @param sequence    target to build generation around
   @param ingest Ingest to be generated of
   @return LibrarySupersequenceGeneration
   @throws CoreException on failure
   */
  LibrarySupersequenceGeneration librarySupersequence(
    @Assisted("sequence") ProgramSequence sequence,
    @Assisted("ingest") Ingest ingest
  ) throws CoreException;

}