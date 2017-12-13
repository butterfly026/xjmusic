// Copyright (c) 2017, Outright Mental Inc. (http://outright.io) All Rights Reserved.
package io.xj.core.craft.impl;

import io.xj.core.access.impl.Access;
import io.xj.core.craft.FoundationCraft;
import io.xj.core.dao.ChoiceDAO;
import io.xj.core.dao.LinkChordDAO;
import io.xj.core.dao.LinkMemeDAO;
import io.xj.core.dao.PatternDAO;
import io.xj.core.dao.PatternMemeDAO;
import io.xj.core.dao.PhaseChordDAO;
import io.xj.core.exception.BusinessException;
import io.xj.core.isometry.MemeIsometry;
import io.xj.core.model.MemeEntity;
import io.xj.core.model.choice.Chance;
import io.xj.core.model.choice.Choice;
import io.xj.core.model.choice.Chooser;
import io.xj.core.model.link_chord.LinkChord;
import io.xj.core.model.link_meme.LinkMeme;
import io.xj.core.model.pattern.Pattern;
import io.xj.core.model.pattern.PatternType;
import io.xj.core.tables.records.PhaseRecord;
import io.xj.core.util.Value;
import io.xj.core.work.basis.Basis;
import io.xj.music.Chord;
import io.xj.music.Key;

import org.jooq.Record;
import org.jooq.Result;
import org.jooq.types.ULong;

import com.google.common.collect.Maps;
import com.google.inject.Inject;
import com.google.inject.assistedinject.Assisted;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.sql.Timestamp;
import java.util.Map;
import java.util.Objects;

import static io.xj.core.tables.Pattern.PATTERN;

/**
 [#214] If a Chain has Patterns associated with it directly, prefer those choices to any in the Library
 */
public class FoundationCraftImpl implements FoundationCraft {
  private static final double SCORE_MATCHED_KEY_MODE = 10;
  private static final double SCORE_AVOID_CHOOSING_PREVIOUS = 10;
  public static final double CHOOSE_MACRO_MAX_DISTRIBUTION = 0.5;
  public static final double CHOOSE_MAIN_MAX_DISTRIBUTION = 0.5;
  private static final long NANOS_PER_SECOND = 1_000_000_000;
  private final Logger log = LoggerFactory.getLogger(FoundationCraftImpl.class);
  private final ChoiceDAO choiceDAO;
  private final PatternDAO patternDAO;
  private final PatternMemeDAO patternMemeDAO;
  private final LinkChordDAO linkChordDAO;
  private final LinkMemeDAO linkMemeDAO;
  private final PhaseChordDAO phaseChordDAO;
  private final Basis basis;
  private Pattern _macroPattern;
  private Pattern _mainPattern;
  private ULong _macroPhaseOffset;
  private ULong _mainPhaseOffset;

  @Inject
  public FoundationCraftImpl(
    @Assisted("basis") Basis basis,
    ChoiceDAO choiceDAO,
    PatternDAO patternDAO,
    PatternMemeDAO patternMemeDAO,
    LinkChordDAO linkChordDAO,
    LinkMemeDAO linkMemeDAO,
    PhaseChordDAO phaseChordDAO
  /*-*/) {
    this.basis = basis;
    this.choiceDAO = choiceDAO;
    this.patternDAO = patternDAO;
    this.patternMemeDAO = patternMemeDAO;
    this.linkChordDAO = linkChordDAO;
    this.linkMemeDAO = linkMemeDAO;
    this.phaseChordDAO = phaseChordDAO;
  }

  @Override
  public void doWork() throws BusinessException {
    try {
      craftMacro();
      craftMain();
      craftMemes();
      craftChords();
      basis.updateLink(basis.link()
        .setDensity(linkDensity())
        .setTempo(linkTempo())
        .setKey(linkKey())
        .setTotal(linkTotal())
        .setEndAtTimestamp(linkEndTimestamp()));
      report();

    } catch (BusinessException e) {
      throw e;
    } catch (Exception e) {
      throw new BusinessException(
        String.format("Failed to do %s-type FoundationCraft for link #%s",
          basis.type(), basis.linkId().toString()), e);
    }
  }

  /**
   Report
   */
  private void report() {
    // future: basis.report() anything else interesting from the craft operation
  }

