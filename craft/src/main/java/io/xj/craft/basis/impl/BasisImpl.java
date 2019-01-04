// Copyright (c) 2018, XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.craft.basis.impl;

import com.google.common.collect.ImmutableList;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.google.gson.Gson;
import com.google.inject.Inject;
import com.google.inject.assistedinject.Assisted;
import io.xj.core.access.impl.Access;
import io.xj.core.config.Config;
import io.xj.core.config.Exposure;
import io.xj.core.dao.ArrangementDAO;
import io.xj.core.dao.ChainConfigDAO;
import io.xj.core.dao.ChainInstrumentDAO;
import io.xj.core.dao.ChainLibraryDAO;
import io.xj.core.dao.ChainSequenceDAO;
import io.xj.core.dao.ChoiceDAO;
import io.xj.core.dao.SegmentChordDAO;
import io.xj.core.dao.SegmentDAO;
import io.xj.core.dao.SegmentMemeDAO;
import io.xj.core.dao.SequenceDAO;
import io.xj.core.exception.BusinessException;
import io.xj.core.model.arrangement.Arrangement;
import io.xj.core.model.audio.Audio;
import io.xj.core.model.chain_config.ChainConfig;
import io.xj.core.model.chain_config.ChainConfigType;
import io.xj.core.model.chain_instrument.ChainInstrument;
import io.xj.core.model.chain_library.ChainLibrary;
import io.xj.core.model.chain_sequence.ChainSequence;
import io.xj.core.model.choice.Choice;
import io.xj.core.model.entity.Entity;
import io.xj.core.model.instrument.Instrument;
import io.xj.core.model.library.Library;
import io.xj.core.model.pattern.Pattern;
import io.xj.core.model.pattern.PatternType;
import io.xj.core.model.pick.Pick;
import io.xj.core.model.segment.Segment;
import io.xj.core.model.segment_chord.SegmentChord;
import io.xj.core.model.segment_meme.SegmentMeme;
import io.xj.core.model.sequence.Sequence;
import io.xj.core.model.sequence.SequenceType;
import io.xj.core.transport.CSV;
import io.xj.core.transport.JSON;
import io.xj.core.util.Value;
import io.xj.craft.basis.Basis;
import io.xj.craft.basis.BasisType;
import io.xj.craft.ingest.Ingest;
import io.xj.craft.ingest.cache.IngestCacheProvider;
import io.xj.craft.isometry.Isometry;
import io.xj.craft.isometry.MemeIsometry;
import io.xj.music.BPM;
import io.xj.music.Chord;
import io.xj.music.MusicalException;
import io.xj.music.Note;
import io.xj.music.Tuning;
import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.annotation.Nullable;
import javax.sound.sampled.AudioFormat;
import java.math.BigInteger;
import java.sql.Timestamp;
import java.time.Duration;
import java.util.Collection;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.Objects;

/**
 [#214] If a Chain has Sequences associated with it directly, prefer those choices to any in the Library
 */
