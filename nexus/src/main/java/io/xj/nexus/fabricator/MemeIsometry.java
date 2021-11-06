// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.nexus.fabricator;

import com.google.common.base.Objects;
import io.xj.lib.entity.Entities;
import io.xj.lib.entity.EntityException;
import io.xj.lib.util.Text;

import java.util.Collection;
import java.util.List;

/**
 Determine the isometry between a source and target group of Memes
 */
public class MemeIsometry extends Isometry {
  private static final String KEY_NAME = "name";
  private static final int WEIGHT_MATCH = 1;
  private final MemeStack stack;

  /**
   Construct a meme isometry from source memes

   @param sourceMemes from which to construct isometry
   */
  public MemeIsometry(Collection<String> sourceMemes) {
    for (String meme : sourceMemes) add(Text.toMeme(meme));
    stack = MemeStack.from(getSources());
  }

  /**
   Instantiate a new MemeIsometry of a group of source Memes,
   as expressed in a Result of jOOQ records.

   @param sourceMemes to compare of
   @return MemeIsometry ready for comparison to target Memes
   */
  public static MemeIsometry ofMemes(Collection<String> sourceMemes) {
    return new MemeIsometry(sourceMemes);
  }

  /**
   Instantiate a new MemeIsometry representing having no memes

   @return an empty MemeIsometry
   */
  public static MemeIsometry none() {
    return new MemeIsometry(List.of());
  }

  /**
   Score a CSV list of memes based on isometry to source memes

   @param targets comma-separated values to score against source meme names
   @return score is between 0 (no matches) and 1 (all memes match)
   */
  public double score(Collection<String> targets) {
    return targets.stream()
      .map(Text::toMeme)
      .flatMap(target -> sources.stream().map(source -> Objects.equal(source, target) ? WEIGHT_MATCH : 0))
      .reduce(0, Integer::sum);
  }

  /**
   Add a meme for isometry comparison
   */
  public <R> void add(R meme) {
    try {
      Entities.get(meme, KEY_NAME)
        .ifPresent(name -> add(Text.toMeme(String.valueOf(name))));
    } catch (EntityException ignored) {
    }
  }

  public boolean isAllowed(Collection<String> memes) {
    return stack.isAllowed(memes);
  }
}