  /**
   Make Macro-type Pattern Choice
   add macro-pattern choice to link

   @throws Exception on any failure
   */
  private void craftMacro() throws Exception {
    choiceDAO.create(Access.internal(),
      new Choice()
        .setLinkId(basis.linkId().toBigInteger())
        .setType(PatternType.Macro.toString())
        .setPatternId(macroPattern().getId().toBigInteger())
        .setTranspose(macroTranspose())
        .setPhaseOffset(macroPhaseOffset().toBigInteger()));
  }

  /**
   Make Main-type Pattern Choice
   add macro-pattern choice to link

   @throws Exception on any failure
   */
  private void craftMain() throws Exception {
    choiceDAO.create(Access.internal(),
      new Choice()
        .setLinkId(basis.linkId().toBigInteger())
        .setType(PatternType.Main.toString())
        .setPatternId(mainPattern().getId().toBigInteger())
        .setTranspose(mainTranspose())
        .setPhaseOffset(mainPhaseOffset().toBigInteger()));
  }

  /**
   Make Memes
   add all memes to link

   @throws Exception on any failure
   */
  private void craftMemes() throws Exception {
    linkMemes().forEach((memeName, linkMeme) -> {
      try {
        linkMemeDAO.create(Access.internal(), linkMeme);

      } catch (Exception e) {
        log.warn("failed to create link meme '" + memeName + '"', e);
      }
    });
  }

  /**
   Make Chords
   Link Chords = Main Pattern Phase Chords, transposed according to to main pattern choice

   @throws Exception on any failure
   */
  private void craftChords() throws Exception {
    phaseChordDAO.readAll(Access.internal(), mainPhase().getId())
      .forEach(phaseChordRecord -> {
        String name = "NaN";
        try {
          // delta the chord name
          name = Chord.of(phaseChordRecord.getName()).transpose(mainTranspose()).getFullDescription();
          // create the transposed chord
          linkChordDAO.create(Access.internal(),
            new LinkChord()
              .setLinkId(basis.linkId().toBigInteger())
              .setName(name)
              .setPosition(phaseChordRecord.getPosition()));

        } catch (Exception e) {
          log.warn("failed to create transposed link chord '" +
            String.valueOf(name) + "'@" + phaseChordRecord.getPosition(), e);
        }
      });
  }

  /**
   compute (and cache) the chosen macro pattern

   @return macro-type pattern
   @throws Exception on failure
   */
  private Pattern macroPattern() throws Exception {
    if (Objects.isNull(_macroPattern))
      switch (basis.type()) {

        case Initial:
          _macroPattern = chooseMacro();
          break;

        case Continue:
        case NextMain:
          Choice previousChoice = basis.previousMacroChoice();
          if (Objects.isNull(previousChoice))
            throw new BusinessException("No macro-type pattern chosen in previous link!");
          _macroPattern = basis.pattern(previousChoice.getPatternId());
          break;

        case NextMacro:
          _macroPattern = chooseMacro();
      }
    return _macroPattern;
  }

  /**
   compute (and cache) the mainPattern

   @return mainPattern
   */
  private Pattern mainPattern() throws Exception {
    if (Objects.isNull(_mainPattern))
      switch (basis.type()) {

        case Continue:
          Choice previousChoice = basis.previousMainChoice();
          if (Objects.isNull(previousChoice))
            throw new BusinessException("No main-type pattern chosen in previous link!");
          _mainPattern = basis.pattern(previousChoice.getPatternId());
          break;

        case Initial:
        case NextMain:
        case NextMacro:
          _mainPattern = chooseMain();
      }


    return _mainPattern;
  }

  /**
   compute (and cache) the macroTranspose

   @return macroTranspose
   */
  private Integer macroTranspose() throws Exception {
    switch (basis.type()) {

      case Initial:
        return 0;

      case Continue:
      case NextMain:
        return basis.previousMacroChoice().getTranspose();

      case NextMacro:
        return Key.delta(macroPattern().getKey(),
          basis.previousMacroNextPhase().getKey(),
          basis.previousMacroChoice().getTranspose());

      default:
        throw new BusinessException("unable to determine macro-type pattern transposition");
    }
  }

  /**
   compute (and cache) Transpose Main-Pattern to the transposed key of the current macro phase

   @return mainTranspose
   */
  private Integer mainTranspose() throws Exception {
    return Key.delta(mainPattern().getKey(),
      Value.eitherOr(macroPhase().getKey(), macroPattern().getKey()),
      macroTranspose());
  }

