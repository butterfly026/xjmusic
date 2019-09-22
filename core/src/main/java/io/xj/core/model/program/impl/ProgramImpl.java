//  Copyright (c) 2019, XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.core.model.program.impl;

import com.google.common.collect.ImmutableList;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.google.inject.assistedinject.Assisted;
import com.google.inject.assistedinject.AssistedInject;
import io.xj.core.exception.CoreException;
import io.xj.core.isometry.SubEntityRank;
import io.xj.core.model.entity.MemeEntity;
import io.xj.core.model.entity.SubEntity;
import io.xj.core.model.entity.impl.SuperEntityImpl;
import io.xj.core.model.library.Library;
import io.xj.core.model.payload.Payload;
import io.xj.core.model.program.PatternType;
import io.xj.core.model.program.Program;
import io.xj.core.model.program.ProgramState;
import io.xj.core.model.program.ProgramType;
import io.xj.core.model.program.sub.Event;
import io.xj.core.model.program.sub.Pattern;
import io.xj.core.model.program.sub.ProgramMeme;
import io.xj.core.model.program.sub.Sequence;
import io.xj.core.model.program.sub.SequenceBinding;
import io.xj.core.model.program.sub.SequenceBindingMeme;
import io.xj.core.model.program.sub.SequenceChord;
import io.xj.core.model.program.sub.Track;
import io.xj.core.model.program.sub.Voice;
import io.xj.core.model.user.User;
import io.xj.core.transport.GsonProvider;
import io.xj.core.util.Chance;

import java.math.BigInteger;
import java.time.Instant;
import java.util.Collection;
import java.util.Map;
import java.util.Objects;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;

/**
 [#166132897] Program model handles all of its own entities
 [#166273140] Program Child Entities are identified and related by UUID (not id)
 */
public class ProgramImpl extends SuperEntityImpl implements Program {
  private final GsonProvider gsonProvider;
  private final Map<UUID, Pattern> patternMap = Maps.newHashMap();
  private final Map<UUID, Track> trackMap = Maps.newHashMap();
  private final Map<UUID, SequenceBinding> sequenceBindingMap = Maps.newHashMap();
  private final Map<UUID, SequenceBindingMeme> sequenceBindingMemeMap = Maps.newHashMap();
  private final Map<UUID, SequenceChord> sequenceChordMap = Maps.newHashMap();
  private final Map<UUID, Sequence> sequenceMap = Maps.newHashMap();
  private final Map<UUID, Event> eventMap = Maps.newHashMap();
  private final Map<UUID, ProgramMeme> memeMap = Maps.newHashMap();
  private final Map<UUID, Voice> voiceMap = Maps.newHashMap();
  private BigInteger userId;
  private BigInteger libraryId;
  private ProgramState state;
  private String key;
  private Double tempo;
  private ProgramType type;
  private String name;
  private Exception stateException;
  private Exception typeException;

  /**
   Constructor with Program id
   */
  @AssistedInject
  public ProgramImpl(
    @Assisted("id") BigInteger id,
    GsonProvider gsonProvider
  ) {
    this.id = id;
    this.gsonProvider = gsonProvider;
  }

  /**
   Constructor with no id
   */
  @AssistedInject
  public ProgramImpl(
    GsonProvider gsonProvider
  ) {
    this.gsonProvider = gsonProvider;
  }

  @Override
  public Pattern add(Pattern pattern) {
    try {
      requireId("before adding Pattern");
      pattern.setProgramId(getId());
      ensureRelations(pattern);
      return SubEntity.add(patternMap, pattern);
    } catch (CoreException e) {
      add(e);
      return pattern;
    }
  }

  @Override
  public Track add(Track track) {
    try {
      requireId("before adding Track");
      track.setProgramId(getId());
      ensureRelations(track);
      return SubEntity.add(trackMap, track);
    } catch (CoreException e) {
      add(e);
      return track;
    }
  }

  @Override
  public Event add(Event event) {
    try {
      requireId("before adding Event");
      event.setProgramId(getId());
      ensureRelations(event);
      return SubEntity.add(eventMap, event);
    } catch (CoreException e) {
      add(e);
      return event;
    }
  }

