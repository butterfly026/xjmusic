// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.

package io.xj.service.nexus.entity;

import com.google.common.collect.ImmutableMap;
import io.xj.lib.entity.Entities;
import io.xj.lib.entity.Entity;
import io.xj.lib.mixer.OutputEncoder;
import io.xj.lib.util.Text;
import io.xj.lib.util.Value;
import io.xj.lib.util.ValueException;

import java.time.Instant;
import java.util.Locale;
import java.util.Objects;
import java.util.UUID;

public class Segment extends Entity {
  private static final String EXTENSION_SEPARATOR = ".";
  private static final String EXTENSION_JSON = "json";
  private UUID chainId;
  private SegmentState state;
  private Instant beginAt;
  private Exception beginAtException;
  private Instant endAt; // optional
  private Exception endAtException;
  private String key;
  private Integer total;
  private Long offset;
  private Double density;
  private Double tempo;
  private String storageKey;
  private Double waveformPreroll;
  private SegmentType type;
  private Exception stateException;
  private ValueException typeException;
  private OutputEncoder outputEncoder;

  /**
   of Segment

   @return new segment
   */
  public static Segment create() {
    return new Segment()
      .setOutputEncoderEnum(OutputEncoder.AAC)
      .setTypeEnum(SegmentType.Pending)
      .setId(UUID.randomUUID())
      .setWaveformPreroll(0.0);
  }

  /**
   Create a new Segment

   @param chain      of Segment
   @param offset     of Segment
   @param state      of Segment
   @param beginAt    of Segment
   @param endAt      of Segment
   @param key        of Segment
   @param total      of Segment
   @param density    of Segment
   @param tempo      of Segment
   @param storageKey of Segment
   @return new Segment
   */
  public static Segment create(Chain chain, long offset, SegmentState state, Instant beginAt, Instant endAt, String key, int total, double density, double tempo, String storageKey) {
    return create()
      .setTypeEnum(SegmentType.Continue)
      .setChainId(chain.getId())
      .setOffset(offset)
      .setState(state.toString())
      .setBeginAtInstant(beginAt)
      .setEndAtInstant(endAt)
      .setTotal(total)
      .setKey(key)
      .setDensity(density)
      .setTempo(tempo)
      .setStorageKey(storageKey);
  }

  /**
   Create a new planned-state segment with no endAt or properties

   @param chain   to create segment in
   @param offset  of segment
   @param beginAt of segment
   @return new segment
   */
  public static Segment create(Chain chain, long offset, Instant beginAt) {
    return create()
      .setStateEnum(SegmentState.Planned)
      .setOffset(offset)
      .setChainId(chain.getId())
      .setBeginAtInstant(beginAt);
  }

  /**
   get BeginAt

   @return BeginAt
   */
  public Instant getBeginAt() {
    return beginAt;
  }

  /**
   get ChainId

   @return ChainId
   */
  public UUID getChainId() {
    return chainId;
  }

  /**
   get Density

   @return Density
   */
  public Double getDensity() {
    return density;
  }

  /**
   get EndAt

   @return EndAt
   */
  public Instant getEndAt() {
    return endAt;
  }

  /**
   get Key

   @return Key
   */
  public String getKey() {
    return key;
  }

  /**
   get Offset

   @return Offset
   */
  public Long getOffset() {
    return offset;
  }

  /**
   get offset of previous segment

   @return previous segment offset
   */
  public Long computePreviousOffset() throws ValueException {
    if (computeIsInitial())
      throw new ValueException("Cannot get previous id create initial Segment!");
    return offset - 1;
  }

  /**
   get State

   @return State
   */
  public SegmentState getState() {
    return state;
  }

  /**
   get Total

   @return Total
   */
  public Integer getTotal() {
    return total;
  }

  /**
   get Tempo

   @return Tempo
   */
  public Double getTempo() {
    return tempo;
  }

  /**
   get Type

   @return Type
   */
  public SegmentType getType() {
    return type;
  }

  /**
   get StorageKey

   @return StorageKey
   */
  public String getStorageKey() {
    return storageKey;
  }

