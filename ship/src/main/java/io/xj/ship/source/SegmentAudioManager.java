// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.

package io.xj.ship.source;

import io.xj.api.Segment;
import io.xj.lib.filestore.FileStoreException;
import io.xj.lib.mixer.FormatException;
import io.xj.ship.ShipException;

import java.io.IOException;
import java.time.Instant;
import java.util.Collection;
import java.util.Optional;
import java.util.UUID;

/**
 Ship broadcast via HTTP Live Streaming https://www.pivotaltracker.com/story/show/179453189
 */
public interface SegmentAudioManager {

  /**
   Get the segment audio for a given segment id

   @param segmentId for which to get audio
   @return segment audio if found
   */
  Optional<SegmentAudio> get(UUID segmentId);

  /**
   Preload on disk an uncompressed version of the segment audio

   @param shipKey of template for which to load audio
   @param segment to load
   */
  void load(String shipKey, Segment segment) throws ShipException, IOException, FormatException, FileStoreException;

  /**
   Put a Segment Audio in the store

   @param segmentAudio to put
   */
  void put(SegmentAudio segmentAudio);

  /**
   Destroy the audio for a segment

   @param segmentId for which to destroy audio
   */
  void collectGarbage(UUID segmentId);

  /**
   Retry a segment

   @param segmentId to retry
   */
  void retry(UUID segmentId) throws ShipException;

  /**
   Get all segments intersecting the specified time frame

   @param shipKey     of segments
   @param fromInstant time frame
   @param toInstant   time frame
   @return all segments intersecting the time frame
   */
  Collection<SegmentAudio> getAllIntersecting(String shipKey, Instant fromInstant, Instant toInstant);

  /**
   Send telemetry about currently loaded source audio
   <p>
   Ship should not enter permanent failure state unable to load segments https://www.pivotaltracker.com/story/show/180756082
   */
  void sendTelemetry();

  /**
   Whether the segment audio for the given segment id is already loading or ready

   @param segmentId to test
   @param nowMillis from which to test
   @return true if segment audio is already loading or ready
   */
  boolean isLoadingOrReady(UUID segmentId, Long nowMillis);
}
