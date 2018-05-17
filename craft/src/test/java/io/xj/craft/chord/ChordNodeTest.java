// Copyright (c) 2018, XJ Music Inc. (https://xj.io) All Rights Reserved.

package io.xj.craft.chord;// Copyright (c) 2018, XJ Music Inc. (https://xj.io) All Rights Reserved.

import io.xj.core.model.pattern_chord.PatternChord;
import io.xj.craft.chord.ChordNode;

import org.junit.Test;

import java.math.BigInteger;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertNull;
import static org.junit.Assert.assertTrue;

public class ChordNodeTest {
  @Test
  public void getForm() throws Exception {
    assertEquals("Major",
      new ChordNode("Major").getForm());

    assertEquals("Major",
      new ChordNode("7|Major").getForm());

    assertEquals("Major",
      new ChordNode(new PatternChord(BigInteger.valueOf(21), 1.0, "C Minor"),
        new PatternChord(BigInteger.valueOf(21), 2.0, "G Major")).getForm());

    assertEquals("Major",
      new ChordNode(new PatternChord(BigInteger.valueOf(21), 2.0, "G Major")).getForm());
  }

  @Test
  public void getWeight() throws Exception {
    assertEquals(Long.valueOf(1),
      new ChordNode("Major").getWeight());

    assertEquals(Long.valueOf(1),
      new ChordNode("7|Major").getWeight());

    assertEquals(Long.valueOf(1),
      new ChordNode(new PatternChord(BigInteger.valueOf(21), 1.0, "C Minor"),
        new PatternChord(BigInteger.valueOf(21), 2.0, "G Major")).getWeight());

    assertEquals(Long.valueOf(1),
      new ChordNode(new PatternChord(BigInteger.valueOf(21), 2.0, "G Major")).getWeight());
  }

  @Test
  public void addWeight() throws Exception {
    ChordNode subject =  new ChordNode("7|Major");
    subject.addWeight( new ChordNode("5|Major"));
    subject.addWeight( new ChordNode("4|Minor"));
    assertEquals(Long.valueOf(3), subject.getWeight());
  }

  @Test
  public void getDelta() throws Exception {
    assertNull(new ChordNode("Major").getDelta());

    assertEquals(Integer.valueOf(7),
      new ChordNode("7|Major").getDelta());

    assertEquals(Integer.valueOf(7),
      new ChordNode(new PatternChord(BigInteger.valueOf(21), 1.0, "C Minor"),
        new PatternChord(BigInteger.valueOf(21), 2.0, "G Major")).getDelta());

    assertNull(new ChordNode(new PatternChord(BigInteger.valueOf(21), 2.0, "G Major")).getDelta());
  }

  @Test
  public void descriptorToString() throws Exception {
    assertEquals("Major",
      new ChordNode("Major").toString());

    assertEquals("7|Major",
      new ChordNode("7|Major").toString());

    assertEquals("7|Major",
      new ChordNode(new PatternChord(BigInteger.valueOf(21), 1.0, "C Minor"),
        new PatternChord(BigInteger.valueOf(21), 2.0, "G Major")).toString());

    assertEquals("Major",
      new ChordNode(new PatternChord(BigInteger.valueOf(21), 2.0, "G Major")).toString());
  }

  @Test
  public void isEquivalentTo() throws Exception {
    assertTrue(new ChordNode("Major").isEquivalentTo(new ChordNode("Major")));
    assertTrue(new ChordNode("11|Major").isEquivalentTo(new ChordNode("Major")));
    assertTrue(new ChordNode("Major").isEquivalentTo(new ChordNode("9|Major")));
    assertFalse(new ChordNode("Minor").isEquivalentTo(new ChordNode("9|Major")));
    assertTrue(new ChordNode("7|Major").isEquivalentTo(new ChordNode("7|Major")));
    assertFalse(new ChordNode("8|Major").isEquivalentTo(new ChordNode("7|Major")));
    assertTrue(new ChordNode(new PatternChord(BigInteger.valueOf(21), 1.0, "C Minor"),
        new PatternChord(BigInteger.valueOf(21), 2.0, "G Major")).isEquivalentTo(new ChordNode("7|Major")));
    assertTrue(new ChordNode(new PatternChord(BigInteger.valueOf(21), 2.0, "G Major")).isEquivalentTo(new ChordNode("Major")));
  }

  @Test
  public void bookendMarkerPatternHasEnded() throws Exception {
     // This is used as a "bookend" marker, e.g. meaning "pattern has ended" during chord markov computation
    ChordNode subject = new ChordNode();

    assertNull(subject.getDelta());
    assertNull(subject.getForm());
    assertEquals("---", subject.toString());
  }

}
