// Copyright (c) 2018, XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.dub;

import io.xj.core.exception.ConfigException;
import io.xj.craft.basis.Basis;
import io.xj.dub.master.MasterDub;
import io.xj.dub.ship.ShipDub;

import com.google.inject.assistedinject.Assisted;

/**
 Dub is performed:
 1. Dub
 <p>
 Basis basis = basisFactory.createBasis(segment);
 dubFactory.master(basis).dub();
 basis.sendReport();
 */
public interface DubFactory {

  /**
   Create Master Dub instance for a particular segment
   [#141] Dubworker Segment mix final output from instrument-audio-arrangements

   @param basis of dub
   @return MasterDub
   @throws ConfigException on failure
   */
  MasterDub master(
    @Assisted("basis") Basis basis
  ) throws ConfigException;

  /**
   Create Ship Dub instance for a particular segment
   [#264] Segment audio is compressed to MP3 and shipped to https://segment.xj.io

   @param basis of dub
   @return ShipDub
   @throws ConfigException on failure
   */
  ShipDub ship(
    @Assisted("basis") Basis basis
  ) throws ConfigException;

}