public class BasisImpl implements Basis {
  private static final int MICROSECONDS_PER_SECOND = 1000000;
  private static final double COMPUTE_INTEGRAL_DX = 0.25d; // # beats granularity to compute tempo change integral
  private static final double NANOS_PER_SECOND = 1000000000.0;
  private static final String JSON_ATTR_REPORT = Exposure.KEY_REPORT;
  private static final String JSON_ATTR_PICKS = Exposure.KEY_PICKS;
  private static final String JSON_ATTR_CHAIN_CONFIGS = Exposure.KEY_CHAIN_CONFIGS;
  private static final String JSON_ATTR_TYPE = Exposure.KEY_TYPE;
  private static final String JSON_ATTR_CHOICES = Exposure.KEY_CHOICES;
  private static final String JSON_ATTR_ARRANGEMENTS = Exposure.KEY_ARRANGEMENTS;
  private static final String JSON_ATTR_SEGMENT_MEMES = Exposure.KEY_SEGMENT_MEMES;
  private static final String JSON_ATTR_SEGMENT_CHORDS = Exposure.KEY_SEGMENT_CHORDS;
  private final ArrangementDAO arrangementDAO;
  private final BasisType type;
  private final ChainConfigDAO chainConfigDAO;
  private final ChainInstrumentDAO chainInstrumentDAO;
  private final ChainLibraryDAO chainLibraryDAO;
  private final ChainSequenceDAO chainSequenceDAO;
  private final ChoiceDAO choiceDAO;
  private final Collection<Segment> _previousSegmentsWithThisMainSequence = Lists.newArrayList();
  private final Collection<Choice> _currentChoices = Lists.newArrayList();
  private final Collection<Arrangement> _currentArrangements = Lists.newArrayList();
  private final Collection<SegmentChord> _currentSegmentChords = Lists.newArrayList();
  private final Collection<SegmentMeme> _currentSegmentMemes = Lists.newArrayList();
  private final Gson gson = JSON.gson();
  private final IngestCacheProvider ingestProvider;
  private final List<Pick> _picks = Lists.newArrayList();
  private final Logger log = LoggerFactory.getLogger(BasisImpl.class);
  private final long startTime;
  private final Map<BigInteger, Audio> _audiosFromPicks = Maps.newConcurrentMap();
  private final Map<BigInteger, Collection<Arrangement>> _arrangements = Maps.newConcurrentMap();
  private final Map<BigInteger, Collection<Arrangement>> _choiceArrangements = Maps.newConcurrentMap();
  private final Map<BigInteger, Collection<Choice>> _choices = Maps.newConcurrentMap();
  private final Map<BigInteger, Collection<SegmentMeme>> _segmentMemes = Maps.newConcurrentMap();
  private final Map<BigInteger, Map<BigInteger, Segment>> _segmentsByOffset = Maps.newConcurrentMap();
  private final Map<BigInteger, Map<SequenceType, Choice>> _segmentChoicesByType = Maps.newConcurrentMap();
  private final Map<BigInteger, Sequence> _sequencesById = Maps.newConcurrentMap();
  private final Map<ChainConfigType, ChainConfig> _chainConfigs = Maps.newConcurrentMap();
  private final Map<Double, Double> _positionSeconds = Maps.newConcurrentMap();
  private final Map<String, String> _report = Maps.newConcurrentMap();
  private final SegmentChordDAO segmentChordDAO;
  private final SegmentDAO segmentDAO;
  private final SegmentMemeDAO segmentMemeDAO;
  private final SequenceDAO sequenceDAO;
  private final Tuning tuning;
  private Segment segment;
  private MemeIsometry _currentMacroMemeIsometry;
  private MemeIsometry _previousMacroMemeIsometry;
  private MemeIsometry _currentSegmentMemeIsometry;
  private Ingest _ingest;
  private Ingest _libraryIngest;

  @Inject
  public BasisImpl(
    @Assisted("segment") Segment segment,
    ArrangementDAO arrangementDAO,
    ChainConfigDAO chainConfigDAO,
    ChainLibraryDAO chainLibraryDAO,
    ChainSequenceDAO chainSequenceDAO,
    ChainInstrumentDAO chainInstrumentDAO,
    ChoiceDAO choiceDAO,
    IngestCacheProvider ingestProvider,
    SegmentChordDAO segmentChordDAO,
    SegmentDAO segmentDAO,
    SegmentMemeDAO segmentMemeDAO,
    SequenceDAO sequenceDAO
  ) throws BusinessException {
    this.arrangementDAO = arrangementDAO;
    this.chainConfigDAO = chainConfigDAO;
    this.chainLibraryDAO = chainLibraryDAO;
    this.chainSequenceDAO = chainSequenceDAO;
    this.chainInstrumentDAO = chainInstrumentDAO;
    this.choiceDAO = choiceDAO;
    this.ingestProvider = ingestProvider;
    this.segmentChordDAO = segmentChordDAO;
    this.segmentDAO = segmentDAO;
    this.segmentMemeDAO = segmentMemeDAO;
    this.sequenceDAO = sequenceDAO;

    // Ingest Segment
    this.segment = segment;
    type = computeType();
    tuning = computeTuning();
    startTime = System.nanoTime();
  }

  /**
   [#255] Tuning based on root note configured in environment parameters.
   */
  private static Tuning computeTuning() throws BusinessException {
    try {
      return Tuning.at(
        Note.of(Config.tuningRootNote()),
        Config.tuningRootPitch());
    } catch (MusicalException e) {
      throw new BusinessException("Could not tune XJ!", e);
    }
  }

