// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.nexus.craft.detail;

import com.google.inject.Inject;
import com.google.inject.assistedinject.Assisted;
import io.xj.Instrument;
import io.xj.Program;
import io.xj.ProgramVoice;
import io.xj.Segment;
import io.xj.SegmentChoice;
import io.xj.lib.entity.Entities;
import io.xj.lib.util.Chance;
import io.xj.lib.util.TremendouslyRandom;
import io.xj.nexus.NexusException;
import io.xj.nexus.craft.arrangement.ArrangementCraftImpl;
import io.xj.nexus.fabricator.EntityScorePicker;
import io.xj.nexus.fabricator.Fabricator;
import io.xj.nexus.fabricator.MemeIsometry;

import javax.annotation.Nullable;
import java.util.Collection;
import java.util.Comparator;
import java.util.Map;
import java.util.Objects;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;

/**
 Detail craft for the current segment
 [#214] If a Chain has Sequences associated with it directly, prefer those choices to any in the Library
 */
public class DetailCraftImpl extends ArrangementCraftImpl implements DetailCraft {

  @Inject
  public DetailCraftImpl(
    @Assisted("basis") Fabricator fabricator
  ) {
    super(fabricator);
  }

  @Override
  public void doWork() throws NexusException {
    // for each unique voicing (instrument) types present in the chord voicings of the current main choice
    var voicingTypes = fabricator.getDistinctChordVoicingTypes();

    for (Instrument.Type voicingType : voicingTypes) {
      // program
      Optional<Program> program = chooseDetailProgram(voicingType);

      // [#176373977] Should gracefully skip voicing type if unfulfilled by detail program
      if (program.isEmpty()) {
        reportMissing(Program.class, String.format("Detail-type with voicing-type %s", voicingType));
        continue;
      }

      // add memes of program to segment in order to affect further choice
      fabricator.addMemes(program.get());

      // detail sequence is selected at random of the current program
      // FUTURE: [#166855956] Detail Program with multiple Sequences
      var detailSequence = fabricator.getRandomlySelectedSequence(program.get());

      // voice arrangements
      if (detailSequence.isPresent()) {
        var voices = fabricator.getSourceMaterial().getVoices(program.get());
        if (voices.isEmpty())
          reportMissing(ProgramVoice.class,
            String.format("in Detail-choice Program[%s]", program.get().getId()));

        // Each voice will use either its new choice or an inertial choice.
        for (ProgramVoice voice : voices) {
          Optional<String> instrumentId = fabricator.getInstrumentIdChosenForVoiceOfSameMainProgram(voice);

          // if no previous instrument found, choose a fresh one
          var instrument = instrumentId.isPresent() ?
            fabricator.getSourceMaterial().getInstrument(instrumentId.get()) :
            chooseFreshDetailInstrument(voicingType);

          // [#176373977] Should gracefully skip voicing type if unfulfilled by detail program
          if (instrument.isEmpty()) {
            reportMissing(Instrument.class, String.format("Detail-type like %s", voice.getName()));
            return;
          }

          // add memes of instrument to segment in order to affect further choice
          fabricator.addMemes(instrument.get());

          var primaryChoice = fabricator.add(SegmentChoice.newBuilder()
            .setId(UUID.randomUUID().toString())
            .setType(SegmentChoice.Type.Primary)
            .setInstrumentId(instrument.get().getId())
            .setProgramType(program.get().getType())
            .setInstrumentType(instrument.get().getType())
            .setProgramId(program.get().getId())
            .setProgramSequenceId(detailSequence.get().getId())
            .setProgramVoiceId(voice.getId())
            .setSegmentId(fabricator.getSegment().getId())
            .build());

          // Optionally, use the inertial choice that corresponds to this primary one, instead.
          var inertialChoice = computeInertialChoice(primaryChoice);

          // If there's an inertial choice, use it
          if (inertialChoice.isPresent())
            this.craftArrangements(fabricator.add(inertialChoice.get()));
          else
            this.craftArrangements(primaryChoice);
        }
      }
    }

    // Finally, update the segment with the crafted content
    fabricator.done();
  }

