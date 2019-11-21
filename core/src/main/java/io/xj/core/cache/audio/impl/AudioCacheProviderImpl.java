// Copyright (c) 2020, XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.core.cache.audio.impl;

import com.github.benmanes.caffeine.cache.Caffeine;
import com.github.benmanes.caffeine.cache.LoadingCache;
import com.github.benmanes.caffeine.cache.RemovalCause;
import com.github.benmanes.caffeine.cache.stats.CacheStats;
import com.google.inject.Inject;
import com.google.inject.Singleton;
import io.xj.core.cache.audio.AudioCacheProvider;
import io.xj.core.config.Config;
import io.xj.core.exception.CoreException;
import io.xj.core.external.amazon.AmazonProvider;
import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.Objects;

@Singleton
public class AudioCacheProviderImpl implements AudioCacheProvider {
  final Logger log = LoggerFactory.getLogger(AudioCacheProviderImpl.class);
  final String pathPrefix = Config.getCacheFilePathPrefix();
  private final AmazonProvider amazonProvider;
  private final LoadingCache<String, Item> items;

  @Inject
  AudioCacheProviderImpl(AmazonProvider amazonProvider) {
    this.amazonProvider = amazonProvider;
    try {
      // make directory for cache files
      File dir = new File(pathPrefix);
      if (!dir.exists()) {
        FileUtils.forceMkdir(dir);
      }
      log.info("Initialized audio cache directory: {}", pathPrefix);

    } catch (IOException e) {
      log.error("Failed to initialize audio cache directory: {}", pathPrefix, e);
    }

    LoadingCache<String, Item> loadItems = null;
    long allocateBytes = Config.getCacheFileAllocateBytes();
    try {
      loadItems = Caffeine.newBuilder()
        .maximumWeight(allocateBytes)
        .weigher((String key, Item item) -> item.size())
        .removalListener(this::remove)
        .build(this::fetchAndWrite);
      log.info("Initialized Caffeine cache, allocated {} bytes", allocateBytes);

    } catch (Exception e) {
      log.error("Failed to initialize Caffeine cache", e);
    }

    items = loadItems;
  }

  @Override
  public Long estimatedSize() {
    return items.estimatedSize();
  }

  @Override
  public CacheStats stats() {
    return items.stats();
  }

  @Override
  public Item get(String key) {
    return items.get(key);
  }

  @Override
  public void refresh(String key) {
    items.refresh(key);
  }

  /**
   item has been evicted of cache

   @param key   of item to remove
   @param item  to remove
   @param cause of removal
   */
  private void remove(String key, Item item, RemovalCause cause) {
    item.remove();
    log.info("Removed {} because {}", key, cause);
  }

  /**
   Compute the value of a cache item

   @param key to compute value for
   @return computed item
   */
  private Item fetchAndWrite(String key) throws CoreException, IOException {
    Item item = new Item(key);
    InputStream stream = amazonProvider.streamS3Object(Config.getAudioFileBucket(), key);
    item.writeFrom(stream);
    if (Objects.nonNull(stream)) stream.close(); // FUTURE when does this ever happen?
    return item;
  }

  /*
   FUTURE Garbage collection routine
   *
  public static void cleanup() {
    // future: for each contents of cache, sorted by last used date, most recent to most stale, tally up sum of total bytes stored
    // future: when contents of cache is greater or equal to max cache file storage space, delete all remaining contents and delete corresponding stored files
  }
   */

}