  /**
   get StorageKey

   @return StorageKey
   */
  public OutputEncoder getOutputEncoder() {
    return outputEncoder;
  }

  /**
   get Waveform Preroll (seconds)

   @return Waveform Preroll (seconds)
   */
  public Double getWaveformPreroll() {
    return waveformPreroll;
  }

  /**
   Is initial segment? (offset 0)

   @return true if offset 0
   */
  public boolean computeIsInitial() {
    return 0L == offset;
  }

  /**
   Set the beginAt

   @param beginAt to set
   @return this Segment (for chaining setters)
   */
  public Segment setBeginAt(String beginAt) {
    try {
      this.beginAt = Instant.parse(beginAt);
    } catch (Exception e) {
      beginAtException = e;
    }
    return this;
  }

  /**
   Set the beginAt

   @param beginAt to set
   @return this Segment (for chaining setters)
   */
  public Segment setBeginAtInstant(Instant beginAt) {
    this.beginAt = beginAt;
    return this;
  }

  /**
   Set the chainId

   @param chainId to set
   @return this Segment (for chaining setters)
   */
  public Segment setChainId(UUID chainId) {
    this.chainId = chainId;
    return this;
  }

  @Override
  public Segment setCreatedAt(String createdAt) {
    super.setCreatedAt(createdAt);
    return this;
  }

  @Override
  public Segment setCreatedAtInstant(Instant createdAt) {
    super.setCreatedAtInstant(createdAt);
    return this;
  }

  /**
   Set the id

   @param id to set
   @return this Segment (for chaining setters)
   */
  public Segment setId(UUID id) {
    super.setId(id);
    return this;
  }

  /**
   Set the density

   @param density to set
   @return this Segment (for chaining setters)
   */
  public Segment setDensity(Double density) {
    this.density = density;
    return this;
  }

  /**
   Set the endAt

   @param endAt to set
   @return this Segment (for chaining setters)
   */
  public Segment setEndAt(String endAt) {
    try {
      this.endAt = Instant.parse(endAt);
    } catch (Exception e) {
      endAtException = e;
    }
    return this;
  }

  /**
   Set the endAt

   @param endAt to set
   @return this Segment (for chaining setters)
   */
  public Segment setEndAtInstant(Instant endAt) {
    this.endAt = endAt;
    return this;
  }

  /**
   Set the key

   @param key to set
   @return this Segment (for chaining setters)
   */
  public Segment setKey(String key) {
    this.key = key;
    return this;
  }

  /**
   Set the offset

   @param offset to set
   @return this Segment (for chaining setters)
   */
  public Segment setOffset(Long offset) {
    if (Objects.nonNull(offset)) {
      this.offset = offset;
    } else {
      this.offset = 0L;
    }
    return this;
  }


  /**
   Set the value

   @param value to set
   @return this Segment (for chaining setters)
   */
  public Segment setState(String value) {
    try {
      state = SegmentState.validate(value);
    } catch (ValueException e) {
      stateException = e;
    }
    return this;
  }

  /**
   Set the value

   @param value to set
   @return this Segment (for chaining setters)
   */
  public Segment setStateEnum(SegmentState value) {
    state = value;
    return this;
  }

  /**
   Set the tempo

   @param tempo to set
   @return this Segment (for chaining setters)
   */
  public Segment setTempo(Double tempo) {
    this.tempo = tempo;
    return this;
  }

  /**
   Set the total

   @param total to set
   @return this Segment (for chaining setters)
   */
  public Segment setTotal(Integer total) {
    this.total = total;
    return this;
  }

  /**
   Set the type

   @param raw to set
   @return this Segment (for chaining setters)
   */
  public Segment setType(String raw) {
    try {
      if (Objects.nonNull(raw))
        type = SegmentType.validate(raw);
    } catch (ValueException e) {
      typeException = e;
    }
    return this;
  }

  /**
   Set the type

   @param type to set
   @return this Segment (for chaining setters)
   */
  public Segment setTypeEnum(SegmentType type) {
    this.type = type;
    return this;
  }