  /**
   Choose a detail program having voice(s) of the given type

   @param voicingType of voicing to choose detail program for
   @return Chosen Detail Program
   */
  private Optional<Program> chooseDetailProgram(Instrument.Type voicingType) throws NexusException {
    Segment.Type type;
    type = fabricator.getType();

    switch (type) {
      case Continue:
        Optional<Program> selectedPreviously = getDetailProgramSelectedPreviouslyForSegmentMainProgram(voicingType);
        return selectedPreviously.isPresent() ? selectedPreviously : chooseFreshDetailProgram(voicingType);

      case Initial:
      case NextMain:
      case NextMacro:
        return chooseFreshDetailProgram(voicingType);

      default:
        throw new NexusException(String.format("Cannot get Detail-type program for unknown fabricator type=%s", type));
    }
  }

  /**
   Choose a fresh detail based on a set of memes
   FUTURE [#150279436] Key of first Pattern of chosen Detail-Program must match the `minor` or `major` with the Key of the current Segment.

   @param voicingType to choose a fresh detail program for-- meaning the detail program will have this type of voice
   @return detail-type Program
   */
  private Optional<Program> chooseFreshDetailProgram(Instrument.Type voicingType) {
    EntityScorePicker<Program> superEntityScorePicker = new EntityScorePicker<>();

    // Retrieve programs bound to chain having a voice of the specified type
    Map<String/*ID*/, Program> programMap = fabricator.getSourceMaterial()
      .getProgramsOfType(Program.Type.Detail).stream()
      .collect(Collectors.toMap(Program::getId, program -> program));
    Collection<Program> sourcePrograms = fabricator.getSourceMaterial()
      .getAllProgramVoices().stream()
      .filter(programVoice -> voicingType.equals(programVoice.getType()) &&
        programMap.containsKey(programVoice.getProgramId()))
      .map(ProgramVoice::getProgramId)
      .distinct()
      .map(programMap::get)
      .collect(Collectors.toList());

    // (3) score each source program based on meme isometry
    MemeIsometry detailIsometry = fabricator.getMemeIsometryOfSegment();
    for (Program program : sourcePrograms) superEntityScorePicker.add(program, scoreDetail(program, detailIsometry));

    // report
    fabricator.putReport("detailChoice", superEntityScorePicker.report());

    // (4) return the top choice
    return superEntityScorePicker.getTop();

  }

  /**
   Choose detail instrument
   [#325] Possible to choose multiple instruments for different voices in the same program

   @param type of instrument to choose
   @return detail-type Instrument
   */
  protected Optional<Instrument> chooseFreshDetailInstrument(Instrument.Type type) {
    EntityScorePicker<Instrument> superEntityScorePicker = new EntityScorePicker<>();

    // (2) retrieve instruments bound to chain
    Collection<Instrument> sourceInstruments = fabricator.getSourceMaterial().getInstrumentsOfType(type);

    // (3) score each source instrument based on meme isometry
    for (Instrument instrument : sourceInstruments)
      if (instrument.getType().equals(type))
        superEntityScorePicker.add(instrument, scoreDetail(instrument));

    // (4) prefer same instrument choices throughout a main program
    // Instrument choice inertia
    // https://www.pivotaltracker.com/story/show/178442889
    // If the previously chosen instruments are for the same main program as the current segment,
    // score them all at 95% inertia (almost definitely will choose again)
    if (Segment.Type.Continue.equals(fabricator.getSegment().getType()))
      fabricator.retrospective().getChoices().stream()
        .filter(candidate -> candidate.getInstrumentType().equals(type))
        .forEach(choice -> superEntityScorePicker.score(choice.getInstrumentId(), SCORE_MATCHED_MAIN_PROGRAM));

    // report
    fabricator.putReport("detailChoice", superEntityScorePicker.report());

    // (4) return the top choice
    return superEntityScorePicker.getTop();
  }

  /**
   Score a candidate for detail instrument, given current fabricator

   @param instrument to score
   @return score, including +/- entropy
   */
  protected double scoreDetail(Instrument instrument) {
    double score = Chance.normallyAround(0, SCORE_ENTROPY_CHOICE_INSTRUMENT);

    // Score includes matching memes, previous segment to macro instrument first pattern
    score += SCORE_MATCHED_MEMES *
      fabricator.getMemeIsometryOfSegment().score(
        Entities.namesOf(fabricator.getSourceMaterial().getMemes(instrument)));

    // [#174435421] Chain bindings specify Program & Instrument within Library
    if (fabricator.isDirectlyBound(instrument))
      score += SCORE_DIRECTLY_BOUND;

    return score;
  }

