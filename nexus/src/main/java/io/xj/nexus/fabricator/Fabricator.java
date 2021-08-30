// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.nexus.fabricator;

import io.xj.api.Chain;
import io.xj.api.Instrument;
import io.xj.api.InstrumentAudio;
import io.xj.api.InstrumentType;
import io.xj.api.Program;
import io.xj.api.ProgramSequence;
import io.xj.api.ProgramSequenceBinding;
import io.xj.api.ProgramSequenceChord;
import io.xj.api.ProgramSequencePattern;
import io.xj.api.ProgramSequencePatternEvent;
import io.xj.api.ProgramSequencePatternType;
import io.xj.api.ProgramType;
import io.xj.api.ProgramVoice;
import io.xj.api.Segment;
import io.xj.api.SegmentChoice;
import io.xj.api.SegmentChoiceArrangement;
import io.xj.api.SegmentChoiceArrangementPick;
import io.xj.api.SegmentChord;
import io.xj.api.SegmentChordVoicing;
import io.xj.api.SegmentMessageType;
import io.xj.api.SegmentType;
import io.xj.lib.entity.common.InstrumentConfig;
import io.xj.lib.entity.common.ProgramConfig;
import io.xj.lib.entity.common.TemplateConfig;
import io.xj.lib.music.Chord;
import io.xj.lib.music.Key;
import io.xj.lib.music.NoteRange;
import io.xj.nexus.NexusException;
import io.xj.nexus.hub_client.client.HubClientAccess;
import io.xj.nexus.hub_client.client.HubContent;

import javax.sound.sampled.AudioFormat;
import java.util.Collection;
import java.util.List;
import java.util.Optional;
import java.util.Set;
import java.util.UUID;

public interface Fabricator {

  /**
   Add a new Entity

   @param entity to add
   @return entity added
   */
  <N> N add(N entity) throws NexusException;

  /**
   Add all memes of this program to the workbench
   <p>
   [#179078533] Straightforward meme logic

   @param p program for which to add memes
   */
  Program addMemes(Program p) throws NexusException;

  /**
   Add all memes of this program sequence binding to the workbench
   <p>
   [#179078533] Straightforward meme logic

   @param psb program sequence binding for which to add memes
   */
  ProgramSequenceBinding addMemes(ProgramSequenceBinding psb) throws NexusException;

  /**
   Add a message of the given type to the segment, with the given body
   @param body to include in message
   */
  void addMessage(SegmentMessageType messageType, String body) throws NexusException;

  /**
   Add an error message to the segment, with the given body
   @param body to include in message
   */
  void addMessageError(String body) throws NexusException;

  /**
   Add an info message to the segment, with the given body
   @param body to include in message
   */
  void addMessageInfo(String body) throws NexusException;

  /**
   Update the original Segment submitted for craft,
   cache it in the internal in-memory object, and persisted in the database
   [#162361525] ALWAYS persist Segment content as JSON when work is performed
   [#162361534] musical evolution depends on segments that continue the use of a main sequence
   */
  void done() throws NexusException;

  /**
   FUTURE: [#165815496] Chain fabrication access control

   @return HubClientAccess control
   @throws NexusException on failure to establish access
   */
  HubClientAccess getAccess() throws NexusException;

  /**
   Get arrangements for segment

   @return arrangements for segment
   */
  Collection<SegmentChoiceArrangement> getArrangements();

  /**
   Get segment arrangements for a given choice

   @param choices to get segment arrangements for
   @return segments arrangements for the given segment choice
   */
  Collection<SegmentChoiceArrangement> getArrangements(Collection<SegmentChoice> choices);

  /**
   The the audio volume for a given pick

   @param pick for which to get audio volume
   @return audio volume of pick
   */
  double getAudioVolume(SegmentChoiceArrangementPick pick);

  /**
   Get the Chain

   @return Chain
   */
  Chain getChain();

  /**
   Chain configuration, by type
   If no chain config is found for this type, a default config is returned.

   @return chain configuration
   */
  TemplateConfig getTemplateConfig();

  /**
   Get a JSON:API payload of the entire result of Chain Fabrication
   Including ALL segments-- this allows the chain to rehydrate from this output

   @return JSON:API payload of the entire result of Chain Fabrication
   */
  String getChainMetadataFullJson() throws NexusException;

  /**
   Returns the storage key concatenated with JSON as its file extension
   Including ALL segments-- this allows the chain to rehydrate from this output

   @return Output Metadata Key
   */
  String getChainMetadataFullKey();

  /**
   Get a JSON:API payload of the entire result of Chain Fabrication
   Including only the next 90 seconds worth of segments- to the keep the player load focused on the near-future

   @return JSON:API payload of the entire result of Chain Fabrication
   */
  String getChainMetadataJson() throws NexusException;