  @Override
  public ProgramMeme add(ProgramMeme meme) {
    try {
      requireId("before adding ProgramMeme");
      meme.setProgramId(getId());
      return SubEntity.add(memeMap, meme);
    } catch (CoreException e) {
      add(e);
      return meme;
    }
  }

  @Override
  public Sequence add(Sequence sequence) {
    try {
      requireId("before adding Sequence");
      sequence.setProgramId(getId());
      return SubEntity.add(sequenceMap, sequence);
    } catch (CoreException e) {
      add(e);
      return sequence;
    }
  }

  @Override
  public SequenceBinding add(SequenceBinding sequenceBinding) {
    try {
      requireId("before adding SequenceBinding");
      sequenceBinding.setProgramId(getId());
      ensureRelations(sequenceBinding);
      return SubEntity.add(sequenceBindingMap, sequenceBinding);
    } catch (CoreException e) {
      add(e);
      return sequenceBinding;
    }
  }

  @Override
  public SequenceBindingMeme add(SequenceBindingMeme sequenceBindingMeme) {
    try {
      requireId("before adding SequenceBindingMeme");
      sequenceBindingMeme.setProgramId(getId());
      ensureRelations(sequenceBindingMeme);
      return SubEntity.add(sequenceBindingMemeMap, sequenceBindingMeme);
    } catch (CoreException e) {
      add(e);
      return sequenceBindingMeme;
    }
  }

  @Override
  public SequenceChord add(SequenceChord sequenceChord) {
    try {
      requireId("before adding SequenceChord");
      sequenceChord.setProgramId(getId());
      ensureRelations(sequenceChord);
      return SubEntity.add(sequenceChordMap, sequenceChord);
    } catch (CoreException e) {
      add(e);
      return sequenceChord;
    }
  }

  @Override
  public Voice add(Voice voice) {
    try {
      requireId("before adding Voice");
      voice.setProgramId(getId());
      return SubEntity.add(voiceMap, voice);
    } catch (CoreException e) {
      add(e);
      return voice;
    }
  }

  @Override
  public Program consume(Payload payload) throws CoreException {
    super.consume(payload);
    syncSubEntities(payload, memeMap, ProgramMeme.class);
    syncSubEntities(payload, voiceMap, Voice.class);
    syncSubEntities(payload, sequenceMap, Sequence.class);
    syncSubEntities(payload, sequenceChordMap, SequenceChord.class); // requires Sequence
    syncSubEntities(payload, sequenceBindingMap, SequenceBinding.class); // requires Sequence
    syncSubEntities(payload, sequenceBindingMemeMap, SequenceBindingMeme.class); // requires SequenceBinding
    syncSubEntities(payload, patternMap, Pattern.class); // requires Sequence, Voice
    syncSubEntities(payload, trackMap, Track.class); // requires Sequence, Voice
    syncSubEntities(payload, eventMap, Event.class); // requires Pattern
    return this;
  }

  @Override
  public Collection<SubEntity> getAllSubEntities() {
    Collection<SubEntity> out = Lists.newArrayList();
    out.addAll(getMemes());
    out.addAll(getEvents());
    out.addAll(getPatterns());
    out.addAll(getTracks());
    out.addAll(getSequenceBindingMemes());
    out.addAll(getSequenceBindings());
    out.addAll(getSequenceChords());
    out.addAll(getSequences());
    out.addAll(getVoices());
    return out;
  }

  @Override
  public Collection<Long> getAvailableOffsets(SequenceBinding sequenceBinding) {
    return getSequenceBindings().stream()
      .map(SequenceBinding::getOffset)
      .distinct()
      .collect(Collectors.toList());
  }

  @Override
  public Collection<SequenceChord> getChords(Sequence sequence) {
    return getChordsOfSequence(sequence.getId());
  }

  @Override
  public Collection<SequenceChord> getChordsOfSequence(UUID sequenceId) {
    return getSequenceChords().stream()
      .filter(chord -> chord.getSequenceId().equals(sequenceId))
      .collect(Collectors.toList());
  }

