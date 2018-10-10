// Copyright (c) 2018, XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.craft.isometry;

import io.xj.core.model.segment_meme.SegmentMeme;
import io.xj.core.model.meme.Meme;

import com.google.common.collect.ImmutableList;

import org.junit.Test;

import java.math.BigInteger;
import java.util.Collection;
import java.util.List;

import static org.junit.Assert.assertArrayEquals;

public class MemeIsometryTest {
  private final Collection<Meme> testMemesA = ImmutableList.of(
    new SegmentMeme().setSegmentId(BigInteger.valueOf(12)).setName("Smooth"),
    new SegmentMeme().setSegmentId(BigInteger.valueOf(14)).setName("Catlike")
  );

  private final Collection<Meme> testMemesB = ImmutableList.of(
    new SegmentMeme().setSegmentId(BigInteger.valueOf(8)).setName("Intensity"),
    new SegmentMeme().setSegmentId(BigInteger.valueOf(21)).setName("Cool"),
    new SegmentMeme().setSegmentId(BigInteger.valueOf(45)).setName("Dark")
  );

  @Test
  public void of_List() throws Exception {
    MemeIsometry result = MemeIsometry.of(testMemesA);

    assertArrayEquals(new String[]{"smooth", "catlik"}, result.getSourceStems().toArray());
  }

  @Test
  public void getSourceStems() throws Exception {
    MemeIsometry test = MemeIsometry.of(testMemesB);

    List<String> result = test.getSourceStems();

    assertArrayEquals(new String[]{"intens", "cool", "dark"}, result.toArray());
  }


}