  @Override
  public String outputFilePath() throws BusinessException {
    if (Objects.isNull(segment().getWaveformKey()))
      throw new BusinessException("Segment has no waveform key!");

    return Config.workTempFilePathPrefix() + segment().getWaveformKey();
  }

  @Override
  public AudioFormat outputAudioFormat() throws Exception {
    return new AudioFormat(
      outputEncoding(),
      outputFrameRate(),
      outputSampleBits(),
      outputChannels(),
      outputChannels() * outputSampleBits() / 8,
      outputFrameRate(),
      false);
  }

  @Override
  public BasisType type() {
    return type;
  }

  @Override
  public Segment segment() {
    return segment;
  }

  @Override
  public Boolean isInitialSegment() {
    return segment.isInitial();
  }

  @Override
  public BigInteger chainId() {
    return segment.getChainId();
  }

  @Override
  public ChainConfig chainConfig(ChainConfigType chainConfigType) throws Exception {
    if (chainConfigs().containsKey(chainConfigType))
      return chainConfigs().get(chainConfigType);

    return new ChainConfig()
      .setChainId(chainId())
      .setTypeEnum(chainConfigType)
      .setValue(chainConfigType.defaultValue());
  }

  @Override
  public Timestamp segmentBeginAt() {
    return segment.getBeginAt();
  }

  @Override
  @Nullable
  public Segment previousSegment() throws Exception {
    if (isInitialSegment()) return null;

    return segmentByOffset(chainId(), Value.inc(segment.getOffset(), -1));
  }

  @Override
  @Nullable
  public Collection<SegmentMeme> previousSegmentMemes() throws Exception {
    if (isInitialSegment()) return null;

    Segment previousSegment = previousSegment();
    if (Objects.isNull(previousSegment)) return Lists.newArrayList();

    return segmentMemes(previousSegment.getId());
  }

  @Override
  @Nullable
  public Choice previousMacroChoice() throws Exception {
    return previousChoice(SequenceType.Macro);
  }

  @Override
  @Nullable
  public Choice previousMainChoice() throws Exception {
    return previousChoice(SequenceType.Main);
  }

  @Override
  @Nullable
  public Choice previousRhythmSelection() throws Exception {
    return previousChoice(SequenceType.Rhythm);
  }

  @Override
  public Collection<Arrangement> previousPercussiveArrangements() throws Exception {
    Choice previous = previousRhythmSelection();
    if (Objects.isNull(previous)) return Lists.newArrayList();
    return choiceArrangements(previous.getId());
  }

  @Override
  public Choice currentMacroChoice() throws Exception {
    return segmentChoiceByType(segment().getId(), SequenceType.Macro);
  }

  @Override
  public Choice currentMainChoice() throws Exception {
    return segmentChoiceByType(segment().getId(), SequenceType.Main);
  }

  @Override
  public Choice currentRhythmChoice() throws Exception {
    return segmentChoiceByType(segment().getId(), SequenceType.Rhythm);
  }

  @Override
  public Pattern currentMacroPattern() throws Exception {
    return ingest().patternAtOffset(
      currentMacroChoice().getSequenceId(),
      currentMacroChoice().getSequencePatternOffset(),
      PatternType.Macro);
  }

  @Override
  @Nullable
  public Pattern previousMacroNextPattern() throws Exception {
    Choice previousChoice = previousMacroChoice();
    if (Objects.isNull(previousChoice)) return null;
    return ingest().patternAtOffset(
      previousChoice.getSequenceId(),
      previousChoice.nextPatternOffset(),
      PatternType.Macro);
  }

  @Override
  public Map<ChainConfigType, ChainConfig> chainConfigs() throws Exception {
    if (_chainConfigs.isEmpty()) {
      chainConfigDAO.readAll(Access.internal(), ImmutableList.of(chainId()))
        .forEach(record -> _chainConfigs.put(
          record.getType(),
          record));
    }

    return Collections.unmodifiableMap(_chainConfigs);
  }

  @Override
  public Collection<Arrangement> choiceArrangements(BigInteger choiceId) throws Exception {
    if (!_choiceArrangements.containsKey(choiceId)) {
      _choiceArrangements.put(choiceId, arrangementDAO.readAll(Access.internal(), ImmutableList.of(choiceId)));
    }

    return Collections.unmodifiableCollection(_choiceArrangements.get(choiceId));
  }

