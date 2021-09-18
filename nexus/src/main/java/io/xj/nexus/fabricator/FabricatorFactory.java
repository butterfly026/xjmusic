// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.nexus.fabricator;

import com.google.inject.assistedinject.Assisted;
import io.xj.api.Chain;
import io.xj.api.Segment;
import io.xj.nexus.NexusException;
import io.xj.nexus.hub_client.client.HubContent;

/**
 Fabricator content = contentFactory.fabricate(segment);
 ... do things with this content, like craft or dub ...
 content.putReport();
 <p>
 [#176625033] Unify guice factory with explicit methods to construct components from Fabricator
 */
public interface FabricatorFactory {
  /**
   Create a fabricator to fabricate a segment

   @return Fabricator
   @throws NexusException on failure
   @param sourceMaterial from which to fabricate
   @param segment        segment to be fabricated
   */
  Fabricator fabricate(
    @Assisted("sourceMaterial") HubContent sourceMaterial,
    @Assisted("segment") Segment segment
  ) throws NexusException;

  /**
   Create a retrospective to fabricate a particular segment
   <p>
   Fabricator content = contentFactory.workOn(segment);
   ... do things with this content, like craft or dub ...
   content.putReport();

   @return SegmentRetrospective
   @throws NexusException on failure
   @param segment        Segment that's on the workbench
   @param sourceMaterial to get answers about the segment content
   */
  SegmentRetrospective loadRetrospective(
    @Assisted("segment") Segment segment,
    @Assisted("sourceMaterial") HubContent sourceMaterial
  ) throws NexusException;

  /**
   Configure a TimeComputer instance for a segment
   <p>
   [#153542275] Segment wherein velocity changes expect perfectly smooth sound of previous segment through to following segment

   @param totalBeats of the segment
   @param fromTempo  at the beginning of the segment (in Beats Per Minute)
   @param toTempo    at the end of the segment  (in Beats Per Minute)
   @return TimeComputer instance
   */
  TimeComputer createTimeComputer(
    @Assisted("totalBeats") double totalBeats,
    @Assisted("fromTempo") double fromTempo,
    @Assisted("toTempo") double toTempo
  );

  /**
   Create a workbench to fabricate a particular segment

   @return SegmentWorkbench
   @throws NexusException on failure
   @param segment Segment to be worked on
   */
  SegmentWorkbench setupWorkbench(
    @Assisted("chain") Chain chain,
    @Assisted("segment") Segment segment
  ) throws NexusException;
}
