// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.

package io.xj.nexus.fabricator;

import com.google.inject.Inject;
import io.xj.api.InstrumentAudio;
import io.xj.api.SegmentMessage;
import io.xj.api.SegmentMessageType;
import io.xj.lib.util.CSV;
import io.xj.nexus.NexusException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.Map;
import java.util.UUID;

/**
 Fabrication wrapper is a common foundation for all craft
 */
public abstract class FabricationWrapperImpl {
  protected static final double SCORE_DIRECTLY_BOUND = 100;
  protected static final double SCORE_UNPUBLISHED = -100;
  protected static final double SCORE_ENTROPY_CHOICE_DETAIL = 8.0;
  protected static final double SCORE_ENTROPY_CHOICE_INSTRUMENT = 8.0;
  protected static final double SCORE_ENTROPY_CHOICE_RHYTHM = 8.0;
  protected static final double SCORE_MATCH_MEMES = 1.0;
  protected static final double SCORE_MATCH_MAIN_PROGRAM = 15;
  protected static final double SCORE_MATCH_OUTGOING_TO_INCOMING = 15;
  private final Logger log = LoggerFactory.getLogger(FabricationWrapperImpl.class);
  protected Fabricator fabricator;

  /**
   Must extend this class and inject

   @param fabricator internal
   */
  @Inject
  public FabricationWrapperImpl(Fabricator fabricator) {
    this.fabricator = fabricator;
  }

  /**
   Create a new NexusException prefixed with a segment id

   @param message to include in exception
   @return NexusException to throw
   */
  public NexusException exception(String message) {
    return new NexusException(formatLog(message));
  }

  /**
   Create a new NexusException prefixed with a segment id, including sub-exception

   @param message to include in exception
   @param e       Exception to include in exception
   @return NexusException to throw
   */
  public NexusException exception(String message, Exception e) {
    return new NexusException(formatLog(message), e);
  }

  /**
   Format a message with the segmentId as prefix

   @param message to format
   @return formatted message with segmentId as prefix
   */
  public String formatLog(String message) {
    return String.format("[segId=%s] %s", fabricator.getSegment().getId(), message);
  }

  /**
   Report a missing entity as a segment message

   @param type   of class that is missing
   @param detail of how missing entity was searched for
   */
  protected void reportMissingInstrumentAudio(Class<?> type, String detail) {
    try {
      fabricator.add(new SegmentMessage()
        .id(UUID.randomUUID())
        .segmentId(fabricator.getSegment().getId())
        .type(SegmentMessageType.WARNING)
        .body(String.format("%s not found %s", type.getSimpleName(), detail))
      );

    } catch (Exception e) {
      log.warn("Failed to create SegmentMessage", e);
    }
  }

  /**
   Report a missing entity as a segment message@param traces of how missing entity was searched for
   */
  protected void reportMissingInstrumentAudio(Map<String, String> traces) {
    try {
      fabricator.add(new SegmentMessage()
        .id(UUID.randomUUID())
        .segmentId(fabricator.getSegment().getId())
        .type(SegmentMessageType.WARNING)
        .body(String.format("%s not found! %s", InstrumentAudio.class.getSimpleName(), CSV.from(traces))));

    } catch (Exception e) {
      log.warn("Failed to create SegmentMessage", e);
    }
  }
}