  @Override
  public void setChoiceArrangements(BigInteger choiceId, Collection<Arrangement> arrangements) {
    _choiceArrangements.put(choiceId, arrangements);
  }

  @Override
  public Chord chordAt(int position) {
    // default to returning a chord based on the segment key, if nothing else is found
    String foundChordText = segment().getKey();
    Double foundPosition = null;

    // we assume that these entities are in order of position ascending (see: SegmentChordDAO.readAllExpectedWork)
    for (SegmentChord segmentChord : segmentChords()) {
      // if it's a better match (or no match has yet been found) then use it
      if (Objects.isNull(foundPosition) ||
        segmentChord.getPosition() > foundPosition && segmentChord.getPosition() < position) {
        foundPosition = segmentChord.getPosition();
        foundChordText = segmentChord.getName();
      }
    }

    return Chord.of(foundChordText);
  }

  @Override
  public Double pitch(Note note) {
    return tuning.pitch(note);
  }

  @Override
  public Note note(Double pitch) {
    return tuning.note(pitch);
  }

  @Override
  public Double secondsAtPosition(double p) throws Exception {
    if (!_positionSeconds.containsKey(p))
      _positionSeconds.put(p, computeIntegralSecondsAtPosition(p));

    return _positionSeconds.get(p);
  }

  @Override
  public Collection<SegmentMeme> segmentMemes(BigInteger segmentId) throws Exception {
    if (!_segmentMemes.containsKey(segmentId))
      _segmentMemes.put(segmentId, segmentMemeDAO.readAll(Access.internal(), ImmutableList.of(segmentId)));

    return _segmentMemes.get(segmentId);
  }

  @Override
  public Collection<Choice> choices(BigInteger segmentId) {
    if (!_choices.containsKey(segmentId)) {
      try {
        _choices.put(segmentId, choiceDAO.readAll(Access.internal(), ImmutableList.of(segmentId)));
      } catch (Exception e) {
        _choices.put(segmentId, Lists.newArrayList());
        log.warn("[segId={}] fetching choices", segmentId, e);
      }
    }

    return _choices.get(segmentId);
  }

  @Override
  public Collection<Arrangement> arrangements(BigInteger choiceId) {
    if (!_arrangements.containsKey(choiceId)) {
      try {
        _arrangements.put(choiceId, arrangementDAO.readAll(Access.internal(), ImmutableList.of(choiceId)));
      } catch (Exception e) {
        _arrangements.put(choiceId, Lists.newArrayList());
        log.warn("[segId={}] fetching arrangements", choiceId, e);
      }
    }

    return _arrangements.get(choiceId);
  }

  @Override
  public Audio segmentAudio(BigInteger audioId) throws Exception {
    if (segmentAudios().containsKey(audioId))
      return segmentAudios().get(audioId);

    throw new BusinessException(String.format("[segId=%s] Audio #%s is not in picks!", segment.getId(), audioId.toString()));
  }

  @Override
  public Map<BigInteger, Audio> segmentAudios() throws Exception {
    if (_audiosFromPicks.isEmpty()) {
      for (Pick pick : _picks) {
        _audiosFromPicks.put(pick.getAudioId(), ingest().audio(pick.getAudioId()));
      }
    }

    return Collections.unmodifiableMap(_audiosFromPicks);
  }

  @Override
  public Collection<BigInteger> segmentAudioIds() throws Exception {
    return ImmutableList.copyOf(segmentAudios().keySet());
  }

  @Override
  public Collection<SegmentChord> segmentChords() {
    return Collections.unmodifiableCollection(_currentSegmentChords);
  }

  @Override
  public Collection<SegmentMeme> segmentMemes() {
    return Collections.unmodifiableCollection(_currentSegmentMemes);
  }

  @Override
  public void setSegmentMemes(Collection<SegmentMeme> memes) {
    _currentSegmentMemes.clear();
    _currentSegmentMemes.addAll(memes);
  }

  @Override
  public void pick(Pick pick) {
    _picks.add(pick);
  }

  @Override
  public Collection<Pick> picks() {
    return Collections.unmodifiableList(_picks);
  }

