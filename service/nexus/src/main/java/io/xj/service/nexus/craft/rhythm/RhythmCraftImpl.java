// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.service.nexus.craft.rhythm;

import com.google.common.collect.Maps;
import com.google.inject.Inject;
import com.google.inject.assistedinject.Assisted;
import io.xj.Instrument;
import io.xj.InstrumentAudio;
import io.xj.InstrumentAudioEvent;
import io.xj.Program;
import io.xj.ProgramSequence;
import io.xj.ProgramSequencePattern;
import io.xj.ProgramSequencePatternEvent;
import io.xj.ProgramVoice;
import io.xj.Segment;
import io.xj.SegmentChoice;
import io.xj.SegmentChoiceArrangement;
import io.xj.SegmentChoiceArrangementPick;
import io.xj.lib.entity.Entities;
import io.xj.lib.music.Chord;
import io.xj.lib.music.Key;
import io.xj.lib.music.Note;
import io.xj.lib.util.Chance;
import io.xj.lib.util.Value;
import io.xj.lib.util.ValueException;
import io.xj.service.hub.client.HubClientException;
import io.xj.service.nexus.craft.CraftImpl;
import io.xj.service.nexus.craft.exception.CraftException;
import io.xj.service.nexus.fabricator.EntityScorePicker;
import io.xj.service.nexus.fabricator.FabricationException;
import io.xj.service.nexus.fabricator.Fabricator;
import io.xj.service.nexus.fabricator.NameIsometry;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.security.SecureRandom;
import java.util.Collection;
import java.util.Map;
import java.util.Objects;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Stream;

/**
 Rhythm craft for the current segment
 [#214] If a Chain has Sequences associated with it directly, prefer those choices to any in the Library
 */
public class RhythmCraftImpl extends CraftImpl implements RhythmCraft {
  private static final double SCORE_INSTRUMENT_ENTROPY = 0.5;
  private static final double SCORE_MATCHED_MEMES = 5;
  private static final double SCORE_RHYTHM_ENTROPY = 0.5;
  private static final double SCORE_DIRECTLY_BOUND = 100;
  private final Logger log = LoggerFactory.getLogger(RhythmCraftImpl.class);
  private final SecureRandom random = new SecureRandom();

  @Inject
  public RhythmCraftImpl(
    @Assisted("basis") Fabricator fabricator
    /*-*/) {
    this.fabricator = fabricator;
  }

  @Override
  public void doWork() throws CraftException {
    Map<String, InstrumentAudio> previousInstrumentAudio = getPreviousInstrumentAudio();
    try {

      // program
      Program rhythmProgram = chooseRhythmProgram();
      SegmentChoice rhythmChoice = fabricator.add(SegmentChoice.newBuilder()
        .setId(UUID.randomUUID().toString())
        .setSegmentId(fabricator.getSegment().getId())
        .setProgramType(Program.Type.Rhythm)
        .setProgramId(rhythmProgram.getId())
        .setTranspose(computeRhythmTranspose(rhythmProgram))
        .build());

      // rhythm sequence is selected at random of the current program
      // FUTURE: [#166855956] Rhythm Program with multiple Sequences
      var rhythmSequence = fabricator.getSequence(rhythmChoice);

      // voice arrangements
      for (ProgramVoice voice : fabricator.getSourceMaterial().getVoices(rhythmProgram))
        craftArrangementForRhythmVoice(rhythmSequence, rhythmChoice, voice, previousInstrumentAudio);

      // Finally, update the segment with the crafted content
      fabricator.done();

    } catch (FabricationException e) {
      throw exception(String.format("Failed to do Rhythm-Craft Work because %s", e.getMessage()));

    } catch (Exception e) {
      throw exception("Bad failure", e);
    }
  }

  /**
   Get previously chosen (for previous segments with same main program) instrument audio

   @return map of previous chosen instrument audio
   @throws CraftException on failure to build map
   */
  private Map<String, InstrumentAudio> getPreviousInstrumentAudio() throws CraftException {
    try {
      Map<String, InstrumentAudio> previousInstrumentAudio = Maps.newHashMap();
      for (SegmentChoiceArrangementPick pick : fabricator.getChoiceArrangementPicksOfPreviousSegments())
        previousInstrumentAudio.put(fabricator.eventKey(pick),
          fabricator.getSourceMaterial().getInstrumentAudio(pick.getInstrumentAudioId()));
      return previousInstrumentAudio;

    } catch (FabricationException | HubClientException e) {
      throw exception("Unable to build map create previous instrument audio", e);
    }
  }

