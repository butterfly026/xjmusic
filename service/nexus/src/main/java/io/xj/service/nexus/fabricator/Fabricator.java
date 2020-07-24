// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.service.nexus.fabricator;

import io.xj.lib.entity.MemeEntity;
import io.xj.lib.music.Chord;
import io.xj.lib.music.Note;
import io.xj.service.hub.client.HubClientAccess;
import io.xj.service.hub.client.HubContent;
import io.xj.service.hub.entity.*;
import io.xj.service.nexus.entity.*;

import javax.sound.sampled.AudioFormat;
import java.time.Duration;
import java.util.Collection;
import java.util.Map;
import java.util.Optional;
import java.util.UUID;

public interface Fabricator {

  /**
   Add a new Arrangement

   @param arrangement to of
   @return arrangement with assigned next id (unique for this segment)
   */
  SegmentChoiceArrangement add(SegmentChoiceArrangement arrangement);

  /**
   Add a new Choice

   @param choice to of
   @return choice with assigned next id (unique for this segment)
   */
  SegmentChoice add(SegmentChoice choice);

  /**
   Add a new Pick

   @param pick to add
   @return pick with assigned next id (unique for this segment)
   */
  SegmentChoiceArrangementPick add(SegmentChoiceArrangementPick pick);

  /**
   Add a new SegmentChord

   @param segmentChord to of
   @return segmentChord with assigned next id (unique for this segment)
   */
  SegmentChord add(SegmentChord segmentChord);

  /**
   Add a new SegmentMeme

   @param segmentMeme to of
   @return segmentMeme with assigned next id (unique for this segment)
   */
  SegmentMeme add(SegmentMeme segmentMeme);

  /**
   Add a new SegmentMessage

   @param segmentMessage to of
   @return segmentMessage with assigned next id (unique for this segment)
   */
  SegmentMessage add(SegmentMessage segmentMessage);

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
  Double computeSecondsAtPosition(double p) throws FabricationException;

  /**
   FUTURE: [#165815496] Chain fabrication access control

   @return HubClientAccess control
   @throws FabricationException on failure to establish access
   */
  HubClientAccess getAccess() throws FabricationException;

  /**
   id of all audio picked for current segment

   @return list of audio ids
   @throws FabricationException on failure
   */
  Collection<InstrumentAudio> getPickedAudios() throws FabricationException;

  /**
   Get the Chain

   @return Chain
   */
  Chain getChain() throws FabricationException;

  /**
   Get configs of Chain

   @return Chain Configs
   */
  Collection<ChainConfig> getChainConfigs();

  /**
   Get bindings of Chain

   @return Chain Bindings
   */
  Collection<ChainBinding> getChainBindings();

  /**
   Chain configuration, by type
   If no chain config is found for this type, a default config is returned.

   @param chainConfigType of config to fetch
   @return chain config value
   */
  ChainConfig getChainConfig(ChainConfigType chainConfigType) throws FabricationException;

  /**
   Chain id, of segment

   @return chain id
   */
  UUID getChainId();

  /**
   Get current ChordEntity for any position in Segment.
   Defaults to returning a chord based on the segment key, if nothing else is found

   @param position in segment
   @return ChordEntity
   */
  Chord getChordAt(int position) throws FabricationException;

  /**
   fetch the macro-type choice for the current segment in the chain

   @return macro-type segment choice
   @throws FabricationException on failure
   */
  SegmentChoice getCurrentMacroChoice() throws FabricationException;

  /**
   macro-type sequence binding in current segment

   @return pattern
   @throws FabricationException on failure
   */
  ProgramSequence getCurrentMacroSequence() throws FabricationException;

  /**
   fetch the main-type choice for the current segment in the chain

   @return main-type segment choice
   @throws FabricationException on failure
   */
  SegmentChoice getCurrentMainChoice() throws FabricationException;

  /**
   fetch the rhythm-type choice for the current segment in the chain

   @return rhythm-type segment choice
   @throws FabricationException on failure
   */
  SegmentChoice getCurrentRhythmChoice() throws FabricationException;

  /**
   @return Seconds elapsed since fabricator was instantiated
   */
  Double getElapsedSeconds();

  /**
   Get the Key for any given Choice, preferring its Sequence Key (bound), defaulting to the Program Key.

   @param choice to get key for
   @return key of specified sequence/program via choice
   @throws FabricationException if unable to determine key of choice
   */
  String getKeyForChoice(SegmentChoice choice) throws FabricationException;