  @Override
  public Duration segmentTotalLength() throws Exception {
    if (Objects.isNull(segment().getEndAt()))
      throw new BusinessException(String.format("[segId=%s] Cannot compute total length of segment with no end!", segment.getId()));

    return Duration.ofMillis(segment().getEndAt().getTime() - segment().getBeginAt().getTime());
  }

  @Override
  public Segment segmentByOffset(BigInteger chainId, BigInteger offset) throws Exception {
    if (!_segmentsByOffset.containsKey(chainId))
      _segmentsByOffset.put(chainId, Maps.newConcurrentMap());

    if (!_segmentsByOffset.get(chainId).containsKey(offset)) {
      Segment seg = segmentDAO.readOneAtChainOffset(Access.internal(), chainId, offset);
      if (Objects.nonNull(seg)) _segmentsByOffset.get(chainId).put(offset, seg);
    }

    return _segmentsByOffset.get(chainId).getOrDefault(offset, null);
  }

  @Override
  public Choice segmentChoiceByType(BigInteger segmentId, SequenceType sequenceType) throws Exception {
    if (!_segmentChoicesByType.containsKey(segmentId))
      _segmentChoicesByType.put(segmentId, Maps.newConcurrentMap());

    if (!_segmentChoicesByType.get(segmentId).containsKey(sequenceType)) {
      Choice choice = choiceDAO.readOneSegmentTypeWithAvailablePatternOffsets(Access.internal(), segmentId, sequenceType);
      if (Objects.nonNull(choice)) _segmentChoicesByType.get(segmentId).put(sequenceType, choice);
    }

    return _segmentChoicesByType.get(segmentId).getOrDefault(sequenceType, null);
  }

  @Override
  public void updateSegment(Segment segment) throws Exception {
    this.segment = segment;
    updateSegment();
  }

  @Override
  public void updateSegment() throws Exception {
    segment.setBasis(toJSONObject());
    segmentDAO.update(Access.internal(), segment.getId(), segment);
    switch (type) {
      case Continue:
        // transitions only once, from empty to non-empty
        if (_previousSegmentsWithThisMainSequence.isEmpty()) {
          _previousSegmentsWithThisMainSequence.addAll(readAllPreviousSegmentsWithThisMainSequence());
          log.info("[segId={}] continues main sequence of previous segments: {}",
            segment.getId(),
            CSV.fromIdsOf(_previousSegmentsWithThisMainSequence));
        }
        break;
      case Initial:
      case NextMain:
      case NextMacro:
        break;
    }
  }

  @Override
  public JSONObject toJSONObject() {
    JSONObject out = new JSONObject();

    // Add report
    out.put(JSON_ATTR_REPORT, _report);

    // Add all choices
    _currentChoices.forEach(choice ->
      JSON.putInSubArray(out, JSON_ATTR_CHOICES, JSON.objectFrom(choice)));

    // Add all arrangements
    _currentArrangements.forEach(arrangement ->
      JSON.putInSubArray(out, JSON_ATTR_ARRANGEMENTS, JSON.objectFrom(arrangement)));

    // Add all segmentMemes
    _currentSegmentMemes.forEach(segmentMeme ->
      JSON.putInSubArray(out, JSON_ATTR_SEGMENT_MEMES, JSON.objectFrom(segmentMeme)));

    // Add all segmentChords
    _currentSegmentChords.forEach(segmentChord ->
      JSON.putInSubArray(out, JSON_ATTR_SEGMENT_CHORDS, JSON.objectFrom(segmentChord)));

    // Add all picks
    _picks.forEach(pick ->
      JSON.putInSubArray(out, JSON_ATTR_PICKS, JSON.objectFrom(pick)));

    // Add all Chain Configs
    _chainConfigs.forEach((configType, config) ->
      JSON.putInSubObject(out, JSON_ATTR_CHAIN_CONFIGS, configType.toString(), JSON.objectFrom(config)));

    // Basis metadata
    out.put(JSON_ATTR_TYPE, type.toString());

    return out;
  }

  @Override
  public void report(String key, String value) {
    _report.put(key, value);
  }

  @Override
  public Long atMicros(Double seconds) {
    return (long) (seconds * MICROSECONDS_PER_SECOND);
  }