  /**
   compute (and cache) the macroPhaseOffset

   @return macroPhaseOffset
   */
  private ULong macroPhaseOffset() throws Exception {
    if (Objects.isNull(_macroPhaseOffset))
      switch (basis.type()) {

        case Initial:
          _macroPhaseOffset = ULong.valueOf(0);
          break;

        case Continue:
          _macroPhaseOffset = basis.previousMacroChoice().getPhaseOffset();
          break;

        case NextMain:
          _macroPhaseOffset = basis.previousMacroChoice().nextPhaseOffset();
          break;

        case NextMacro:
          _macroPhaseOffset = ULong.valueOf(0);
      }

    return _macroPhaseOffset;
  }

  /**
   compute (and cache) the mainPhaseOffset

   @return mainPhaseOffset
   */
  private ULong mainPhaseOffset() throws Exception {
    if (Objects.isNull(_mainPhaseOffset))
      switch (basis.type()) {

        case Initial:
          _mainPhaseOffset = ULong.valueOf(0);
          break;

        case Continue:
          _mainPhaseOffset = basis.previousMainChoice().nextPhaseOffset();
          break;

        case NextMain:
          _mainPhaseOffset = ULong.valueOf(0);
          break;

        case NextMacro:
          _mainPhaseOffset = ULong.valueOf(0);
      }

    return _mainPhaseOffset;
  }

  /**
   Fetch current phase of macro-type pattern

   @return phase record
   @throws Exception on failure
   */
  private PhaseRecord macroPhase() throws Exception {
    PhaseRecord phase = basis.phaseByOffset(macroPattern().getId(), macroPhaseOffset());

    if (Objects.isNull(phase))
      throw new BusinessException("macro-phase does not exist!");

    return phase;
  }

  /**
   Fetch current phase of main-type pattern

   @return phase record
   @throws Exception on failure
   */
  private PhaseRecord mainPhase() throws Exception {
    PhaseRecord phase = basis.phaseByOffset(mainPattern().getId(), mainPhaseOffset());

    if (Objects.isNull(phase))
      throw new BusinessException("main-phase does not exist!");

    return phase;
  }

  /**
   Choose macro pattern

   @return macro-type pattern
   @throws Exception on failure
   */
  private Pattern chooseMacro() throws Exception {
    Chooser<Pattern> chooser = new Chooser<>();
    String key = basis.isInitialLink() ? null : basis.previousMacroPhase().getKey();

    // (1a) retrieve patterns bound directly to chain
    Result<? extends Record> sourceRecords = patternDAO.readAllBoundToChain(Access.internal(), basis.chainId(), PatternType.Macro);

    // (1b) only if none were found in the previous transpose, retrieve patterns bound to chain library
    if (sourceRecords.isEmpty())
      sourceRecords = patternDAO.readAllBoundToChainLibrary(Access.internal(), basis.chainId(), PatternType.Macro);

    // (2) score each source record
    sourceRecords.forEach((record -> {
      try {
        chooser.add(new Pattern().setFromRecord(record),
          Chance.normallyAround(
            Key.isSameMode(key, record.get(PATTERN.KEY)) ? SCORE_MATCHED_KEY_MODE : 0,
            CHOOSE_MACRO_MAX_DISTRIBUTION));
      } catch (BusinessException e) {
        log.debug("while scoring macro patterns", e);
      }
    }));

    // (2b) Avoid previous macro pattern
    if (!basis.isInitialLink())
      chooser.score(basis.previousMacroChoice().getPatternId(), -SCORE_AVOID_CHOOSING_PREVIOUS);

    // report
    basis.report("macroChoice", chooser.report());

    // (3) return the top choice
    Pattern pattern = chooser.getTop();
    if (Objects.nonNull(pattern))
      return pattern;
    else
      throw new BusinessException("Found no macro-type pattern bound to Chain!");
  }