  /**
   Get max available sequence pattern offset for a given choice

   @param choice for which to check
   @return max available sequence pattern offset
   @throws FabricationException on attempt to get max available SequenceBinding offset of choice with no SequenceBinding
   */
  Long getMaxAvailableSequenceBindingOffset(SegmentChoice choice) throws FabricationException;

  /**
   Compute the pattern-meme constellations of any previous segments which selected the same main sequence
   <p>
   [#161736024] to compute unique constellations for prior segments with the same main sequence

   @return map of all previous segment meme constellations (as keys) to a collection of arrangements made
   */
  Map<String, Collection<SegmentChoiceArrangement>> getMemeConstellationArrangementsOfPreviousSegments() throws FabricationException;

  /**
   Compute the pattern-meme constellations of any previous segments which selected the same main sequence
   <p>
   [#161736024] to compute unique constellations for prior segments with the same main sequence

   @return map of all previous segment meme constellations (as keys) to a collection of choices made
   */
  Map<String, Collection<SegmentChoice>> getMemeConstellationChoicesOfPreviousSegments() throws FabricationException;

  /**
   Get any sequence by id
   <p>
   /**
   [#162361534] Artist wants segments that continue the use of a main sequence to make the exact same instrument audio assignments, in order to further reign in the randomness, and use very slow evolution of percussive possibilities.

   @return map of all previous segment meme constellations (as keys) to a collection of picks extracted of their content JSON
   */
  Map<String, Collection<SegmentChoiceArrangementPick>> getMemeConstellationPicksOfPreviousSegments() throws FabricationException;

  /**
   Get meme isometry for the current offset in this macro-choice

   @return MemeIsometry for macro-choice
   @throws FabricationException on failure
   */
  MemeIsometry getMemeIsometryOfCurrentMacro() throws FabricationException;

  /**
   Get meme isometry for the next offset in the previous segment's macro-choice

   @return MemeIsometry for previous macro-choice
   @throws FabricationException on failure
   */
  MemeIsometry getMemeIsometryOfNextSequenceInPreviousMacro() throws FabricationException;

  /**
   Get meme isometry for the current segment

   @return MemeIsometry for current segment
   @throws FabricationException on failure
   */
  MemeIsometry getMemeIsometryOfSegment() throws FabricationException;

  /**
   Get all memes for a given Choice id
   [#165954619] Memes include by sequence-pattern (macro- or main-type sequences) and by sequence (all sequences)

   @param choice to get memes for
   @return memes for choice
   @throws FabricationException on failure
   */
  Collection<MemeEntity> getMemesOfChoice(SegmentChoice choice) throws FabricationException;

  /**
   Given a Choice having a SequenceBinding,
   determine the next available SequenceBinding offset of the chosen sequence,
   or loop back to zero (if past the end of the available SequenceBinding offsets)

   @param choice having a SequenceBinding
   @return next available SequenceBinding offset of the chosen sequence, or zero (if past the end of the available SequenceBinding offsets)
   @throws FabricationException on attempt to get next SequenceBinding offset of choice with no SequenceBinding
   */
  Long getNextSequenceBindingOffset(SegmentChoice choice) throws FabricationException;

  /**
   Note, for any pitch in Hz

   @param pitch to get octave of
   */
  Note getNoteAtPitch(Double pitch);

  /**
   Output Audio Format

   @return output audio format
   */
  AudioFormat getOutputAudioFormat() throws FabricationException;

  /**
   Output file path

   @return output file path
   */
  String getOutputFilePath() throws FabricationException;

  /**
   Pitch for any Note, in Hz
   <p>
   [#255] Note pitch is calculated at 32-bit floating point precision, based on root note configured in environment parameters.

   @param note to get pitch for
   @return pitch of note, in Hz
   */
  Double getPitch(Note note);

  /**
   Get all previous segments with same main program

   @return previous segments with ame main program
   */
  Collection<Segment> getPreviousSegmentsWithSameMainProgram();

  /**
   Get Program for any given choice

   @param choice to get program for
   @return Program for the specified choice
   */
  Program getProgram(SegmentChoice choice) throws FabricationException;

  /**
   fetch the macro-type choice for the previous segment in the chain

   @return macro-type segment choice, null if none found
   @throws FabricationException on failure
   */
  SegmentChoice getPreviousMacroChoice() throws FabricationException;

  /**
   fetch the main-type choice for the previous segment in the chain

   @return main-type segment choice, null if none found
   @throws FabricationException on failure
   */
  SegmentChoice getPreviousMainChoice() throws FabricationException;