  /**
   Continue-type: 50% chance to continue an inertial choice from retrospective inertial choices
   NextMain/NextMacro-type: 50% chance of taking an inertial choice directly from retrospective primary choices

   @param source from which to extrapolate and compute an optional inertial choice
   @return inertial choice if it ought to be used, otherwise, empty.
   */
  protected Optional<SegmentChoice> computeInertialChoice(SegmentChoice source) throws NexusException {
    return
      switch (fabricator.getChain().getType()) {
        case Preview, UNRECOGNIZED -> Optional.empty();
        case Production -> switch (fabricator.getSegment().getType()) {
          case Pending, UNRECOGNIZED -> throw new NexusException(
            String.format("Can't compute inertial choice for %s-type Segment!", fabricator.getSegment().getType()));
          case Initial -> Optional.empty();
          case Continue -> computeInertialChoice(source, fabricator.retrospective().getInertialChoices());
          case NextMacro, NextMain -> computeInertialChoice(source, fabricator.retrospective().getPrimaryChoices());
        };
      };
  }

  /**
   Compute inertial choices for the source choice given a set of candidates

   @param source     from which to extrapolate and compute an optional inertial choice
   @param candidates from which to score and optionally select a
   @return inertial choice if it ought to be used, otherwise, empty.
   */
  private Optional<SegmentChoice> computeInertialChoice(SegmentChoice source, Collection<SegmentChoice> candidates) {
    return buildInertialIfBeatsOdds(
      candidates.stream()
        .filter(candidate ->
          candidate.getProgramType().equals(source.getProgramType())
            && candidate.getInstrumentType().equals(source.getInstrumentType()))
        .map(candidate -> new InertialCandidate(fabricator, candidate, source))
        .filter(InertialCandidate::isValid)
        .max(Comparator.comparing(InertialCandidate::getScore))
        .map(InertialCandidate::getTarget)
        .orElse(null));
  }


  /**
   % chance of returning the given choice, otherwise empty

   @param choice to pass through if the odds hit
   @return choice if it ought to be used, otherwise, empty.
   */
  private Optional<SegmentChoice> buildInertialIfBeatsOdds(@Nullable SegmentChoice choice) {
    if (Objects.isNull(choice))
      return Optional.empty();
    else if (!TremendouslyRandom.beatOddsPercent(fabricator.getChainConfig().getCraftChoiceInertiaPercent()))
      return Optional.empty();
    else
      return Optional.of(choice.toBuilder()
        .setSegmentId(fabricator.getSegment().getId())
        .setType(SegmentChoice.Type.Inertial)
        .build());
  }

  /**
   Score a candidate for detail program, given current fabricator
   Score includes matching memes, previous segment to macro program first pattern
   <p>
   Returns ZERO if the program has no memes, in order to fix:
   [#162040109] Artist expects program with no memes will never be selected for chain craft.

   @param program        to score
   @param detailIsometry from which to score detail programs
   @return score, including +/- entropy; empty if this program has no memes, and isn't directly bound
   */
  @SuppressWarnings("DuplicatedCode")
  private Double scoreDetail(Program program, MemeIsometry detailIsometry) {
    double score = 0;
    Collection<String> memes = fabricator.getSourceMaterial().getMemesAtBeginning(program);
    if (!memes.isEmpty())
      score += detailIsometry.score(memes) * SCORE_MATCHED_MEMES + Chance.normallyAround(0, SCORE_ENTROPY_CHOICE_DETAIL);

    // [#174435421] Chain bindings specify Program & Instrument within Library
    if (fabricator.isDirectlyBound(program))
      score += SCORE_DIRECTLY_BOUND;

    // score is above zero, else empty
    return score;

  }

  /**
   Determine if a detail program has been previously selected
   in one of the previous segments of the current main program
   wherein the current pattern of the selected main program
   <p>
   [#176468964] Rhythm and Detail choices are kept for an entire Main Program

   @param voicingType to get detail program for
   @return detail program if previously selected, or null if none is found
   */
  private Optional<Program> getDetailProgramSelectedPreviouslyForSegmentMainProgram(Instrument.Type voicingType) {
    return fabricator.getPreferredProgramIds(Program.Type.Detail, voicingType)
      .stream()
      .flatMap(choice -> fabricator.getSourceMaterial().getProgram(choice).stream())
      .findFirst();
  }

}
