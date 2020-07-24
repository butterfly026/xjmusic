// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.service.hub.digest;

import com.google.common.base.Splitter;
import io.xj.lib.entity.common.ChordEntity;
import io.xj.lib.music.Key;
import io.xj.lib.music.PitchClass;
import io.xj.lib.util.Value;

import javax.annotation.Nullable;
import java.util.List;
import java.util.Objects;
import java.util.regex.Pattern;

public class ChordNode {
  private static final PitchClass defaultChordRootPitchClass = PitchClass.C;
  private static final int MAX_SEMITONES = 12;
  private static final String NOTHING = "";
  private static final Pattern NON_CHORD_DESCRIPTOR = Pattern.compile("[^a-zA-Z0-9+\\-#♭ ]");
  @Nullable
  private final String form;
  @Nullable
  private final Integer delta; // NOTE: delta is null when this is the first unit of a sequence.
  private Long weight;

  /**
   Construct a "null" chord descriptor unit with NO chord, and NO delta.
   This is used as a "bookend" marker, e.g. meaning "pattern has ended" during chord markov computation
   */
  public ChordNode() {
    form = null;
    delta = null;
    weight = 0L;
  }

  /**
   Construct chord descriptor unit with only a chord (and no delta).
   NOTE: delta is null when this is the first unit of a sequence.

   @param chord to construct descriptor of
   */
  ChordNode(ChordEntity chord) {
    form = chord.isChord() ? formOf(chord) : null;
    delta = null;
    weight = 1L;
  }

  /**
   Construct chord descriptor unit with a delta and a chord.
   Delta is of last chord, in semitones modulo (probably 12).

   @param prevChord previous chord
   @param chord     chord to construct descriptor of
   */
  ChordNode(ChordEntity prevChord, ChordEntity chord) {
    form = chord.isChord() ? formOf(chord) : null;
    delta = chord.isChord() ? deltaSemitonesModulo(prevChord, chord) : null;
    weight = 1L;
  }

  /**
   Construct chord descriptor unit of a key and a chord.
   Delta is relative to Key, in semitones modulo (probably 12).

   @param key   relative to which each chord's root will be computed in semitones modulo
   @param chord chord to construct descriptor of
   */
  public ChordNode(Key key, ChordEntity chord) {
    form = chord.isChord() ? formOf(chord) : null;
    delta = chord.isChord() ? deltaSemitonesModulo(key, chord) : null;
    weight = 1L;
  }


  /**
   Construct a chord name unit reverse-engineered of an output descriptor string
   Expects input like "Major" or "7|Minor"
   NOTE: delta is null when this is the first unit of a sequence.

   @param descriptor to reverse engineer into a chord descriptor unit
   */
  ChordNode(CharSequence descriptor) {
    List<String> pieces = Splitter.on(Value.CHORD_SEPARATOR_DESCRIPTOR_UNIT).splitToList(descriptor);
    if (2 == pieces.size()) {
      delta = Integer.valueOf(pieces.get(0));
      form = formOf(pieces.get(1));
    } else if (1 == pieces.size()) {
      form = formOf(pieces.get(0));
      delta = null;
    } else {
      form = "";
      delta = null;
    }
    weight = 1L;
  }

  /**
   Compute descriptor.

   @param form to sanitize descriptor of
   @return descriptor
   */
  private static String formOf(CharSequence form) {
    return NON_CHORD_DESCRIPTOR.matcher(form)
      .replaceAll(NOTHING);
  }

  /**
   Compute Δ semitones modulo n of root chord to add chord

   @param key   relative to which each chord's root will be computed in semitones modulo
   @param chord compute Δ to
   @return Δ semitones modulo n (where n = max # of semitones, probably 12)
   */
  private static Integer deltaSemitonesModulo(Key key, ChordEntity chord) {
    return deltaSemitonesModulo(key.getRootPitchClass(), chord.toMusical().getRootPitchClass());
  }

  /**
   Compute Δ semitones modulo n of root chord to add chord

   @param addChord compute Δ to
   @return Δ semitones modulo n (where n = max # of semitones, probably 12)
   */
  private static int deltaSemitonesModulo(ChordEntity prevChord, ChordEntity addChord) {
    return deltaSemitonesModulo(prevChord.toMusical().getRootPitchClass(), addChord.toMusical().getRootPitchClass());
  }

  /**
   Compute Δ semitones modulo n of root chord to add chord

   @param next compute Δ to
   @return Δ semitones modulo n (where n = max # of semitones, probably 12)
   */
  private static int deltaSemitonesModulo(PitchClass prev, PitchClass next) {
    return Math.floorMod(prev.delta(next), MAX_SEMITONES);
  }

  /**
   Return the original value, or (if null) return zero

   @param value to check for null and return, or return zero
   @return original value or zero
   */
  private static Integer defaultZero(@Nullable Integer value) {
    if (Objects.nonNull(value)) return value;
    else return 0;
  }

  /**
   Compute descriptor.

   @param chord to compute descriptor of
   @return descriptor
   */
  private static String formOf(ChordEntity chord) {
    return formOf(chord.toMusical().colloquialFormName());
  }

  /**
   Similarity between the chord of two nodes

   @param other chord node
   @return similarity ratio of 0 to 1
   */
  Double similarity(ChordNode other) {
    return io.xj.lib.music.Chord.of(String.format("%s %s", defaultChordRootPitchClass.step(defaultZero(getDelta())).getPitchClass(), getForm()))
      .similarity(io.xj.lib.music.Chord.of(String.format("%s %s", defaultChordRootPitchClass.step(defaultZero(other.getDelta())).getPitchClass(), other.getForm())));
  }

  /**
   Get the weight of this node

   @return weight
   */
  Long getWeight() {
    return weight;
  }

  /**
   Get the weight of this node
   */
  void addWeight(ChordNode node) {
    weight += node.getWeight();
  }

  /**
   Get chord form.

   @return chord form
   */
  @Nullable
  String getForm() {
    return form;
  }

  /**
   Get unit delta of last chord, in semitones modulo (probably 12).
   NOTE: delta is null when this is the first unit of a sequence.

   @return unit delta of last chord, in semitones modulo (probably 12).
   */
  @Nullable
  Integer getDelta() {
    return delta;
  }

  /**
   Render as a string
   // Ba. append primary separator + Cn Δ semitones (modulo)
   // Bb. append secondary separator + append Cn form

   @return string of chord descriptor unit
   */
  @Override
  public String toString() {
    if (Objects.nonNull(delta) && Objects.nonNull(form))
      return String.format("%d%s%s", delta, Value.CHORD_SEPARATOR_DESCRIPTOR_UNIT, form);
    else if (Objects.nonNull(form))
      return form;
    else
      return Value.CHORD_MARKER_NON_CHORD;
  }

  /**
   Whether another chord descriptor unit is equivalent to this one.
   Compares form and delta separately, where a null delta acts as a match-all wildcard.

   @param other to match
   @return true if equivalent
   */
  boolean isEquivalentTo(ChordNode other) {
    if (!Objects.equals(form, other.getForm())) return false;
    if (Objects.isNull(delta) || Objects.isNull(other.getDelta())) return true;
    return Objects.equals(delta, other.getDelta());
  }

  /**
   Is this a chord (as opposed to a null "bookend" marker)?

   @return true if this is a chord (NOT a null marker)
   */
  public boolean isChord() {
    return Objects.nonNull(form);
  }
}