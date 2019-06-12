//  Copyright (c) 2019, XJ Music Inc. (https://xj.io) All Rights Reserved.

package io.xj.core.model.program.impl;

import com.google.common.collect.Lists;
import io.xj.core.model.entity.SuperEntityContent;
import io.xj.core.model.program.Program;
import io.xj.core.model.program.ProgramType;
import io.xj.core.model.program.sub.Pattern;
import io.xj.core.model.program.sub.PatternEvent;
import io.xj.core.model.program.sub.ProgramMeme;
import io.xj.core.model.program.sub.Sequence;
import io.xj.core.model.program.sub.SequenceBinding;
import io.xj.core.model.program.sub.SequenceBindingMeme;
import io.xj.core.model.program.sub.SequenceChord;
import io.xj.core.model.program.sub.Voice;

import java.util.Collection;

/**
 [#166129999] ProgramContent is a discrete class used for data persistence.
 [#166132897] ProgramContent POJO via gson only (no JSONObject)
 <p>
 Maps to JSON:
 {
 "type": "Continue",
 "memes": [],
 "sequences": [],
 "patterns": [],
 "chords": [],
 "patternEvents": [],
 "report": {}
 }
 */
public class ProgramContent implements SuperEntityContent {
  private final Collection<Pattern> patterns = Lists.newArrayList();
  private final Collection<PatternEvent> patternEvents = Lists.newArrayList();
  private final Collection<ProgramMeme> memes = Lists.newArrayList();
  private final Collection<Sequence> sequences = Lists.newArrayList();
  private final Collection<SequenceBinding> sequenceBindings = Lists.newArrayList();
  private final Collection<SequenceBindingMeme> sequenceBindingMemes = Lists.newArrayList();
  private final Collection<SequenceChord> sequenceChords = Lists.newArrayList();
  private final Collection<Voice> voices = Lists.newArrayList();
  private ProgramType type;

  /**
   Create a instance of ProgramContent, used for transporting the content of a program

   @param program to get content of
   @return program content
   */
  public static ProgramContent of(Program program) {
    ProgramContent content = new ProgramContent();
    content.setPatterns(program.getPatterns());
    content.setPatternEvents(program.getPatternEvents());
    content.setMemes(program.getMemes());
    content.setSequences(program.getSequences());
    content.setSequenceBindings(program.getSequenceBindings());
    content.setSequenceBindingMemes(program.getSequenceBindingMemes());
    content.setSequenceChords(program.getSequenceChords());
    content.setVoices(program.getVoices());
    return content;
  }

  /**
   Get Patterns

   @return Patterns
   */
  public Collection<Pattern> getPatterns() {
    return patterns;
  }

  /**
   Get Sequences

   @return Sequences
   */
  public Collection<Sequence> getSequences() {
    return sequences;
  }

  /**
   Get Chords

   @return Chords
   */
  public Collection<SequenceChord> getSequenceChords() {
    return sequenceChords;
  }

  /**
   Get Memes

   @return Memes
   */
  public Collection<ProgramMeme> getMemes() {
    return memes;
  }


  /**
   Get PatternEvents

   @return PatternEvents
   */
  public Collection<PatternEvent> getPatternEvents() {
    return patternEvents;
  }

  /**
   Get Type

   @return Type
   */
  public ProgramType getType() {
    return type;
  }

  /**
   Set Pattern

   @param patterns to set
   */
  public void setPatterns(Collection<Pattern> patterns) {
    this.patterns.clear();
    this.patterns.addAll(patterns);
  }

  /**
   Set Sequences

   @param sequences to set
   */
  public void setSequences(Collection<Sequence> sequences) {
    this.sequences.clear();
    this.sequences.addAll(sequences);
  }

  /**
   Set Sequence Bindings

   @param sequenceBindings to set
   */
  public void setSequenceBindings(Collection<SequenceBinding> sequenceBindings) {
    this.sequenceBindings.clear();
    this.sequenceBindings.addAll(sequenceBindings);
  }

  /**
   Set Sequence Binding Memes

   @param sequenceBindingMemes to set
   */
  public void setSequenceBindingMemes(Collection<SequenceBindingMeme> sequenceBindingMemes) {
    this.sequenceBindingMemes.clear();
    this.sequenceBindingMemes.addAll(sequenceBindingMemes);
  }


  /**
   Set Chords

   @param sequenceChords to set
   */
  public void setSequenceChords(Collection<SequenceChord> sequenceChords) {
    this.sequenceChords.clear();
    this.sequenceChords.addAll(sequenceChords);
  }

  /**
   Set Memes

   @param memes to set
   */
  public void setMemes(Collection<ProgramMeme> memes) {
    this.memes.clear();
    this.memes.addAll(memes);
  }

  /**
   Set PatternEvents

   @param patternEvents to set
   */
  public void setPatternEvents(Collection<PatternEvent> patternEvents) {
    this.patternEvents.clear();
    this.patternEvents.addAll(patternEvents);
  }

  /**
   Set Type

   @param type to set
   */
  public void setType(String type) {
    this.type = ProgramType.valueOf(type);
  }

  /**
   Set Voices

   @param voices to set
   */
  public void setVoices(Collection<Voice> voices) {
    this.voices.clear();
    this.voices.addAll(voices);
  }

  /**
   Get Sequence Binding Memes

   @return sequence binding memes
   */
  public Collection<SequenceBindingMeme> getSequenceBindingMemes() {
    return sequenceBindingMemes;
  }

  /**
   Get Sequence Bindings

   @return Sequence Bindings
   */
  public Collection<SequenceBinding> getSequenceBindings() {
    return sequenceBindings;
  }

  /**
   Get Voices

   @return voices
   */
  public Collection<Voice> getVoices() {
    return voices;
  }
}