  @Override
  public MemeIsometry previousMacroNextPatternMemeIsometry() throws Exception {
    if (Objects.isNull(_previousMacroMemeIsometry)) {
      Choice previousChoice = previousMacroChoice();
      if (Objects.nonNull(previousChoice)) {
        BigInteger previousSequenceId = Objects.nonNull(previousMacroChoice()) ? previousChoice.getSequenceId() : null;
        _previousMacroMemeIsometry = MemeIsometry.ofMemes(ingest().sequenceAndPatternMemes(
          previousSequenceId,
          Value.inc(previousChoice.getSequencePatternOffset(), 1),
          PatternType.Macro));
      } else {
        _previousMacroMemeIsometry = new MemeIsometry();
      }
    }

    return _previousMacroMemeIsometry;
  }

  @Override
  public MemeIsometry currentMacroMemeIsometry() throws Exception {
    if (Objects.isNull(_currentMacroMemeIsometry)) {
      _currentMacroMemeIsometry = MemeIsometry.ofMemes(ingest().sequenceAndPatternMemes(
        currentMacroChoice().getSequenceId(),
        currentMacroChoice().getSequencePatternOffset(),
        PatternType.Macro));
    }

    return _currentMacroMemeIsometry;
  }

  @Override
  public MemeIsometry currentSegmentMemeIsometry() {
    if (Objects.isNull(_currentSegmentMemeIsometry)) {
      _currentSegmentMemeIsometry = MemeIsometry.ofMemes(segmentMemes());
    }

    return _currentSegmentMemeIsometry;
  }

  @Override
  public Choice create(Choice choice) throws Exception {
    Choice result = choiceDAO.create(Access.internal(), choice);
    if (Objects.nonNull(result)) {
      _currentChoices.add(result);
    }
    return result;
  }

  @Override
  public Arrangement create(Arrangement arrangement) throws Exception {
    Arrangement result = arrangementDAO.create(Access.internal(), arrangement);
    if (Objects.nonNull(result)) {
      _currentArrangements.add(result);
    }
    return result;
  }

  @Override
  public SegmentMeme create(SegmentMeme segmentMeme) throws Exception {
    SegmentMeme result = segmentMemeDAO.create(Access.internal(), segmentMeme);
    if (Objects.nonNull(result)) {
      _currentSegmentMemes.add(result);
    }
    return result;
  }

  @Override
  public SegmentChord create(SegmentChord segmentChord) throws Exception {
    SegmentChord result = segmentChordDAO.create(Access.internal(), segmentChord);
    if (Objects.nonNull(result)) {
      _currentSegmentChords.add(result);
    }
    return result;
  }

  @Override
  public Collection<Segment> previousSegmentsWithSameMainSequence() {
    return Collections.unmodifiableCollection(_previousSegmentsWithThisMainSequence);
  }

  @Override
  public Sequence sequence(BigInteger id) throws Exception {
    if (!_sequencesById.containsKey(id)) {
      Sequence sequence = sequenceDAO.readOne(Access.internal(), id);
      if (Objects.nonNull(sequence)) _sequencesById.put(id, sequence);
    }

    return _sequencesById.getOrDefault(id, null);
  }

  @Override
  public Map<String, Collection<Pick>> previousSegmentMemeConstellationPicks() throws Exception {
    Map<String, Collection<Pick>> out = Maps.newConcurrentMap();
    for (Segment seg : previousSegmentsWithSameMainSequence()) {
      Isometry iso = MemeIsometry.ofMemes(segmentMemes(seg.getId()));
      String con = iso.getConstellation();
      out.put(con, picks(seg.getBasis()));
    }
    return out;
  }

  @Override
  public Map<String, Collection<Choice>> previousSegmentMemeConstellationChoices() throws Exception {
    Map<String, Collection<Choice>> out = Maps.newConcurrentMap();
    for (Segment seg : previousSegmentsWithSameMainSequence()) {
      Isometry iso = MemeIsometry.ofMemes(segmentMemes(seg.getId()));
      String con = iso.getConstellation();
      out.put(con, choices(seg.getId()));
    }
    return out;
  }

  @Override
  public Map<String, Collection<Arrangement>> previousSegmentMemeConstellationArrangements() throws Exception {
    Map<String, Collection<Arrangement>> out = Maps.newConcurrentMap();
    previousSegmentMemeConstellationChoices().forEach((constellation, choices) -> {
      out.put(constellation, Lists.newArrayList());
      choices.forEach(choice -> arrangements(choice.getId()).forEach(arrangement -> out.get(constellation).add(arrangement)));
    });
    return out;
  }