  /**
   compute (and cache) the mainProgram

   @return mainProgram
   */
  private Program chooseRhythmProgram() throws CraftException {
    Segment.Type type;
    try {
      type = fabricator.getType();
    } catch (FabricationException e) {
      throw exception("Cannot get fabricator type, in order to choose rhythm program", e);
    }

    switch (type) {
      case Continue:
        Optional<Program> selectedPreviously = getRhythmProgramSelectedPreviouslyForMainProgram();
        return selectedPreviously.isPresent() ? selectedPreviously.get() : chooseFreshRhythm();

      case Initial:
      case NextMain:
      case NextMacro:
        return chooseFreshRhythm();

      default:
        throw exception(String.format("Cannot get Rhythm-type program for unknown fabricator type=%s", type));
    }
  }

  /**
   Determine if a rhythm program has been previously selected
   in one of the previous segments of the current main program
   <p>
   [#176468964] Rhythm and Detail choices are kept for an entire Main Program

   @return rhythm program if previously selected, or null if none is found
   */
  private Optional<Program> getRhythmProgramSelectedPreviouslyForMainProgram() {
    try {
      return fabricator.getChoicesOfPreviousSegments()
        .stream()
        .filter(choice -> Program.Type.Rhythm == choice.getProgramType())
        .flatMap(choice -> {
          try {
            return Stream.of(fabricator.getSourceMaterial().getProgram(choice.getProgramId()));
          } catch (HubClientException e) {
            log.warn("Failed to locate program for choice", e);
            return Stream.empty();
          }
        })
        .findFirst();

    } catch (FabricationException e) {
      log.warn(formatLog("Could not get rhythm program selected previously for main program"), e);
      return Optional.empty();
    }
  }

  /**
   Transposition for rhythm-type sequence choice for segment

   @param rhythmProgram to get transpose of
   @return +/- semitones transposition of rhythm-type sequence choice
   */
  private Integer computeRhythmTranspose(Program rhythmProgram) {
    return Key.delta(rhythmProgram.getKey(), fabricator.getSegment().getKey(), 0);
  }


  /**
   Choose a fresh rhythm based on a set of memes
   FUTURE [#150279436] Key of first Pattern of chosen Rhythm-Program must match the `minor` or `major` with the Key of the current Segment.

   @return rhythm-type Program
   @throws CraftException on failure
   <p>
   future: actually choose rhythm program
   */
  private Program chooseFreshRhythm() throws CraftException {
    EntityScorePicker<Program> superEntityScorePicker = new EntityScorePicker<>();

    // (2) retrieve programs bound to chain and
    // (3) score each source program based on meme isometry
    try {
      for (Program program : fabricator.getSourceMaterial().getProgramsOfType(Program.Type.Rhythm))
        superEntityScorePicker.add(program, scoreRhythm(program));
    } catch (Exception e) {
      throw exception("retrieve programs bound to chain", e);
    }

    // report
    fabricator.putReport("rhythmChoice", superEntityScorePicker.report());

    // (4) return the top choice
    try {
      return superEntityScorePicker.getTop();
    } catch (FabricationException e) {
      throw exception("Found no rhythm-type program bound to Chain!", e);
    }
  }

  /**
   Score a candidate for rhythm program, given current fabricator
   Score includes matching memes, previous segment to macro program first pattern
   <p>
   Returns ZERO if the program has no memes, in order to fix:
   [#162040109] Artist expects program with no memes will never be selected for chain craft.

   @param program to score
   @return score, including +/- entropy; empty if this program has no memes, and isn't directly bound
   */
  private Double scoreRhythm(Program program) throws CraftException {
    try {
      double score = 0;
      Collection<String> memes = fabricator.getSourceMaterial().getMemesAtBeginning(program);
      if (!memes.isEmpty())
        score += fabricator.getMemeIsometryOfSegment().score(memes) * SCORE_MATCHED_MEMES + Chance.normallyAround(0, SCORE_RHYTHM_ENTROPY);

      // [#174435421] Chain bindings specify Program & Instrument within Library
      if (fabricator.isDirectlyBound(program))
        score += SCORE_DIRECTLY_BOUND;

      // score is above zero, else empty
      return score;

    } catch (Exception e) {
      throw exception("score rhythm", e);
    }
  }


