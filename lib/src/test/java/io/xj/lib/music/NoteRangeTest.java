// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.

package io.xj.lib.music;

import com.google.common.collect.ImmutableList;
import com.google.common.collect.ImmutableSet;
import org.junit.Before;
import org.junit.Test;

import java.util.List;

import static io.xj.lib.music.NoteTest.assertNote;
import static org.junit.Assert.*;

public class NoteRangeTest {
  NoteRange subject;

  @Before
  public void setUp() {
    subject = NoteRange.ofStrings(ImmutableList.of(
      "C3",
      "E3",
      "D4",
      "E5",
      "F6"
    ));
  }

  @Test
  public void getLow() {
    assertTrue(Note.of("C3").sameAs(subject.getLow().orElseThrow()));
  }

  @Test
  public void getHigh() {
    assertTrue(Note.of("F6").sameAs(subject.getHigh().orElseThrow()));
  }

  @Test
  public void rangeFromNotes() {
    subject = NoteRange.from(Note.of("C3"), Note.of("C4"));

    assertTrue(Note.of("C3").sameAs(subject.getLow().orElseThrow()));
    assertTrue(Note.of("C4").sameAs(subject.getHigh().orElseThrow()));
  }

  @Test
  public void rangeOfNoteX_isEmpty() {
    subject = NoteRange.ofNotes(List.of(Note.of("X")));

    assertTrue(subject.isEmpty());
  }

  @Test
  public void rangeFromNotes_lowIsOptional() {
    subject = NoteRange.from(null, Note.of("C4"));

    assertFalse(subject.getLow().isPresent());
    assertTrue(Note.of("C4").sameAs(subject.getHigh().orElseThrow()));
  }

  @Test
  public void rangeFromNotes_highIsOptional() {
    subject = NoteRange.from(Note.of("C4"), null);

    assertTrue(Note.of("C4").sameAs(subject.getLow().orElseThrow()));
    assertFalse(subject.getHigh().isPresent());
  }

  @Test
  public void rangeFromStrings() {
    subject = NoteRange.from("C3", "C4");

    assertTrue(Note.of("C3").sameAs(subject.getLow().orElseThrow()));
    assertTrue(Note.of("C4").sameAs(subject.getHigh().orElseThrow()));
  }

  @Test
  public void rangeFromStrings_lowOptional() {
    subject = NoteRange.from(null, "C4");

    assertFalse(subject.getLow().isPresent());
    assertTrue(Note.of("C4").sameAs(subject.getHigh().orElseThrow()));
  }

  @Test
  public void rangeFromStrings_highOptional() {
    subject = NoteRange.from("C4", null);

    assertTrue(Note.of("C4").sameAs(subject.getLow().orElseThrow()));
    assertFalse(subject.getHigh().isPresent());
  }

  @Test
  public void copyOf() {
    var cp = NoteRange.copyOf(subject);

    assertTrue(Note.of("C3").sameAs(cp.getLow().orElseThrow()));
    assertTrue(Note.of("F6").sameAs(cp.getHigh().orElseThrow()));
  }

  @Test
  public void outputToString() {
    assertEquals("C3-F6", subject.toString(AdjSymbol.None));
  }

  @Test
  public void expand() {
    subject.expand(Note.of("G2"));

    assertTrue(Note.of("G2").sameAs(subject.getLow().orElseThrow()));
    assertTrue(Note.of("F6").sameAs(subject.getHigh().orElseThrow()));
  }

  @Test
  public void expand_byNotes() {
    subject.expand(ImmutableSet.of(
      Note.of("G2"),
      Note.of("G6")
    ));

    assertTrue(Note.of("G2").sameAs(subject.getLow().orElseThrow()));
    assertTrue(Note.of("G6").sameAs(subject.getHigh().orElseThrow()));
  }

  @Test
  public void expandWithAnotherRange() {
    subject.expand(NoteRange.ofStrings(ImmutableSet.of(
      "G2",
      "G6"
    )));

    assertTrue(Note.of("G2").sameAs(subject.getLow().orElseThrow()));
    assertTrue(Note.of("G6").sameAs(subject.getHigh().orElseThrow()));
  }

  @Test
  public void median() {
    var fromNulls = NoteRange.median(NoteRange.ofStrings(List.of()), NoteRange.ofStrings(List.of()));
    assertTrue(fromNulls.getLow().isEmpty());
    assertTrue(fromNulls.getHigh().isEmpty());

    var emptyHigh = NoteRange.median(NoteRange.ofStrings(List.of("C5")), NoteRange.ofStrings(List.of()));
    assertNote("C5", emptyHigh.getLow().orElseThrow());
    assertNote("C5", emptyHigh.getHigh().orElseThrow());

    var emptyLow = NoteRange.median(NoteRange.ofStrings(List.of()), NoteRange.ofStrings(List.of("G#5")));
    assertNote("G#5", emptyLow.getLow().orElseThrow());
    assertNote("G#5", emptyLow.getHigh().orElseThrow());

    var normal = NoteRange.median(NoteRange.ofStrings(List.of("C5", "G5")), NoteRange.ofStrings(List.of("G#5", "B5")));
    assertNote("E5", normal.getLow().orElseThrow());
    assertNote("A5", normal.getHigh().orElseThrow());
  }

  @Test
  public void getDeltaSemitones() {
    assertEquals(0, NoteRange.from("C5", "G5").getDeltaSemitones(NoteRange.from("C5", "G5")));
    assertEquals(0, NoteRange.from("C5", "G5").getDeltaSemitones(NoteRange.from("D5", "F5")));
    assertEquals(1, NoteRange.from("C5", "G5").getDeltaSemitones(NoteRange.from("E5", "F5")));
    assertEquals(-1, NoteRange.from("C5", "G5").getDeltaSemitones(NoteRange.from("D5", "Eb5")));
    assertEquals(2, NoteRange.from("C5", "G5").getDeltaSemitones(NoteRange.from("F5", "F#5")));
    assertEquals(-2, NoteRange.from("C5", "G5").getDeltaSemitones(NoteRange.from("Db5", "D5")));
  }

  @Test
  public void getNoteNearestMedian() {
    assertNote("C5", NoteRange.from("C3", "G6").getNoteNearestMedian(PitchClass.C).orElseThrow());
    assertNote("C5", NoteRange.from("C3", "G7").getNoteNearestMedian(PitchClass.C).orElseThrow());
    assertNote("C4", NoteRange.from("C2", "G6").getNoteNearestMedian(PitchClass.C).orElseThrow());
    assertTrue( NoteRange.from("C3", "G6").getNoteNearestMedian(PitchClass.None).isEmpty());
  }

  @Test
  public void getMedianNote() {
    assertNote("D#5", NoteRange.from("C5", "G5").getMedianNote().orElseThrow());
    assertNote("G5", NoteRange.from(null, "G5").getMedianNote().orElseThrow());
    assertNote("C5", NoteRange.from("C5", null).getMedianNote().orElseThrow());
    assertTrue(NoteRange.empty().getMedianNote().isEmpty());
  }

  @Test
  public void shifted() {
    var input = NoteRange.from("C5", "G5");

    var result = input.shifted(2);

    assertNote("D5", result.getLow().orElseThrow());
    assertNote("A5", result.getHigh().orElseThrow());
    // input not modified
    assertNote("C5", input.getLow().orElseThrow());
    assertNote("G5", input.getHigh().orElseThrow());
  }

  @Test
  public void isEmpty() {
    assertTrue(NoteRange.empty().isEmpty());
    assertFalse(NoteRange.from("C5", "G5").isEmpty());
  }

}