  /**
   fetch the previous segment in the chain

   @return previousSegment
   */
  Segment getPreviousSegment() throws FabricationException;

  /**
   The segment being fabricated

   @return Segment
   */
  Segment getSegment();

  /**
   Total length of segment of beginning to end

   @return total length
   @throws FabricationException if unable to compute
   */
  Duration getSegmentTotalLength() throws FabricationException;

  /**
   [#165954619] Get the sequence for a Choice either directly (rhythm- and detail-type sequences), or by sequence-pattern (macro- or main-type sequences)
   <p>
   [#166690830] Program model handles all of its own entities
   Rhythm and Detail programs are allowed to have only one (default) sequence.

   @param choice to get sequence for
   @return Sequence for choice
   @throws FabricationException on failure
   */
  ProgramSequence getSequence(SegmentChoice choice) throws FabricationException;

  /**
   Get the sequence pattern offset of a given Choice

   @param choice having a SequenceBinding
   @return sequence pattern offset
   @throws FabricationException on attempt to get next SequenceBinding offset of choice with no SequenceBinding
   */
  Long getSequenceBindingOffsetForChoice(SegmentChoice choice) throws FabricationException;

  /**
   Get the ingested source material for fabrication

   @return source material
   */
  HubContent getSourceMaterial();

  /**
   Determine type of content, e.g. initial segment in chain, or next macro-sequence

   @return macro-craft type
   */
  SegmentType getType() throws FabricationException;

  /**
   Whether the current Segment Choice has one or more sequence pattern offsets
   with a higher pattern offset than the current one

   @param choice for which to check
   @return true if it has at least one more sequence pattern offset
   @throws FabricationException on attempt to get next SequenceBinding offset of choice with no SequenceBinding
   */
  boolean hasOneMoreSequenceBindingOffset(SegmentChoice choice) throws FabricationException;

  /**
   Whether the current Segment Choice has two or more sequence pattern offsets
   with a higher pattern offset than the current two

   @param choice for which to check
   @return true if it has at least two more sequence pattern offsets
   @throws FabricationException on attempt to get next SequenceBinding offset of choice with no SequenceBinding
   */
  boolean hasTwoMoreSequenceBindingOffsets(SegmentChoice choice) throws FabricationException;

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
   Update the original Segment submitted for craft,
   cache it in the internal in-memory object, and persisted in the database
   [#162361525] ALWAYS persist Segment content as JSON when work is performed
   [#162361534] musical evolution depends on segments that continue the use of a main sequence
   */
  void done() throws FabricationException;

  /**
   Randomly select any sequence binding at the given offset

   @param offset to get sequence binding at
   @return randomly selected sequence binding
   @throws FabricationException on failure to select a sequence binding
   */
  ProgramSequenceBinding randomlySelectSequenceBindingAtOffset(Program program, Long offset) throws FabricationException;

  /**
   Randomly select any sequence

   @return ranomly selected sequence
   @throws FabricationException if failure to select a sequence
   */
  ProgramSequence randomlySelectSequence(Program program) throws FabricationException;

  /**
   Get picks for segment

   @return picks for segment
   */
  Collection<SegmentChoiceArrangementPick> getSegmentPicks();

  /**
   Get choices for segment

   @return choices for segment
   */
  Collection<SegmentChoice> getSegmentChoices();

  /**
   Get arrangements for segment

   @return arrangements for segment
   */
  Collection<SegmentChoiceArrangement> getSegmentArrangements();

  /**
   Get segment arrangements for a given choice

   @param choice to get segment arrangements for
   @return segments arrangements for the given segment choice
   */
  Collection<SegmentChoiceArrangement> getArrangements(SegmentChoice choice);

  /**
   Get memes for segment

   @return memes for segment
   */
  Collection<SegmentMeme> getSegmentMemes();

  /**
   [#165954619] Selects one (at random) of all available patterns of a given type within a sequence.
   <p>
   Caches the selection, so it will always return the same output for any given input.
   <p>
   [#166481918] Rhythm fabrication composited of layered Patterns

   @param sequence    of which to select
   @param voice       of which to select
   @param patternType to select
   @return Pattern model, or null if no pattern of this type is found
   @throws FabricationException on failure
   */
  Optional<ProgramSequencePattern> randomlySelectPatternOfSequenceByVoiceAndType(ProgramSequence sequence, ProgramVoice voice, ProgramSequencePatternType patternType) throws FabricationException;
}