  @Override
  public Double elapsedSeconds() {
    return (System.nanoTime() - startTime) / NANOS_PER_SECOND;
  }

  /**
   Compute which type of basis this will be

   @return basis type
   */
  private BasisType computeType() {
    if (isInitialSegment()) {
      return BasisType.Initial;
    }

    // previous main choice having at least one more pattern?
    Choice previousMain;
    try {
      previousMain = previousMainChoice();
    } catch (Exception e) {
      log.warn("[segId={}] Reading previous main choice", segment.getId(), e);
      return BasisType.Initial;
    }
    if (Objects.nonNull(previousMain) && previousMain.hasOneMorePattern()) {
      return BasisType.Continue;
    }

    // previous macro choice having at least two more patterns?
    Choice previousMacro;
    try {
      previousMacro = previousMacroChoice();
    } catch (Exception e) {
      log.warn("[segId={}] Reading previous macro choice", segment.getId(), e);
      return BasisType.Initial;
    }
    if (Objects.nonNull(previousMacro) && previousMacro.hasTwoMorePatterns()) {
      return BasisType.NextMain;
    }

    return BasisType.NextMacro;
  }

  @Override
  public Ingest ingest() throws Exception {
    if (Objects.isNull(_ingest))
      _ingest = ingestProvider.evaluate(Access.internal(), entitiesBoundToChain());

    return _ingest;
  }

  @Override
  public Ingest libraryIngest() throws Exception {
    if (Objects.isNull(_libraryIngest))
      _libraryIngest = ingestProvider.evaluate(Access.internal(), entitiesBoundToChainOrInferred());

    return _libraryIngest;
  }

  /**
   Extract the picks from a JSONObject of a segment basis

   @param basisJSON to extract picks from
   @return picks from JSON
   <p>
   TODO confirm this is not too high
   */
  private Collection<Pick> picks(JSONObject basisJSON) {
    Collection<Pick> out = Lists.newArrayList();
    if (basisJSON.has(JSON_ATTR_PICKS)) {
      JSONArray picksJSON = basisJSON.getJSONArray(JSON_ATTR_PICKS);
      picksJSON.forEach(pick -> out.add(gson.fromJson(pick.toString(), Pick.class)));
    }
    return out;
  }

  /**
   Read all previous segments with the same main sequence as this one

   @return collection of segments
   */
  private Collection<Segment> readAllPreviousSegmentsWithThisMainSequence() {
    try {
      Choice mainChoice = currentMainChoice();
      if (Objects.isNull(mainChoice)) {
        return Lists.newArrayList();
      }

      BigInteger sequencePatternOffset = mainChoice.getSequencePatternOffset();
      if (0 < sequencePatternOffset.compareTo(BigInteger.ZERO)) {
        BigInteger oF = segment().getOffset().subtract(sequencePatternOffset);
        BigInteger oT = segment().getOffset().subtract(BigInteger.ONE);
        return segmentDAO.readAllFromToOffset(Access.internal(), chainId(), oF, oT);

      } else {
        return Lists.newArrayList();
      }
    } catch (Exception e) {

      return Lists.newArrayList();
    }
  }

  /**
   Get all entities bound to chain.

   @return collection of all entities bound to chain
   */
  private Collection<Entity> entitiesBoundToChain() throws Exception {
    Collection<Entity> out = Lists.newArrayList();
    out.addAll(librariesBoundToChain());
    out.addAll(sequencesBoundToChain());
    out.addAll(instrumentsBoundToChain());
    return out;
  }

  /**
   Get all libraries bound to chain.
   CACHES results.

   @return libraries bound to chain.
   */
  private Collection<Library> librariesBoundToChain() throws Exception {
    ImmutableList.Builder<Library> builder = ImmutableList.builder();
    chainLibraries().forEach(chainLibrary -> builder.add(new Library(chainLibrary.getLibraryId())));
    return builder.build();
  }

  /**
   Get ChainLibrary bindings for the current chain

   @return collection of ChainLibrary
   */
  private Collection<ChainLibrary> chainLibraries() throws Exception {
    return chainLibraryDAO.readAll(Access.internal(), ImmutableList.of(chainId()));
  }