  @Override
  public ProgramContent getContent() {
    return ProgramContent.of(this);
  }

  @Override
  public Double getDensity() {
    double DT = 0;
    double T = 0;
    for (Sequence sequence : getSequences()) {
      DT += sequence.getDensity() * sequence.getTotal();
      T += sequence.getTotal();
    }
    return 0 < T ? DT / T : 0;
  }

  @Override
  public Collection<Event> getEventsForPattern(Pattern pattern) {
    return getEvents().stream()
      .filter(event -> pattern.getId().equals(event.getPatternId()))
      .collect(Collectors.toList());
  }

  @Override
  public String getKey() {
    return key;
  }

  @Override
  public BigInteger getLibraryId() {
    return libraryId;
  }

  @Override
  public Collection<ProgramMeme> getMemes() {
    return memeMap.values();
  }

  @Override
  public Collection<SequenceBindingMeme> getMemes(SequenceBinding sequenceBinding) {
    return getSequenceBindingMemes().stream()
      .filter(meme -> meme.getSequenceBindingId().equals(sequenceBinding.getId()))
      .collect(Collectors.toList());
  }

  @Override
  public Collection<MemeEntity> getMemesAtBeginning() {
    Map<String, MemeEntity> memes = Maps.newHashMap();

    // add sequence memes
    getMemes().forEach((meme ->
      memes.put(meme.getName(), meme)));

    // add sequence binding memes
    getSequenceBindingsAtOffset(0L).forEach(sequenceBinding ->
      getMemes(sequenceBinding).forEach(meme ->
        memes.put(meme.getName(), meme)));

    return memes.values();
  }

  @Override
  public String getName() {
    return name;
  }

  @Override
  public BigInteger getParentId() {
    return libraryId;
  }

  @Override
  public Pattern getPattern(UUID id) throws CoreException {
    if (!patternMap.containsKey(id))
      throw new CoreException(String.format("Found no Pattern id=%s", id));
    return patternMap.get(id);
  }

  @Override
  public Collection<Event> getEvents() {
    return eventMap.values();
  }

  @Override
  public Collection<Pattern> getPatterns() {
    return patternMap.values();
  }

  @Override
  public Track getTrack(UUID id) throws CoreException {
    if (!trackMap.containsKey(id))
      throw new CoreException(String.format("Found no Track id=%s", id));
    return trackMap.get(id);
  }

  @Override
  public Collection<Track> getTracks() {
    return trackMap.values();
  }

  @Override
  public ImmutableList<String> getResourceAttributeNames() {
    return ImmutableList.<String>builder()
      .addAll(super.getResourceAttributeNames())
      .add("state")
      .add("type")
      .add("name")
      .add("key")
      .add("tempo")
      .add("density")
      .build();
  }

  @Override
  public ImmutableList<Class> getResourceBelongsTo() {
    return ImmutableList.<Class>builder()
      .addAll(super.getResourceBelongsTo())
      .add(User.class)
      .add(Library.class)
      .build();
  }

  @Override
  public ImmutableList<Class> getResourceHasMany() {
    return ImmutableList.<Class>builder()
      .addAll(super.getResourceHasMany())
      .add(ProgramMeme.class)
      .add(Sequence.class)
      .add(SequenceChord.class)
      .add(Pattern.class)
      .add(Track.class)
      .add(Event.class)
      .add(SequenceBinding.class)
      .add(SequenceBindingMeme.class)
      .add(Voice.class)
      .build();
  }

  @Override
  public Sequence getSequence(UUID id) throws CoreException {
    if (!sequenceMap.containsKey(id))
      throw new CoreException(String.format("Found no Sequence id=%s", id));
    return sequenceMap.get(id);
  }

  @Override
  public Collection<SequenceBindingMeme> getSequenceBindingMemes() {
    return sequenceBindingMemeMap.values();
  }

  @Override
  public Collection<SequenceBinding> getSequenceBindings() {
    return sequenceBindingMap.values();
  }

  @Override
  public Collection<SequenceBinding> getSequenceBindingsAtOffset(Long offset) {
    return getSequenceBindings().stream()
      .filter(binding -> binding.getOffset().equals(offset))
      .collect(Collectors.toList());
  }

