// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.nexus.craft.transition;

import com.google.inject.Inject;
import com.google.inject.assistedinject.Assisted;
import io.xj.api.SegmentChoice;
import io.xj.api.SegmentChoiceArrangement;
import io.xj.api.SegmentChoiceArrangementPick;
import io.xj.hub.enums.InstrumentType;
import io.xj.hub.tables.pojos.Instrument;
import io.xj.hub.tables.pojos.InstrumentAudio;
import io.xj.lib.music.Bar;
import io.xj.lib.util.MarbleBag;
import io.xj.lib.util.Text;
import io.xj.lib.util.TremendouslyRandom;
import io.xj.nexus.NexusException;
import io.xj.nexus.craft.detail.DetailCraftImpl;
import io.xj.nexus.fabricator.Fabricator;

import java.util.*;
import java.util.stream.Collectors;


/**
 Transition craft for the current segment
 <p>
 Transition-type Instrument #180059746
 */
public class TransitionCraftImpl extends DetailCraftImpl implements TransitionCraft {
  private static final String NAME_BIG = "BIG";
  private static final String NAME_MEDIUM = "MEDIUM";
  private static final String NAME_SMALL = "SMALL";

  @Inject
  public TransitionCraftImpl(
    @Assisted("basis") Fabricator fabricator
  ) {
    super(fabricator);
  }

  /**
   Remove some number of ids from the list

   @param fromIds to begin with
   @param count   number of ids to add
   @return list including added ids
   */
  public static List<UUID> withIdsRemoved(List<UUID> fromIds, int count) {
    var ids = new ArrayList<>(fromIds);
    for (int i = 0; i < count; i++)
      ids.remove((int) TremendouslyRandom.zeroToLimit(ids.size()));
    return ids;
  }

  @Override
  public void doWork() throws NexusException {
    var previousChoices = fabricator.retrospective().getPreviousChoicesOfType(InstrumentType.Transition);

    var instrumentIds = previousChoices.stream()
      .map(SegmentChoice::getInstrumentId)
      .collect(Collectors.toList());

    double targetDensity = isBigTransitionSegment() ? fabricator.getTemplateConfig().getDensityCeiling() : fabricator.getSegment().getDensity();

    int targetLayers = (int) Math.floor(
      fabricator.getTemplateConfig().getTransitionLayerMin() +
        targetDensity *
          (fabricator.getTemplateConfig().getTransitionLayerMax() -
            fabricator.getTemplateConfig().getTransitionLayerMin()));

    fabricator.addInfoMessage(String.format("Targeting %d layers of transition", targetLayers));

    if (instrumentIds.size() > targetLayers)
      instrumentIds = withIdsRemoved(instrumentIds, instrumentIds.size() - targetLayers);

    for (UUID id : instrumentIds) craftTransition(id);

    Optional<Instrument> chosen;
    if (instrumentIds.size() < targetLayers)
      for (int i = 0; i < targetLayers - instrumentIds.size(); i++) {
        chosen = chooseFreshInstrument(InstrumentType.Transition, instrumentIds, null);
        if (chosen.isPresent()) {
          instrumentIds.add(chosen.get().getId());
          craftTransition(chosen.get().getId());
        }
      }

    // Finally, update the segment with the crafted content
    fabricator.done();
  }

  /**
   Is this a big-transition segment? (next main or next macro)

   @return true if it is a big transition segment
   */
  private boolean isBigTransitionSegment() throws NexusException {
    return switch (fabricator.getType()) {
      case PENDING, CONTINUE -> false;
      case INITIAL, NEXTMAIN, NEXTMACRO -> true;
    };
  }

  /**
   Craft percussion loop

   @param instrumentId of percussion loop instrument to craft
   */
  @SuppressWarnings("DuplicatedCode")
  private void craftTransition(UUID instrumentId) throws NexusException {
    fabricator.addMemes(fabricator.sourceMaterial().getInstrument(instrumentId)
      .orElseThrow(() -> new NexusException("Failed to get instrument!")));
    var choice = new SegmentChoice();
    choice.setId(UUID.randomUUID());
    choice.setSegmentId(fabricator.getSegment().getId());
    choice.setInstrumentType(InstrumentType.Transition.toString());
    choice.setInstrumentId(instrumentId);
    fabricator.add(choice);
    var arrangement = new SegmentChoiceArrangement();
    arrangement.setId(UUID.randomUUID());
    arrangement.setSegmentId(fabricator.getSegment().getId());
    arrangement.segmentChoiceId(choice.getId());
    fabricator.add(arrangement);

    var small = pickAudioForInstrument(instrumentId, NAME_SMALL);
    var medium = pickAudioForInstrument(instrumentId, NAME_MEDIUM);
    var big = pickAudioForInstrument(instrumentId, NAME_BIG);

    if (isBigTransitionSegment() && big.isPresent())
      pickTransition(arrangement, big.get(), 0, fabricator.getTotalSeconds(), NAME_BIG);
    else if (medium.isPresent())
      pickTransition(arrangement, medium.get(), 0, fabricator.getTotalSeconds(), NAME_MEDIUM);

    var deltaUnits = Bar.of(fabricator.getMainProgramConfig().getBarBeats()).computeSubsectionBeats(fabricator.getSegment().getTotal());
    var pos = deltaUnits;
    while (pos < fabricator.getSegment().getTotal()) {
      if (small.isPresent())
        pickTransition(arrangement, small.get(), fabricator.getSecondsAtPosition(pos), fabricator.getTotalSeconds(), NAME_SMALL);
      pos += deltaUnits;
    }
  }

  /**
   Pci the transition

   @param arrangement   to pick
   @param audio         to pick
   @param startSeconds  to pick
   @param lengthSeconds to pick
   @param name          to pick
   @throws NexusException on failure
   */
  @SuppressWarnings("DuplicatedCode")
  private void pickTransition(SegmentChoiceArrangement arrangement, InstrumentAudio audio, double startSeconds, double lengthSeconds, String name) throws NexusException {
    var pick = new SegmentChoiceArrangementPick();
    pick.setId(UUID.randomUUID());
    pick.setSegmentId(fabricator.getSegment().getId());
    pick.setSegmentChoiceArrangementId(arrangement.getId());
    pick.setStart(startSeconds);
    pick.setLength(lengthSeconds);
    pick.setAmplitude(1.0);
    pick.setEvent(name);
    pick.setInstrumentAudioId(audio.getId());
    fabricator.add(pick);
  }

  /**
   Choose drum instrument
   [#325] Possible to choose multiple instruments for different voices in the same program

   @return drum-type Instrument
   */
  private Optional<InstrumentAudio> pickAudioForInstrument(UUID instrumentId, String event) {
    var previous = fabricator.retrospective().getPreviousPicksForInstrument(instrumentId).stream()
      .filter(pick -> Objects.equals(event, Text.toMeme(pick.getEvent())))
      .findAny();

    if (previous.isPresent())
      return fabricator.sourceMaterial().getInstrumentAudio(previous.get().getInstrumentAudioId());

    var bag = MarbleBag.empty();

    for (InstrumentAudio audio : fabricator.sourceMaterial().getAudiosForInstrumentId(instrumentId)
      .stream().filter(instrumentAudio -> Text.toMeme(event).equals(Text.toMeme(instrumentAudio.getEvent()))).toList())
      bag.add(audio.getId());

    if (bag.isEmpty()) return Optional.empty();
    return fabricator.sourceMaterial().getInstrumentAudio(bag.pick());
  }

}