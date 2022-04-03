// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.nexus.craft.detail;

import com.google.common.collect.ImmutableList;
import com.google.inject.Inject;
import com.google.inject.assistedinject.Assisted;
import io.xj.api.SegmentChoice;
import io.xj.hub.enums.InstrumentType;
import io.xj.hub.enums.ProgramType;
import io.xj.hub.tables.pojos.Instrument;
import io.xj.hub.tables.pojos.Program;
import io.xj.hub.tables.pojos.ProgramVoice;
import io.xj.lib.util.Values;
import io.xj.nexus.NexusException;
import io.xj.nexus.craft.CraftImpl;
import io.xj.nexus.fabricator.Fabricator;

import java.util.*;
import java.util.function.Predicate;
import java.util.stream.Collectors;

/**
 Detail craft for the current segment
 [#214] If a Chain has Sequences associated with it directly, prefer those choices to any in the Library
 */
public class DetailCraftImpl extends CraftImpl implements DetailCraft {
  public static final List<String> DETAIL_INSTRUMENT_TYPES =
    ImmutableList.of(
      InstrumentType.Bass,
      InstrumentType.Stripe,
      InstrumentType.Pad,
      InstrumentType.Sticky,
      InstrumentType.Stab
    ).stream().map(InstrumentType::toString).collect(Collectors.toList());

  @Inject
  public DetailCraftImpl(
    @Assisted("basis") Fabricator fabricator
  ) {
    super(fabricator);
  }

  @Override
  public void doWork() throws NexusException {
    // https://www.pivotaltracker.com/story/show/178240332 Segments have intensity arcs; automate mixer layers in and out of each main program
    ChoiceIndexProvider choiceIndexProvider = (SegmentChoice choice) -> Values.stringOrDefault(choice.getInstrumentType(), choice.getId().toString());
    Predicate<SegmentChoice> choiceFilter = (SegmentChoice choice) -> Objects.equals(ProgramType.Detail.toString(), choice.getProgramType());
    precomputeDeltas(
      choiceFilter,
      choiceIndexProvider,
      DETAIL_INSTRUMENT_TYPES,
      List.of(),
      fabricator.getTemplateConfig().getDeltaArcDetailLayersIncoming()
    );

    // For each type of voicing present in the main sequence, choose instrument, then program if necessary
    for (InstrumentType voicingType : fabricator.getDistinctChordVoicingTypes()) {

      // Instrument is from prior choice, else freshly chosen
      Optional<SegmentChoice> priorChoice = fabricator.getChoiceIfContinued(voicingType);

      // Instruments may be chosen without programs
      // https://www.pivotaltracker.com/story/show/181290857
      Optional<Instrument> instrument = priorChoice.isPresent() ?
        fabricator.sourceMaterial().getInstrument(priorChoice.get().getInstrumentId()) :
        chooseFreshInstrument(voicingType, List.of(), null, List.of());

      // Should gracefully skip voicing type if unfulfilled by detail instrument
      // https://www.pivotaltracker.com/story/show/176373977
      if (instrument.isEmpty()) {
        reportMissing(Instrument.class, String.format("%s-type Instrument", voicingType));
        continue;
      }

      // Instruments have InstrumentMode
      // https://www.pivotaltracker.com/story/show/181134085
      switch (instrument.get().getMode()) {

        // NoteEvent instrument mode takes over legacy behavior
        // https://www.pivotaltracker.com/story/show/181736854
        case NoteEvent -> {
          // NoteEvent Use prior chosen program or find a new one
          Optional<Program> program = priorChoice.isPresent() ?
            fabricator.sourceMaterial().getProgram(priorChoice.get().getProgramId()) :
            chooseFreshProgram(ProgramType.Detail, voicingType);

          // NoteEvent Should gracefully skip voicing type if unfulfilled by detail program
          // https://www.pivotaltracker.com/story/show/176373977
          if (program.isEmpty()) {
            reportMissing(Program.class, String.format("%s-type Program", voicingType));
            continue;
          }

          // NoteEvent detail sequence is selected at random of the current instrument
          // FUTURE: https://www.pivotaltracker.com/story/show/166855956 Detail Instrument with multiple Sequences
          var sequence = fabricator.getRandomlySelectedSequence(program.get());

          // NoteEvent voice arrangements
          if (sequence.isPresent()) {
            var voices = fabricator.sourceMaterial().getVoices(program.get());
            if (voices.isEmpty())
              reportMissing(ProgramVoice.class,
                String.format("in Detail-choice Instrument[%s]", instrument.get().getId()));
            craftNoteEvents(sequence.get(), voices, ignored -> instrument, false);
          }
        }

        // ChordPart instrument mode
        // https://www.pivotaltracker.com/story/show/181631275
        case ChordPart -> craftChordParts(instrument.get());

        // As-yet Unsupported Modes
        case VoicingEvent, ChordEvent, VoicingPart, MainPart -> {
          fabricator.addWarningMessage(String.format("Cannot craft unsupported mode %s for Instrument[%s]",
            instrument.get().getMode(), instrument.get().getId()));
        }
      }
    }

    // Finally, update the segment with the crafted content
    fabricator.done();
  }
}
