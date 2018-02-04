// Copyright (c) 2017, Outright Mental Inc. (http://outright.io) All Rights Reserved.
package io.xj.craft.cache.digest.impl;

import io.xj.craft.ingest.Ingest;
import io.xj.craft.digest.Digest;

import com.github.benmanes.caffeine.cache.Expiry;

import javax.annotation.Nonnull;

public class DigestCacheExpiry implements Expiry<Ingest, Digest> {
  @Override
  public long expireAfterCreate(@Nonnull Ingest key, @Nonnull Digest value, long currentTime) {
    return 0;
  }

  @Override
  public long expireAfterUpdate(@Nonnull Ingest key, @Nonnull Digest value, long currentTime, long currentDuration) {
    return 0;
  }

  @Override
  public long expireAfterRead(@Nonnull Ingest key, @Nonnull Digest value, long currentTime, long currentDuration) {
    return 0;
  }
}