  /**
   craft segment events for one rhythm voice
   [#176468964] Rhythm and Detail choices are kept for an entire Main Program

   @param voice to craft events for
   @throws CraftException on failure
   */
  private void craftArrangementForRhythmVoice(ProgramSequence sequence, SegmentChoice choice, ProgramVoice voice, Map<String, InstrumentAudio> previousInstrumentAudio) throws CraftException {
    try {
      Optional<String> instrumentId = fabricator.getPreviousVoiceInstrumentId(voice.getId());

      // if no previous instrument found, choose a fresh one
      SegmentChoiceArrangement arrangement = fabricator.add(SegmentChoiceArrangement.newBuilder()
        .setId(UUID.randomUUID().toString())
        .setSegmentId(choice.getSegmentId())
        .setSegmentChoiceId(choice.getId())
        .setProgramVoiceId(voice.getId())
        .setInstrumentId(
          instrumentId.isPresent() ?
            instrumentId.get() : chooseFreshPercussiveInstrument(voice).getId())
        .build());

      // choose intro pattern (if available)
      Optional<ProgramSequencePattern> introPattern = fabricator.randomlySelectPatternOfSequenceByVoiceAndType(sequence, voice, ProgramSequencePattern.Type.Intro);

      // choose outro pattern (if available)
      Optional<ProgramSequencePattern> outroPattern = fabricator.randomlySelectPatternOfSequenceByVoiceAndType(sequence, voice, ProgramSequencePattern.Type.Outro);

      // compute in and out points, and length # beats for which loop patterns will be required
      long loopOutPos = fabricator.getSegment().getTotal() -
        (outroPattern.map(ProgramSequencePattern::getTotal).orElse(0));

      // begin at the beginning and fabricate events for the segment of beginning to end
      double curPos = 0.0;

      // if intro pattern, fabricate those voice event first
      if (introPattern.isPresent())
        curPos += craftRhythmPatternEvents(previousInstrumentAudio, choice, arrangement, introPattern.get(), curPos, loopOutPos, 0);

      // choose loop patterns until arrive at the out point or end of segment
      while (curPos < loopOutPos) {
        Optional<ProgramSequencePattern> loopPattern = fabricator.randomlySelectPatternOfSequenceByVoiceAndType(sequence, voice, ProgramSequencePattern.Type.Loop);
        if (loopPattern.isPresent())
          curPos += craftRhythmPatternEvents(previousInstrumentAudio, choice, arrangement, loopPattern.get(), curPos, loopOutPos, 0);
        else
          curPos = loopOutPos;
      }

      // "Go for it" more towards the end of a program (and only during the outro, when present)
      double goForItRatio = fabricator.getSequenceBindingOffsetForChoice(fabricator.getCurrentMainChoice()).doubleValue() /
        fabricator.getMaxAvailableSequenceBindingOffset(fabricator.getCurrentMainChoice()).doubleValue();

      // if outro pattern, fabricate those voice event last
      // [#161466708] compute how much to go for it in the outro
      if (outroPattern.isPresent())
        craftRhythmPatternEvents(previousInstrumentAudio, choice, arrangement, outroPattern.get(), curPos, loopOutPos, goForItRatio);

    } catch (FabricationException e) {
      throw
        exception(String.format("Failed to craft arrangement for rhythm voiceId=%s", voice.getId()), e);
    }
  }

  /**
   Choose percussive instrument
   [#325] Possible to choose multiple instruments for different voices in the same program

   @param voice to choose instrument for
   @return percussive-type Instrument
   @throws CraftException on failure
   */
  private Instrument chooseFreshPercussiveInstrument(ProgramVoice voice) throws CraftException {
    try {
      EntityScorePicker<Instrument> superEntityScorePicker = new EntityScorePicker<>();

      // (2) retrieve instruments bound to chain
      Collection<Instrument> sourceInstruments = fabricator.getSourceMaterial().getInstrumentsOfType(Instrument.Type.Percussive);

      // future: [#258] Instrument selection is based on Text Isometry between the voice name and the instrument name
      log.debug("[segId={}] not currently in use: {}", fabricator.getSegment().getId(), voice);

      // (3) score each source instrument based on meme isometry
      for (Instrument instrument : sourceInstruments)
        superEntityScorePicker.add(instrument, scorePercussive(instrument));

      // report
      fabricator.putReport("percussiveChoice", superEntityScorePicker.report());

      // (4) return the top choice
      return superEntityScorePicker.getTop();

    } catch (FabricationException | HubClientException e) {
      throw exception("Found no percussive-type instrument bound to Chain!", e);
    }
  }