  /**
   Choose main pattern

   @return main-type Pattern
   @throws Exception on failure
   <p>
   future: don't we need to pass in the current phase of the macro pattern?
   */
  private Pattern chooseMain() throws Exception {
    Chooser<Pattern> chooser = new Chooser<>();

    // future: only choose major patterns for major keys, minor for minor! [#223] Key of first Phase of chosen Main-Pattern must match the `minor` or `major` with the Key of the current Link.

    // (1) retrieve memes of macro pattern, for use as a meme isometry comparison
    MemeIsometry memeIsometry = MemeIsometry.of(patternMemeDAO.readAll(Access.internal(), macroPattern().getId()));

    // (2a) retrieve patterns bound directly to chain
    Result<? extends Record> sourceRecords = patternDAO.readAllBoundToChain(Access.internal(), basis.chainId(), PatternType.Main);

    // (2b) only if none were found in the previous transpose, retrieve patterns bound to chain library
    if (sourceRecords.isEmpty())
      sourceRecords = patternDAO.readAllBoundToChainLibrary(Access.internal(), basis.chainId(), PatternType.Main);

    // (3) score each source record based on meme isometry
    sourceRecords.forEach((record -> {
      try {
        chooser.add(new Pattern().setFromRecord(record),
          Chance.normallyAround(
            memeIsometry.scoreCSV(String.valueOf(record.get(MemeEntity.KEY_MANY))),
            CHOOSE_MAIN_MAX_DISTRIBUTION));
      } catch (BusinessException e) {
        log.debug("while scoring main patterns", e);
      }
    }));

    // (3b) Avoid previous main pattern
    if (!basis.isInitialLink())
      chooser.score(basis.previousMainChoice().getPatternId(), -SCORE_AVOID_CHOOSING_PREVIOUS);

    // report
    basis.report("mainChoice", chooser.report());

    // (4) return the top choice
    Pattern pattern = chooser.getTop();
    if (Objects.nonNull(pattern))
      return pattern;
    else
      throw new BusinessException("Found no main-type pattern bound to Chain!");
  }

  /**
   prepare map of final link memes

   @return map of meme name to LinkMeme entity
   */
  private Map<String, LinkMeme> linkMemes() throws Exception {
    Map<String, LinkMeme> out = Maps.newHashMap();

    basis.patternMemes(macroPattern().getId())
      .forEach(meme -> out.put(
        meme.getName(), basis.linkMeme(basis.linkId(), meme.getName())));

    basis.phaseMemes(macroPhase().getId())
      .forEach(meme -> out.put(
        meme.getName(), basis.linkMeme(basis.linkId(), meme.getName())));

    basis.patternMemes(mainPattern().getId())
      .forEach(meme -> out.put(
        meme.getName(), basis.linkMeme(basis.linkId(), meme.getName())));

    basis.phaseMemes(mainPhase().getId())
      .forEach(meme -> out.put(
        meme.getName(), basis.linkMeme(basis.linkId(), meme.getName())));

    return out;
  }

  /**
   Get Link length, in nanoseconds
   If a previous link exists, the tempo is averaged with its tempo, because the tempo will increase at a linear rate from start to finish.

   @return link length, in nanoseconds
   @throws Exception on failure
   */
  private long linkLengthNanos() throws Exception {
    return (long) (basis.secondsAtPosition(linkTotal()) * NANOS_PER_SECOND);
  }

  /**
   Get Link End Timestamp
   Link Length Time = Link Tempo (time per Beat) * Link Length (# Beats)

   @return end timestamp
   @throws BusinessException on failure
   */
  private Timestamp linkEndTimestamp() throws Exception {
    return Timestamp.from(basis.linkBeginAt().toInstant().plusNanos(linkLengthNanos()));
  }

  /**
   Compute the total # of beats of the current link
   Link Total (# Beats) = from current Phase of Main-Pattern

   @return # beats total
   @throws Exception on failure
   */
  private Integer linkTotal() throws Exception {
    return mainPhase().getTotal().intValue();
  }

  /**
   Compute the final key of the current link
   Link Key is the transposed key of the current main phase

   @return key
   @throws Exception on failure
   */
  private String linkKey() throws Exception {
    return Key.of(mainPhase().getKey()).transpose(mainTranspose()).getFullDescription();
  }

  /**
   Compute the final tempo of the current link

   @return tempo
   @throws Exception on failure
   */
  private double linkTempo() throws Exception {
    return (Value.eitherOr(macroPhase().getTempo(), macroPattern().getTempo()) +
      Value.eitherOr(mainPhase().getTempo(), mainPattern().getTempo())) / 2;
  }

  /**
   Compute the final density of the current link
   future: Link Density = average of macro and main-pattern phases

   @return density
   @throws Exception on failure
   */
  private Double linkDensity() throws Exception {
    return (Value.eitherOr(macroPhase().getDensity(), macroPattern().getDensity()) +
      Value.eitherOr(mainPhase().getDensity(), mainPattern().getDensity())) / 2;
  }

}