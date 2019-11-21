// Copyright (c) 2020, XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.core.model;

import com.google.common.collect.ImmutableList;
import io.xj.core.entity.EventEntity;
import io.xj.core.exception.CoreException;

import java.util.UUID;

/**
 [#166690830] Pattern model handles all of its own entities
 */
public class ProgramSequencePatternEvent extends EventEntity {
  public static final ImmutableList<String> RESOURCE_ATTRIBUTE_NAMES = ImmutableList.<String>builder()
    .addAll(EventEntity.RESOURCE_ATTRIBUTE_NAMES)
    .build();
  public static final ImmutableList<Class> RESOURCE_BELONGS_TO = ImmutableList.<Class>builder()
    .add(Program.class)
    .add(ProgramSequencePattern.class)
    .add(ProgramVoiceTrack.class)
    .build();
  private UUID programId;
  private UUID programSequencePatternId;
  private UUID programVoiceTrackId;

  /**
   Create a new Event

   @param pattern  to of event in
   @param track    of Event
   @param position of Event
   @param duration of Event
   @param note     of Event
   @param velocity of Event
   @return new Event
   */
  public static ProgramSequencePatternEvent create(ProgramSequencePattern pattern, ProgramVoiceTrack track, double position, double duration, String note, double velocity) {
    return create()
      .setProgramId(pattern.getProgramId())
      .setPattern(pattern)
      .setTrack(track)
      .setPosition(position)
      .setDuration(duration)
      .setNote(note)
      .setVelocity(velocity);
  }

  /**
   Create a new Event

   @return new Event
   */
  public static ProgramSequencePatternEvent create() {
    return new ProgramSequencePatternEvent().setId(UUID.randomUUID());
  }

  /**
   Create a new Event

   @return new Event
   */
  public static ProgramSequencePatternEvent create(Program program) {
    return create()
      .setProgramId(program.getId());
  }

  @Override
  public UUID getParentId() {
    return programId;
  }

  /**
   Get id of Program to which this entity belongs

   @return program id
   */
  public UUID getProgramId() {
    return programId;
  }

  /**
   Set id of Program to which this entity belongs

   @param programId to which this entity belongs
   @return this Program Entity (for chaining setters)
   */
  public ProgramSequencePatternEvent setProgramId(UUID programId) {
    this.programId = programId;
    return this;
  }

  /**
   Get Pattern UUID

   @return Pattern UUID
   */
  public UUID getProgramSequencePatternId() {
    return programSequencePatternId;
  }

  /**
   Get Track UUID

   @return Track UUID
   */
  public UUID getProgramVoiceTrackId() {
    return programVoiceTrackId;
  }

  @Override
  public ImmutableList<String> getResourceAttributeNames() {
    return RESOURCE_ATTRIBUTE_NAMES;
  }

  @Override
  public ImmutableList<Class> getResourceBelongsTo() {
    return RESOURCE_BELONGS_TO;
  }


  @Override
  public ProgramSequencePatternEvent setDuration(Double duration) {
    super.setDuration(duration);
    return this;
  }

  @Override
  public ProgramSequencePatternEvent setNote(String note) {
    super.setNote(note);
    return this;
  }

  /**
   Set Pattern UUID by providing the parent Pattern

   @param pattern to set UUID of
   @return this Event (for chaining methods)
   */
  public ProgramSequencePatternEvent setPattern(ProgramSequencePattern pattern) {
    setProgramSequencePatternId(pattern.getId());
    return this;
  }

  /**
   Set Pattern UUID

   @param programSequencePatternId to set
   @return this Event (for chaining methods)
   */
  public ProgramSequencePatternEvent setProgramSequencePatternId(UUID programSequencePatternId) {
    this.programSequencePatternId = programSequencePatternId;
    return this;
  }

  /**
   Set Track UUID by providing the parent Track

   @param track to set UUID of
   @return this Event (for chaining methods)
   */
  public ProgramSequencePatternEvent setTrack(ProgramVoiceTrack track) {
    setProgramVoiceTrackId(track.getId());
    return this;
  }

  /**
   Set Track UUID

   @param programVoiceTrackId to set
   @return this Event (for chaining methods)
   */
  public ProgramSequencePatternEvent setProgramVoiceTrackId(UUID programVoiceTrackId) {
    this.programVoiceTrackId = programVoiceTrackId;
    return this;
  }

  @Override
  public ProgramSequencePatternEvent setPosition(Double position) {
    super.setPosition(position);
    return this;
  }

  @Override
  public ProgramSequencePatternEvent setId(UUID id) {
    this.id = id;
    return this;
  }

  @Override
  public ProgramSequencePatternEvent setVelocity(Double velocity) {
    super.setVelocity(velocity);
    return this;
  }

  @Override
  public void validate() throws CoreException {
    super.validate();
    require(programId, "Program ID");
    require(programSequencePatternId, "Pattern ID");
    require(programVoiceTrackId, "Track ID");
    EventEntity.validate(this);
  }
}
