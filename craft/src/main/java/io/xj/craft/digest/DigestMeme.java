// Copyright (c) 2020, XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.craft.digest;

import io.xj.craft.digest.impl.DigestMemeImpl;

import java.util.Map;

public interface DigestMeme extends Digest {

  /**
   Get a map of all digested memes

   @return map of digested memes
   */
  Map<String, DigestMemeImpl.DigestMemesItem> getMemes();

}
