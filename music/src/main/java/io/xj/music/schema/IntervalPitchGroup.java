// Copyright (c) 2017, Outright Mental Inc. (http://outright.io) All Rights Reserved.
package io.xj.music.schema;

import io.xj.music.AdjSymbol;
import io.xj.music.Interval;
import io.xj.music.Note;
import io.xj.music.PitchClass;
import io.xj.music.Root;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;

import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.SortedMap;

/**
 Interval Pitch Group is the super-entity to a Key, Chord or Scale- any group of pitches at specific intervals.
 */
public abstract class IntervalPitchGroup {
  protected String description;
  protected String name;
  // Root Pitch Class
  protected PitchClass root;
  // the (flat/sharp) adjustment symbol, which will be used to express this chord
  protected AdjSymbol adjSymbol;
  // a map of this chord's +/- semitones-from-root, for each interval
  protected SortedMap<Interval, Integer> tones;

  public IntervalPitchGroup(String name) {

    // initialize tones map
    this.tones = Maps.newTreeMap();

    // Don't set values if there's nothing to set
    if (Objects.isNull(name) || name.length() == 0)
      return;

    // store original name
    this.name = name;

    // determine whether the name is "sharps" or "flats"
    this.adjSymbol = AdjSymbol.of(name);

    // Root utility separates root from remaining text
    Root root = Root.of(name);

    // parse the root, and keep the remaining string
    this.root = root.getPitchClass();

    // description is everything AFTER the root, in the original name
    this.description = root.getRemainingText();

    // parse the chord Form
    this.parseSchema(root.getRemainingText());
  }

  public static String detailsOf(Map<Interval, PitchClass> intervalPitchClasses, AdjSymbol adjSymbol) {
    int i = 0;
    String[] detailStrings = new String[intervalPitchClasses.size()];
    for (Interval interval : Interval.values()) {
      if (intervalPitchClasses.containsKey(interval)) {
        detailStrings[i] = interval.getValue() + ":" + intervalPitchClasses.get(interval).toString(adjSymbol);
        i++;
      }
    }
    return "{ " + String.join(", ", detailStrings) + " }";
  }

  /**
   Get the full description of the chord, including the root and the remaining description thereafter
   @return full description
   */
  public String getFullDescription() {
    return this.root.toString(adjSymbol) + " " + description;
  }

  public String getOriginalDescription() {
    return description;
  }

  /**
   Classes must implement this method

   @param text to parse schema from
   */
  abstract protected void parseSchema(String text);

  /**
   Notes to obtain the notes from the Chord, in a particular octave

   @param octave to get notes in
   @return notes
   */
  public List<Note> toNotes(int octave) {
    List<Note> notes = Lists.newArrayList();
    Note rootNote = Note.of(root, octave);
    this.tones.forEach((interval, offsetSemitones) ->
      notes.add(rootNote.transpose(offsetSemitones)));
    return notes;
  }

  /**
   Detailed String expression of interval pitch group

   @return chord as string
   */
  public String details() {
    return "'" + name + "'" + " " + "(" +
      root.toString(adjSymbol) + ":" + " " +
      String.join(", ", toneOffsetStrings()) + ")";
  }

  /**
   @return pitch classes at intervals
   */
  public Map<Interval, PitchClass> getPitchClasses() {
    Map<Interval, PitchClass> pitchClasses = Maps.newHashMap();
    tones.forEach((interval, offsetSemitones) ->
      pitchClasses.put(interval, root.step(offsetSemitones).getPitchClass()));
    return pitchClasses;
  }

  /**
   String expression of interval pitch group, original name

   @return scale as string
   */
  public String toString() {
    return name;
  }

  /**
   Delta to another Key calculated in +/- semitones

   @param target key to calculate delta to
   @return delta +/- semitones to another key
   */
  public int delta(IntervalPitchGroup target) {
    return this.root.delta(target.getRootPitchClass());
  }

  public String getName() {
    return name;
  }

  public PitchClass getRoot() {
    return root;
  }

  public SortedMap<Interval, Integer> getTones() {
    return tones;
  }

  public PitchClass getRootPitchClass() {
    return root;
  }

  public AdjSymbol getAdjSymbol() {
    return adjSymbol;
  }

  /**
   Array of tone offsets

   @return tone offsets
   */
  private String[] toneOffsetStrings() {
    int i = 0;
    Object[] offsets = tones.values().toArray();
    Arrays.sort(offsets);
    String[] offsetStrings = new String[offsets.length];
    for (Object toneOffset : offsets) {
      offsetStrings[i] = String.valueOf(toneOffset);
      i++;
    }
    return offsetStrings;
  }
}