  /**
   Score a candidate for percussive instrument, given current fabricator

   @param instrument to score
   @return score, including +/- entropy
   */
  private double scorePercussive(Instrument instrument) throws CraftException {
    try {
      double score = Chance.normallyAround(0, SCORE_INSTRUMENT_ENTROPY);

      // Score includes matching memes, previous segment to macro instrument first pattern
      score += SCORE_MATCHED_MEMES *
        fabricator.getMemeIsometryOfSegment().score(
          Entities.namesOf(fabricator.getSourceMaterial().getMemes(instrument)));

      // [#174435421] Chain bindings specify Program & Instrument within Library
      if (fabricator.isDirectlyBound(instrument))
        score += SCORE_DIRECTLY_BOUND;

      return score;

    } catch (Exception e) {
      throw exception("score percussive", e);
    }
  }

  /**
   Craft the voice events of a single rhythm pattern.
   [#161601279] Artist during rhythm craft audio selection wants randomness of outro audio selection to gently ramp of zero to N over the course of the outro.

   @param previousInstrumentAudio map of previous instrument audio of which to potentially select
   @param choice                  to craft pattern events for
   @param arrangement             to craft pattern events for
   @param pattern                 to source events
   @param fromPos                 to write events to segment
   @param maxPos                  to write events to segment
   @param goForItRatio            entropy is increased during the progression of a main sequence [#161466708]
   @return deltaPos of start, after crafting this batch of rhythm pattern events
   */
  private double craftRhythmPatternEvents(Map<String, InstrumentAudio> previousInstrumentAudio, SegmentChoice choice, SegmentChoiceArrangement arrangement, ProgramSequencePattern pattern, double fromPos, double maxPos, double goForItRatio) throws CraftException {
    try {
      if (Objects.isNull(pattern)) throw exception("Cannot craft create null pattern");
      double totalPos = maxPos - fromPos;
      Collection<ProgramSequencePatternEvent> events = fabricator.getSourceMaterial().getEvents(pattern);
      Instrument instrument = fabricator.getSourceMaterial().getInstrument(arrangement.getInstrumentId());
      for (ProgramSequencePatternEvent event : events) {
        double chanceOfRandomChoice = 0.0 == goForItRatio ? 0.0 : goForItRatio * Value.ratio(event.getPosition() - fromPos, totalPos);
        pickInstrumentAudio(previousInstrumentAudio, instrument, arrangement, event, choice.getTranspose(), fromPos, chanceOfRandomChoice);
      }
      return Math.min(totalPos, pattern.getTotal());

    } catch (Exception e) {
      throw exception("craft rhythm pattern events", e);
    }
  }

  /**
   of a pick of instrument-audio for each event, where events are conformed to entities/scales based on the master segment entities
   pick instrument audio for one event, in a voice in a pattern, belonging to an arrangement@param arrangement   to of pick within@param previousInstrumentAudio
   <p>
   [#175548549] Program and Instrument parameters to turn off transposition and tonality.

   @param previousInstrumentAudio map of previous instrument audio of which to potentially select
   @param event                   to pick audio for
   @param shiftPosition           offset voice event zero within current segment
   @param chanceOfRandomChoice    entropy is increased during the progression of a main sequence [#161466708]
   */
  private void pickInstrumentAudio(Map<String, InstrumentAudio> previousInstrumentAudio, Instrument instrument, SegmentChoiceArrangement segmentChoiceArrangement, ProgramSequencePatternEvent event, int transpose, Double shiftPosition, Double chanceOfRandomChoice) throws CraftException {
    try {
      var audio = selectInstrumentAudio(previousInstrumentAudio, instrument, event, chanceOfRandomChoice);

      // Morph & Point attributes are expressed in beats
      double position = event.getPosition() + shiftPosition;
      double duration = event.getDuration();
      Chord chord = Chord.of(fabricator.getChordAt((int) Math.floor(position))
        .orElseThrow(() -> new FabricationException("No chord found!"))
        .getName());

      // The final note is transformed based on instrument type
      Note note = pickNote(
        Note.of(event.getNote()).transpose(transpose),
        chord, audio, instrument.getType());

      // Pick attributes are expressed "rendered" as actual seconds
      double startSeconds = fabricator.computeSecondsAtPosition(position);
      double lengthSeconds = fabricator.computeSecondsAtPosition(position + duration) - startSeconds;

      // Audio pitch is not modified for atonal instruments
      double pitch = fabricator.getInstrumentConfig(instrument).isTonal() ?
        fabricator.getPitch(note) : audio.getPitch();

      // of pick
      fabricator.add(SegmentChoiceArrangementPick.newBuilder()
        .setId(UUID.randomUUID().toString())
        .setSegmentId(segmentChoiceArrangement.getSegmentId())
        .setSegmentChoiceArrangementId(segmentChoiceArrangement.getId())
        .setInstrumentAudioId(audio.getId())
        .setProgramSequencePatternEventId(event.getId())
        .setName(fabricator.getTrackName(event))
        .setStart(startSeconds)
        .setLength(lengthSeconds)
        .setAmplitude(event.getVelocity())
        .setPitch(pitch)
        .build());

    } catch (FabricationException | ValueException e) {
      throw exception(String.format("Could not pick audio for instrumentId=%s, arrangementId=%s, eventId=%s, transpose=%d, shiftPosition=%f, chanceOfRandomChoice=%f",
        instrument.getId(), segmentChoiceArrangement.getId(), event.getId(), transpose, shiftPosition, chanceOfRandomChoice), e);
    }
  }