  @Override
  public Collection<SequenceChord> getSequenceChords() {
    return sequenceChordMap.values();
  }

  @Override
  public Collection<Sequence> getSequences() {
    return sequenceMap.values();
  }

  @Override
  public ProgramState getState() {
    return state;
  }

  @Override
  public Double getTempo() {
    return tempo;
  }

  @Override
  public ProgramType getType() {
    return type;
  }

  @Override
  public BigInteger getUserId() {
    return userId;
  }

  @Override
  public Collection<Voice> getVoices() {
    return voiceMap.values();
  }

  @Override
  public SequenceBinding randomlySelectSequenceBindingAtOffset(Long offset) throws CoreException {
    SubEntityRank<SequenceBinding> superEntityRank = new SubEntityRank<>();
    for (SequenceBinding sequenceBinding : getSequenceBindingsAtOffset(offset)) {
      superEntityRank.add(sequenceBinding, Chance.normallyAround(0.0, 1.0));
    }
    return superEntityRank.getTop();
  }

  @Override
  public Optional<Pattern> randomlySelectPatternOfSequenceByVoiceAndType(Sequence sequence, Voice voice, PatternType patternType) throws CoreException {
    SubEntityRank<Pattern> superEntityRank = new SubEntityRank<>();
    getPatterns().stream()
      .filter(pattern -> pattern.getSequenceId().equals(sequence.getId()))
      .filter(pattern -> pattern.getVoiceId().equals(voice.getId()))
      .filter(pattern -> pattern.getType() == patternType)
      .forEach(pattern ->
        superEntityRank.add(pattern, Chance.normallyAround(0.0, 1.0)));
    if (Objects.equals(0, superEntityRank.size()))
      return Optional.empty();
    return Optional.of(superEntityRank.getTop());
  }

  @Override
  public Sequence randomlySelectSequence() throws CoreException {
    SubEntityRank<Sequence> superEntityRank = new SubEntityRank<>();
    getSequences().forEach(sequence -> superEntityRank.add(sequence, Chance.normallyAround(0.0, 1.0)));
    return superEntityRank.getTop();
  }

  @Override
  public Program setContent(String json) {
    ProgramContent content = gsonProvider.gson().fromJson(json, ProgramContent.class);
    setMemes(content.getMemes());
    setSequences(content.getSequences());
    setSequenceBindings(content.getSequenceBindings());
    setSequenceBindingMemes(content.getSequenceBindingMemes());
    setSequenceChords(content.getSequenceChords());
    setVoices(content.getVoices());
    setPatterns(content.getPatterns());
    setTracks(content.getTracks());
    setPatternEvents(content.getEvents());
    return this;
  }

  @Override
  public Program setContentCloned(Program from) {
    setMemes(from.getMemes());
    setVoices(from.getVoices());
    setSequences(from.getSequences());
    setPatterns(from.getPatterns()); // after sequences, voices
    setTracks(from.getTracks()); // after sequences, voices
    setSequenceBindings(from.getSequenceBindings()); // after sequences
    setSequenceBindingMemes(from.getSequenceBindingMemes()); // after sequence bindings
    setSequenceChords(from.getSequenceChords()); // after sequences
    setPatternEvents(from.getEvents()); // after patterns
    return this;
  }

  @Override
  public Program setCreatedAt(String createdAt) {
    super.setCreatedAt(createdAt);
    return this;
  }

  @Override
  public Program setCreatedAtInstant(Instant createdAt) {
    super.setCreatedAtInstant(createdAt);
    return this;
  }

  @Override
  public Program setDensity(String density) {
    // no op
    return this;
  }

  @Override
  public Program setKey(String key) {
    this.key = key;
    return this;
  }

  @Override
  public Program setLibraryId(BigInteger libraryId) {
    this.libraryId = libraryId;
    return this;
  }

  @Override
  public Program setMemes(Collection<ProgramMeme> memes) {
    memeMap.clear();
    for (ProgramMeme meme : memes) {
      add(meme);
    }
    return this;
  }