  /**
   Returns the storage key concatenated with JSON as its file extension
   Including only the next 90 seconds worth of segments- to the keep the player load focused on the near-future

   @return Output Metadata Key
   */
  String getChainMetadataKey();

  /**
   Get choices for segment

   @return choices for segment
   */
  Collection<SegmentChoice> getChoices();

  /**
   Get current ChordEntity for any position in Segment.
   Defaults to returning a chord based on the segment key, if nothing else is found

   @param position in segment
   @return ChordEntity
   */
  Optional<SegmentChord> getChordAt(double position);

  /**
   fetch the main-type choice for the current segment in the chain

   @return main-type segment choice
   */
  Optional<SegmentChoice> getCurrentMainChoice();

  /**
   fetch the detail-type choice for the current segment in the chain

   @return detail-type segment choice
   */
  Collection<SegmentChoice> getCurrentDetailChoices();

  /**
   fetch the rhythm-type choice for the current segment in the chain

   @return rhythm-type segment choice
   */
  Optional<SegmentChoice> getCurrentRhythmChoice();

  /**
   Get a list of unique voicing (instrument) types present in the voicings of the current main program's chords.

   @return list of voicing (instrument) types
   */
  List<InstrumentType> getDistinctChordVoicingTypes() throws NexusException;

  /**
   @return Seconds elapsed since fabricator was instantiated
   */
  Double getElapsedSeconds();

  /**
   Output file path for a High-quality Audio output file

   @return High-quality Audio output file path
   */
  String getFullQualityAudioOutputFilePath() throws NexusException;

  /**
   Get the InstrumentConfig from a given instrument, with fallback to instrument section of guice-injected config values

   @param instrument to get config of
   @return InstrumentConfig from a given instrument, with fallback values
   */
  InstrumentConfig getInstrumentConfig(Instrument instrument) throws NexusException;

  /**
   Determine if a choice has been previously crafted
   in one of the previous segments of the current main sequence
   <p>
   [#176468964] Rhythm and Detail choices are kept for an entire Main Program

   @return choice if previously made, or null if none is found
   */
  Optional<SegmentChoice> getChoiceIfContinued(ProgramVoice voice);

  /**
   Determine if a choice has been previously crafted
   in one of the previous segments of the current main sequence

   @return choice if previously made, or null if none is found
   */
  Optional<SegmentChoice> getChoiceIfContinued(ProgramType programType);

  /**
   Determine if a choice has been previously crafted
   in one of the previous segments of the current main sequence

   @return choice if previously made, or null if none is found
   */
  Optional<SegmentChoice> getChoiceIfContinued(InstrumentType instrumentType);

  /**
   Key for any pick designed to collide at same voice id + name

   @param pick to get key of
   @return unique key for pattern event
   */
  String getKeyByVoiceTrack(SegmentChoiceArrangementPick pick) throws NexusException;

  /**
   Get the Key for any given Choice, preferring its Sequence Key (bound), defaulting to the Program Key.
   <p>
   [#176474164] If Sequence has no key/tempo/density inherit from Program

   @param choice to get key for
   @return key of specified sequence/program via choice
   @throws NexusException if unable to determine key of choice
   */
  Key getKeyForChoice(SegmentChoice choice) throws NexusException;

  /**
   fetch the macro-type choice for the previous segment in the chain

   @return macro-type segment choice, null if none found
   */
  Optional<SegmentChoice> getMacroChoiceOfPreviousSegment();

  /**
   fetch the main-type choice for the previous segment in the chain

   @return main-type segment choice, null if none found
   */
  Optional<SegmentChoice> getMainChoiceOfPreviousSegment();

  /**
   Get meme isometry for the next offset in the previous segment's macro-choice

   @return MemeIsometry for previous macro-choice
   */
  MemeIsometry getMemeIsometryOfNextSequenceInPreviousMacro();

  /**
   Get meme isometry for the current segment

   @return MemeIsometry for current segment
   */
  MemeIsometry getMemeIsometryOfSegment();

  /**
   Given a Choice having a SequenceBinding,
   determine the next available SequenceBinding offset of the chosen sequence,
   or loop back to zero (if past the end of the available SequenceBinding offsets)

   @return next available SequenceBinding offset of the chosen sequence, or zero (if past the end of the available SequenceBinding offsets)
   @param choice having a SequenceBinding
   */
  Integer getNextSequenceBindingOffset(SegmentChoice choice);

  /**
   Get the Notes from a Voicing

   @param voicing to get notes of
   @return notes from voicing
   @throws NexusException on failure
   */
  Collection<String> getNotes(SegmentChordVoicing voicing) throws NexusException;

  /**
   Output Audio Format

   @return output audio format
   */
  AudioFormat getOutputAudioFormat() throws NexusException;

  /**
   id of all audio picked for current segment

   @return list of audio ids
   */
  Collection<InstrumentAudio> getPickedAudios();