  /**
   Determine if we will use a cached or new audio for this selection
   Cached audio defaults to random selection if none has been previously encountered

   @param previousInstrumentAudio map of previous instrument audio of which to potentially select
   @param instrument              of which to score available audios, and make a selection
   @param event                   to match
   @param chanceOfRandomChoice    of 0 to 1, chance that a random audio will be selected (instead of the cached selection)
   @return matched new audio
   @throws CraftException on failure
   */
  private InstrumentAudio selectInstrumentAudio(Map<String, InstrumentAudio> previousInstrumentAudio, Instrument instrument, ProgramSequencePatternEvent event, Double chanceOfRandomChoice) throws CraftException {
    if (0 < chanceOfRandomChoice && random.nextDouble() <= chanceOfRandomChoice) {
      return selectNewInstrumentAudio(instrument, event);
    } else {
      return selectPreviousInstrumentAudio(previousInstrumentAudio, instrument, event);
    }
  }

  /**
   Select the cached (already selected for this segment+drum name)
   instrument audio based on a pattern event.
   <p>
   If never encountered, default to new selection and cache that.

   @param previousInstrumentAudio map of previous instrument audio of which to potentially select
   @param instrument              of which to score available audios, and make a selection
   @param event                   to match
   @return matched new audio
   @throws CraftException on failure
   */
  private InstrumentAudio selectPreviousInstrumentAudio(Map<String, InstrumentAudio> previousInstrumentAudio, Instrument instrument, ProgramSequencePatternEvent event) throws CraftException {
    String key;
    try {
      key = fabricator.eventKey(event);
    } catch (FabricationException e) {
      throw new CraftException(e);
    }
    if (!previousInstrumentAudio.containsKey(key))
      previousInstrumentAudio.put(key, selectNewInstrumentAudio(instrument, event));
    return previousInstrumentAudio.get(key);
  }

  /**
   Select a new random instrument audio based on a pattern event

   @param instrument of which to score available audios, and make a selection
   @param event      to match
   @return matched new audio
   @throws CraftException on failure
   */
  private InstrumentAudio selectNewInstrumentAudio(Instrument instrument, ProgramSequencePatternEvent event) throws CraftException {
    try {
      EntityScorePicker<InstrumentAudio> audioEntityScorePicker = new EntityScorePicker<>();

      // add all audio to chooser
      audioEntityScorePicker.addAll(fabricator.getSourceMaterial().getAudios(instrument));

      // score each audio against the current voice event, with some variability
      for (InstrumentAudioEvent audioEvent : fabricator.getSourceMaterial().getFirstEventsOfAudiosOfInstrument(instrument))
        audioEntityScorePicker.score(audioEvent.getInstrumentAudioId(),
          Chance.normallyAround(
            NameIsometry.similarity(fabricator.getTrackName(event), audioEvent.getName()),
            SCORE_INSTRUMENT_ENTROPY));

      // final chosen audio event
      return audioEntityScorePicker.getTop();

    } catch (FabricationException | HubClientException e) {
      throw exception(String.format("No acceptable Audio found for instrumentId=%s, eventId=%s", instrument.getId(), event.getId()), e);
    }
  }

  /**
   Pick final note based on instrument type, voice event, transposition and current chord
   <p>
   [#295] Pitch of percussive-type instrument audio is altered the least # semitones possible to conform to the current chord

   @param fromNote       of voice event
   @param chord          current
   @param audio          that has been picked
   @param instrumentType of instrument
   @return final note
   */
  private Note pickNote(Note fromNote, Chord chord, InstrumentAudio audio, Instrument.Type instrumentType) {
    if (Instrument.Type.Percussive == instrumentType) {
      return fabricator.getTuning().getNote(audio.getPitch())
        .conformedTo(chord);
    } else {
      return fromNote
        .conformedTo(chord);
    }
  }

}
