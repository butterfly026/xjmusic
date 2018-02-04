// Copyright (c) 2017, Outright Mental Inc. (http://outright.io) All Rights Reserved.
package io.xj.craft.digest.chord_markov;

import io.xj.craft.digest.Digest;
import io.xj.core.model.chord.ChordMarkovNode;

import java.util.Map;

public interface DigestChordMarkov extends Digest {

  /**
   @return map of the likelihood of each following node, based on observation of preceding nodes.
   */
  Map<String, ChordMarkovNode> getForwardNodeMap();

  /**
   @return map of the likelihood of each preceding node, based on observation of following nodes in reverse time.
   */
  Map<String, ChordMarkovNode> getReverseNodeMap();

  /**
   @return the order of markov chain computation, e.g. 3 means that 3 preceding chords will be observed at any node.
   */
  Integer getMarkovOrder();

}