  /**
   Get arrangement picks for segment

   @return arrangement picks for segment
   */
  Collection<SegmentChoiceArrangementPick> getPicks();

  /**
   Get preferred (previously chosen) instrument audios

   @return preferred audios
   */
  Optional<InstrumentAudio> getPreferredAudio(ProgramSequencePatternEvent event, String note);

  /**
   Get preferred (previously chosen) notes

   @return notes
   @param eventId   of event
   @param chordName of chord
   */
  Optional<Set<String>> getPreferredNotes(UUID eventId, String chordName);

  /**
   Get Program for any given choice

   @param choice to get program for
   @return Program for the specified choice
   */
  Optional<Program> getProgram(SegmentChoice choice);

  /**
   Get the ProgramConfig from a given program, with fallback to program section of guice-injected config values

   @param program to get config of
   @return ProgramConfig from a given program, with fallback values
   */
  ProgramConfig getProgramConfig(Program program) throws NexusException;

  /**
   Get the complete set of program sequence chords,
   ignoring ghost chords* REF https://www.pivotaltracker.com/story/show/178420030
   (caches results)

   @param programSequence for which to get complete do-ghosted set of chords
   @return get complete do-ghosted set of chords for program sequence
   */
  Collection<ProgramSequenceChord> getProgramSequenceChords(ProgramSequence programSequence);

  /**
   Get the note range for an arrangement based on all the events in its program

   @return Note range of arrangement
   @param programId      to get range of
   @param instrumentType to get range of
   */
  NoteRange getProgramRange(UUID programId, InstrumentType instrumentType) throws NexusException;

  /**
   [#176696738] Detail craft shifts source program events into the target range
   <p>
   via average of delta from source low to target low, and from source high to target high, rounded to octave

   @param type        of instrument
   @param sourceRange to compute from
   @param targetRange to compute required # of octaves to shift into
   @return +/- octaves required to shift from source to target range
   */
  int getProgramRangeShiftOctaves(InstrumentType type, NoteRange sourceRange, NoteRange targetRange) throws NexusException;

  /**
   Compute the target shift from a key toward a chord

   @param fromKey to compute shift from
   @param toChord to compute shift toward
   @return computed target shift
   */
  int getProgramTargetShift(Key fromKey, Chord toChord);

  /**
   Get the program type of a given voice

   @param voice for which to get program type
   @return program type
   */
  ProgramType getProgramType(ProgramVoice voice) throws NexusException;

  /**
   Get the lowest note present in any voicing of all the segment chord voicings for this segment and instrument type

   @param type to get voicing threshold low of
   @return low voicing threshold
   */
  NoteRange getProgramVoicingNoteRange(InstrumentType type) throws NexusException;

  /**
   Randomly select any sequence

   @return randomly selected sequence
   */
  Optional<ProgramSequence> getRandomlySelectedSequence(Program program);

  /**
   [#165954619] Selects one (at random) of all available patterns of a given type within a sequence.
   <p>
   Caches the selection, so it will always return the same output for any given input.
   <p>
   [#166481918] Rhythm fabrication composited of layered Patterns

   @param patternType to select
   @return Pattern model, or null if no pattern of this type is found
   @throws NexusException on failure
   */
  Optional<ProgramSequencePattern> getRandomlySelectedPatternOfSequenceByVoiceAndType(SegmentChoice choice, ProgramSequencePatternType patternType) throws NexusException;

  /**
   Randomly select any sequence binding at the given offset

   @return randomly selected sequence binding
   @param offset to get sequence binding at
   */
  Optional<ProgramSequenceBinding> getRandomlySelectedSequenceBindingAtOffset(Program program, Integer offset);

  /**
   Get a randomly selected voice of the given program id

   @return randomly selected voice
   @param programId for which to randomly select voice
   @param excludeVoiceIds to exclude from random selection
   */
  Optional<ProgramVoice> getRandomlySelectedVoiceForProgramId(UUID programId, Collection<UUID> excludeVoiceIds);

  /**
   Compute using an integral
   the seconds of start for any given position in beats
   Velocity of Segment meter (beats per minute) increases linearly of the beginning of the Segment (at the previous Segment's tempo) to the end of the Segment (arriving at the current Segment's tempo, only at its end)
   <p>
   [#166370833] Segment should *never* be fabricated longer than its total beats.
   [#153542275] Segment wherein tempo changes expect perfectly smooth sound of previous segment through to following segment

   @param p position in beats
   @return seconds of start
   */
  Double getSecondsAtPosition(double p) throws NexusException;

  /**
   The segment being fabricated

   @return Segment
   */
  Segment getSegment();

  /**
   Get all segment chords, guaranteed to be in order of position ascending

   @return segment chords
   */
  Collection<SegmentChord> getSegmentChords();