  @Override
  public Program setName(String name) {
    this.name = name;
    return this;
  }

  @Override
  public Program setPatternEvents(Collection<Event> events) {
    eventMap.clear();
    for (Event event : events) {
      add(event);
    }
    return this;
  }

  @Override
  public Program setPatterns(Collection<Pattern> patterns) {
    patternMap.clear();
    for (Pattern pattern : patterns) {
      add(pattern);
    }
    return this;
  }

  @Override
  public Program setTracks(Collection<Track> tracks) {
    trackMap.clear();
    for (Track track : tracks) {
      add(track);
    }
    return this;
  }

  @Override
  public Program setSequenceBindingMemes(Collection<SequenceBindingMeme> sequenceBindingMemes) {
    sequenceBindingMemeMap.clear();
    for (SequenceBindingMeme sequenceBindingMeme : sequenceBindingMemes) {
      add(sequenceBindingMeme);
    }
    return this;
  }

  @Override
  public Program setSequenceBindings(Collection<SequenceBinding> sequenceBindings) {
    sequenceBindingMap.clear();
    for (SequenceBinding sequenceBinding : sequenceBindings) {
      add(sequenceBinding);
    }
    return this;
  }

  @Override
  public Program setSequenceChords(Collection<SequenceChord> chords) {
    sequenceChordMap.clear();
    for (SequenceChord chord : chords) {
      add(chord);
    }
    return this;
  }

  @Override
  public Program setSequences(Collection<Sequence> sequences) {
    sequenceMap.clear();
    for (Sequence sequence : sequences) {
      add(sequence);
    }
    return this;
  }

  @Override
  public Program setState(String value) {
    try {
      state = ProgramState.validate(value);
    } catch (CoreException e) {
      stateException = e;
    }
    return this;
  }

  @Override
  public Program setStateEnum(ProgramState value) {
    state = value;
    return this;
  }

  @Override
  public Program setTempo(Double tempo) {
    this.tempo = tempo;
    return this;
  }

  @Override
  public Program setType(String type) {
    try {
      this.type = ProgramType.validate(type);
    } catch (CoreException e) {
      typeException = e;
    }
    return this;
  }

  @Override
  public Program setTypeEnum(ProgramType type) {
    this.type = type;
    return this;
  }

  @Override
  public Program setUpdatedAt(String updatedAt) {
    super.setUpdatedAt(updatedAt);
    return this;
  }

  @Override
  public Program setUpdatedAtInstant(Instant updatedAt) {
    super.setUpdatedAtInstant(updatedAt);
    return this;
  }

  @Override
  public Program setUserId(BigInteger userId) {
    this.userId = userId;
    return this;
  }

  @Override
  public Program setVoices(Collection<Voice> voices) {
    voiceMap.clear();
    for (Voice voice : voices) {
      add(voice);
    }
    return this;
  }

  @Override
  public Program validate() throws CoreException {
    require(userId, "User ID");
    require(libraryId, "Library ID");
    require(name, "Name");
    require(key, "Key");
    requireNonZero(tempo, "Key");

    requireNo(typeException, "Type");
    require(type, "Type");

    requireNo(stateException, "State");
    require(state, "State");

    return validateContent();
  }

  @Override
  public Program validateContent() throws CoreException {
    SubEntity.validate(this.getAllSubEntities());
    for (Pattern pattern : getPatterns()) ensureRelations(pattern);
    for (Track track : getTracks()) ensureRelations(track);
    for (Event event : getEvents()) ensureRelations(event);
    for (SequenceBinding sequenceBinding : getSequenceBindings()) ensureRelations(sequenceBinding);
    for (SequenceBindingMeme sequenceBindingMeme : getSequenceBindingMemes()) ensureRelations(sequenceBindingMeme);
    for (SequenceChord sequenceChord : getSequenceChords()) ensureRelations(sequenceChord);
    return this;
  }

