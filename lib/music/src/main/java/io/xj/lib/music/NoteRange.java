package io.xj.lib.music;

import java.util.Collection;

/**
 Represent a note range
 */
public class NoteRange {
  private static final Note MINIMUM = Note.of(PitchClass.None, 0);
  private static final Note MAXIMUM = Note.of(PitchClass.None, 9);
  Note low;
  Note high;

  public NoteRange(Collection<Note> notes) {
    low = notes.stream().min(Note::compareTo).orElse(MINIMUM);
    high = notes.stream().max(Note::compareTo).orElse(MAXIMUM);
  }

  public Note getLow() {
    return low;
  }

  public Note getHigh() {
    return high;
  }
}