  /**
   Get a JSON:API payload of the entire result of Segment Fabrication

   @return JSON:API payload of the entire result of Segment Fabrication
   */
  String getSegmentMetadataJson() throws NexusException;

  /**
   Returns the storage key concatenated with JSON as its file extension

   @return Output Metadata Key
   */
  String getSegmentOutputMetadataKey();

  /**
   Returns the storage key concatenated with the output encoder as its file extension

   @return Output Waveform Key
   */
  String getSegmentOutputWaveformKey();

  /**
   Returns the segment storage key concatenated with a specified extension

   @return Output Metadata Key
   */
  String getSegmentStorageKey(String extension);

  /**
   [#165954619] Get the sequence for a Choice either directly (rhythm- and detail-type sequences), or by sequence-pattern (macro- or main-type sequences)
   <p>
   [#166690830] Program model handles all of its own entities
   Rhythm and Detail programs are allowed to have only one (default) sequence.

   @param choice to get sequence for
   @return Sequence for choice
   @throws NexusException on failure
   */
  Optional<ProgramSequence> getSequence(SegmentChoice choice) throws NexusException;

  /**
   Get the sequence pattern offset of a given Choice

   @return sequence pattern offset
   @param choice having a SequenceBinding
   */
  Integer getSequenceBindingOffsetForChoice(SegmentChoice choice);

  /**
   Get the Voice ID of a given event

   @param event to get voice String of
   @return Track name
   */
  String getTrackName(ProgramSequencePatternEvent event) throws NexusException;

  /**
   Determine type of content, e.g. initial segment in chain, or next macro-sequence

   @return macro-craft type
   */
  SegmentType getType() throws NexusException;

  /**
   Get segment chord voicing for a given chord

   @param chord to get voicing for
   @return chord voicing for chord
   */
  Optional<SegmentChordVoicing> getVoicing(SegmentChord chord, InstrumentType type);

  /**
   Does the program of the specified Choice have at least N more sequence binding offsets available?

   @param choice of which to check the program for next available sequence binding offsets
   @param N      more sequence offsets to check for
   @return true if N more sequence binding offsets are available
   */
  boolean hasMoreSequenceBindingOffsets(SegmentChoice choice, int N);

  /**
   Whether the current Segment Choice has one or more sequence pattern offsets
   with a higher pattern offset than the current one

   @param choice for which to check
   @return true if it has at least one more sequence pattern offset
   */
  boolean hasOneMoreSequenceBindingOffset(SegmentChoice choice);

  /**
   Whether the current Segment Choice has two or more sequence pattern offsets
   with a higher pattern offset than the current two

   @param choice for which to check
   @return true if it has at least two more sequence pattern offsets
   */
  boolean hasTwoMoreSequenceBindingOffsets(SegmentChoice choice);

  /**
   Whether this type of segment continues the same macro-program from the previous segment

   @return true if this segment continues the same macro-program
   */
  boolean isContinuationOfMacroProgram() throws NexusException;

  /**
   Whether a given Instrument is directly bound to the Chain,
   where "directly" means a level more specific than Library, e.g. Program or Instrument

   @param instrument to test for direct binding
   @return true if Instrument is directly bound to chain
   */
  boolean isDirectlyBound(Instrument instrument);

  /**
   Whether a given Program is directly bound to the Chain,
   where "directly" means a level more specific than Library, e.g. Program or Instrument

   @param program to test for direct binding
   @return true if Program is directly bound to chain
   */
  boolean isDirectlyBound(Program program);

  /**
   is initial segment?

   @return whether this is the initial segment in a chain
   */
  Boolean isInitialSegment();

  /**
   Put a key-value pair into the report
   [#162999779] only exports data as a sub-field of the standard content JSON

   @param key   to put
   @param value to put
   */
  void putReport(String key, Object value);

  /**
   Remember which notes were picked for a given event

   @return notes to pass  through for chaining method calls
   @param programSequencePatternEventId to remember notes picked for
   @param chordName                     to remember notes picked for
   @param notes                         to remember were picked
   */
  Set<String> rememberPickedNotes(UUID programSequencePatternEventId, String chordName, Set<String> notes);

  /**
   Set the Segment.
   Any modifications to the Segment must be re-written to here
   because protobuf instances are immutable

   @param segment to set
   */
  void updateSegment(Segment segment) throws NexusException;

  /**
   Get the Segment Retrospective

   @return retrospective
   */
  SegmentRetrospective retrospective();

  /**
   Set the preferred audio for a key

   @param event           for which to set
   @param note            for which to set
   @param instrumentAudio value to set
   */
  void setPreferredAudio(ProgramSequencePatternEvent event, String note, InstrumentAudio instrumentAudio);

  /**
   Get the ingested source material for fabrication

   @return source material
   */
  HubContent sourceMaterial();

}