  /**
   Set the outputEncoder

   @param raw to set
   @return this Segment (for chaining setters)
   */
  public Segment setOutputEncoder(String raw) {
    if (Objects.nonNull(raw))
      outputEncoder = OutputEncoder.parse(raw);
    return this;
  }

  /**
   Set the outputEncoder

   @param outputEncoder to set
   @return this Segment (for chaining setters)
   */
  public Segment setOutputEncoderEnum(OutputEncoder outputEncoder) {
    this.outputEncoder = outputEncoder;
    return this;
  }


  @Override
  public Segment setUpdatedAt(String updatedAt) {
    super.setUpdatedAt(updatedAt);
    return this;
  }

  @Override
  public Segment setUpdatedAtInstant(Instant updatedAt) {
    super.setUpdatedAtInstant(updatedAt);
    return this;
  }

  /**
   Set the storageKey

   @param storageKey to set
   @return this Segment (for chaining setters)
   */
  public Segment setStorageKey(String storageKey) {
    this.storageKey = storageKey;
    return this;
  }

  /**
   Set the waveformPreroll (seconds)

   @param waveformPreroll to set (seconds)
   @return this Segment (for chaining setters)
   */
  public Segment setWaveformPreroll(Double waveformPreroll) {
    this.waveformPreroll = waveformPreroll;
    return this;
  }

  @Override
  public String toString() {
    return Entities.toKeyValueString(Segment.class.getSimpleName(), ImmutableMap.<String, String>builder()
      .put("id", String.valueOf(id))
      .put("chainId", String.valueOf(chainId))
      .put("offset", String.valueOf(offset))
      .put("state", Text.toSingleQuoted(String.valueOf(state)))
      .put("type", Text.toSingleQuoted(String.valueOf(type)))
      .put("beginAt", String.valueOf(beginAt))
      .put("endAt", String.valueOf(endAt))
      .put("createdAt", String.valueOf(createdAt))
      .put("updatedAt", String.valueOf(updatedAt))
      .build());
  }

  @Override
  public void validate() throws ValueException {
    Value.require(chainId, "Chain ID");
    Value.require(offset, "Offset");

    if (Objects.isNull(waveformPreroll)) waveformPreroll = 0.0;

    Value.requireNo(typeException, "Type");
    Value.require(type, "Type");

    Value.requireNo(stateException, "State");
    Value.require(state, "State");

    Value.requireNo(beginAtException, "Begin-at");
    Value.require(beginAt, "Begin-at");

    Value.requireNo(endAtException, "End-at");
  }

  /**
   Whether the Segment is in Dubbed state with end-at time after threshold

   @param thresholdChainHeadAt threshold time to text if Segment has end-at time after
   @return true if Segment is in Dubbed state with end-at time after threshold
   */
  public boolean isDubbedEndingAfter(Instant thresholdChainHeadAt) {
    return SegmentState.Dubbed.equals(state) && endAt.isAfter(thresholdChainHeadAt);
  }

  /**
   Whether this Segment is before a given threshold, first by end-at if available, else begin-at

   @param eraseBefore threshold to filter before
   @return true if segment is before threshold
   */
  public boolean isBefore(Instant eraseBefore) {
    return Objects.nonNull(this.getEndAt()) ?
      this.getEndAt().isBefore(eraseBefore) :
      this.getBeginAt().isBefore(eraseBefore);
  }

  /**
   Returns the storage key concatenated with the output encoder as its file extension

   @return Output Waveform Key
   */
  public String getOutputWaveformKey() {
    return getStorageKey(outputEncoder.toString().toLowerCase(Locale.ENGLISH));
  }

  /**
   Returns the storage key concatenated with JSON as its file extension

   @return Output Metadata Key
   */
  public String getOutputMetadataKey() {
    return getStorageKey(EXTENSION_JSON);
  }

  /**
   Returns the storage key concatenated with JSON as its file extension

   @return Output Metadata Key
   */
  public String getStorageKey(String extension) {
    return String.format("%s%s%s", storageKey, EXTENSION_SEPARATOR, extension);
  }

}