  /**
   Get all sequences bound to chain.
   CACHES results.

   @return sequences bound to chain.
   */
  private Collection<Sequence> sequencesBoundToChain() throws Exception {
    ImmutableList.Builder<Sequence> builder = ImmutableList.builder();
    chainSequences().forEach(chainSequence -> builder.add(new Sequence(chainSequence.getSequenceId())));
    return builder.build();
  }

  /**
   Get ChainSequence bindings for the current chain

   @return collection of ChainSequence
   */
  private Collection<ChainSequence> chainSequences() throws Exception {
    return chainSequenceDAO.readAll(Access.internal(), ImmutableList.of(chainId()));
  }

  /**
   Get all instruments bound to chain.
   CACHES results.

   @return instruments bound to chain.
   */
  private Collection<Instrument> instrumentsBoundToChain() throws Exception {
    ImmutableList.Builder<Instrument> builder = ImmutableList.builder();
    chainInstruments().forEach(chainInstrument -> builder.add(new Instrument(chainInstrument.getInstrumentId())));
    return builder.build();
  }

  /**
   Get ChainInstrument bindings for the current chain

   @return collection of ChainInstrument
   */
  private Collection<ChainInstrument> chainInstruments() throws Exception {
    return chainInstrumentDAO.readAll(Access.internal(), ImmutableList.of(chainId()));
  }

  /**
   Get all entities bound to chain.
   NOT cached, because we assume that this information will only need to be used once, in order to compute an Ingest, which is cached.

   @return collection of all entities bound to chain
   */
  private Collection<Entity> entitiesBoundToChainOrInferred() throws Exception {
    Map<BigInteger, Entity> result = Maps.newConcurrentMap();
    librariesBoundToChain().forEach(library -> result.put(library.getId(), library));
    sequencesBoundToChain().forEach(sequence -> result.put(sequence.getLibraryId(), new Library(sequence.getLibraryId())));
    instrumentsBoundToChain().forEach(instrument -> result.put(instrument.getLibraryId(), new Library(instrument.getLibraryId())));
    return result.values();
  }

  /**
   Compute using an integral
   the seconds from start for any given position in beats
   <p>
   [#153542275] Segment wherein tempo changes expect perfectly smooth sound from previous segment through to following segment

   @param B position in beats
   @return seconds from start
   */
  private Double computeIntegralSecondsAtPosition(double B) throws Exception {
    double sum = 0.0d;
    Double x = 0.0d;
    Double dx = COMPUTE_INTEGRAL_DX;

    double T = segment().getTotal().doubleValue();
    double v2 = BPM.velocity(segment().getTempo()); // velocity at current segment tempo
    Segment previous = previousSegment();
    double v1 = Objects.nonNull(previous) ?
      BPM.velocity(previous.getTempo()) : // velocity at previous segment tempo
      v2; // no previous segment

    while (x < B) {
      sum += Math.min(dx, B - x) * // increment by dx, unless in the last (less than B-x) segment
        (v1 + (v2 - v1) * x / T);
      x += dx;
    }
    return sum;
  }

  /**
   real output channels based on chain configs

   @return output channels
   */
  private int outputChannels() throws Exception {
    return Integer.parseInt(chainConfig(ChainConfigType.OutputChannels).getValue());
  }

  /**
   real output sample bits based on chain configs

   @return output sample bits
   */
  private int outputSampleBits() throws Exception {
    return Integer.parseInt(chainConfig(ChainConfigType.OutputSampleBits).getValue());
  }

  /**
   fetch the specified type choice for the previous segment in the chain

   @param type to fetch
   @return specified type segment choice
   @throws Exception on failure
   */
  private Choice previousChoice(SequenceType type) throws Exception {
    if (isInitialSegment()) return null;
    Segment previous = previousSegment();
    if (Objects.isNull(previous)) return null;
    return segmentChoiceByType(previous.getId(), type);
  }

  /**
   real output frame rate based on chain configs

   @return output frame rate, per second
   */
  private float outputFrameRate() throws Exception {
    return Integer.parseInt(chainConfig(ChainConfigType.OutputFrameRate).getValue());
  }

  /**
   output encoding based on chain configs

   @return output encoding
   */
  private AudioFormat.Encoding outputEncoding() throws Exception {
    return new AudioFormat.Encoding(chainConfig(ChainConfigType.OutputEncoding).getValue());
  }

}