  /**
   Ensure that an Pattern relates to an existing Sequence stored in the Program

   @param pattern to ensure existing relations of
   @throws CoreException if no such Sequence exists
   */
  private void ensureRelations(Pattern pattern) throws CoreException {
    if (Objects.isNull(pattern.getSequenceId()))
      throw new CoreException(String.format("Pattern id=%s has null sequenceId", pattern.getId()));

    if (!sequenceMap.containsKey(pattern.getSequenceId()))
      throw new CoreException(String.format("Pattern id=%s has nonexistent sequenceId=%s", pattern.getId(), pattern.getSequenceId()));

    if (Objects.isNull(pattern.getVoiceId()))
      throw new CoreException(String.format("Pattern id=%s has null voiceId", pattern.getId()));

    if (!voiceMap.containsKey(pattern.getVoiceId()))
      throw new CoreException(String.format("Pattern id=%s has nonexistent voiceId=%s", pattern.getId(), pattern.getVoiceId()));
  }

  /**
   Ensure that an Track relates to an existing Sequence stored in the Program

   @param track to ensure existing relations of
   @throws CoreException if no such Sequence exists
   */
  private void ensureRelations(Track track) throws CoreException {
    if (Objects.isNull(track.getVoiceId()))
      throw new CoreException(String.format("Track id=%s has null voiceId", track.getId()));

    if (!voiceMap.containsKey(track.getVoiceId()))
      throw new CoreException(String.format("Track id=%s has nonexistent voiceId=%s", track.getId(), track.getVoiceId()));
  }

  /**
   Ensure that an SequenceBinding relates to an existing Sequence stored in the Program

   @param sequenceBinding to ensure existing relations of
   @throws CoreException if no such Sequence exists
   */
  private void ensureRelations(SequenceBinding sequenceBinding) throws CoreException {
    if (Objects.isNull(sequenceBinding.getSequenceId()))
      throw new CoreException(String.format("SequenceBinding id=%s has null sequenceId", sequenceBinding.getId()));

    if (!sequenceMap.containsKey(sequenceBinding.getSequenceId()))
      throw new CoreException(String.format("SequenceBinding id=%s has nonexistent sequenceId=%s", sequenceBinding.getId(), sequenceBinding.getSequenceId()));
  }

  /**
   Ensure that an SequenceChord relates to an existing Sequence stored in the Program

   @param sequenceChord to ensure existing relations of
   @throws CoreException if no such Sequence exists
   */
  private void ensureRelations(SequenceChord sequenceChord) throws CoreException {
    if (Objects.isNull(sequenceChord.getSequenceId()))
      throw new CoreException(String.format("SequenceChord id=%s has null sequenceId", sequenceChord.getId()));

    if (!sequenceMap.containsKey(sequenceChord.getSequenceId()))
      throw new CoreException(String.format("SequenceChord id=%s has nonexistent sequenceId=%s", sequenceChord.getId(), sequenceChord.getSequenceId()));
  }

  /**
   Ensure that an SequenceBindingMeme relates to an existing SequenceBinding stored in the Program

   @param sequenceBindingMeme to ensure existing relations of
   @throws CoreException if no such SequenceBinding exists
   */
  private void ensureRelations(SequenceBindingMeme sequenceBindingMeme) throws CoreException {
    if (Objects.isNull(sequenceBindingMeme.getSequenceBindingId()))
      throw new CoreException(String.format("SequenceBindingMeme id=%s has null sequenceBindingId", sequenceBindingMeme.getId()));

    if (!sequenceBindingMap.containsKey(sequenceBindingMeme.getSequenceBindingId()))
      throw new CoreException(String.format("SequenceBindingMeme id=%s has nonexistent sequenceBindingId=%s", sequenceBindingMeme.getId(), sequenceBindingMeme.getSequenceBindingId()));
  }

  /**
   Ensure that an Event relates to an existing Pattern and Voice stored in the Program

   @param event to ensure existing relations of
   @throws CoreException if no such Pattern exists
   */
  private void ensureRelations(Event event) throws CoreException {
    if (Objects.isNull(event.getPatternId()))
      throw new CoreException(String.format("Event id=%s has null patternId", event.getId()));

    if (!patternMap.containsKey(event.getPatternId()))
      throw new CoreException(String.format("Event id=%s has nonexistent patternId=%s", event.getId(), event.getPatternId()));
  }
}
