// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.

package io.xj.lib.util;

import org.slf4j.Logger;

import java.io.*;

public class StreamLogger implements Runnable {
  private static final String THREAD_NAME = "ffmpeg";
  private final Logger LOG;
  private final InputStream _inputStream;
  private final String name;

  public StreamLogger(Logger LOG, InputStream is, String name) {
    this.LOG = LOG;
    _inputStream = is;
    this.name = name;
  }

  public static void close(Reader reader) {
    try {
      if (reader != null) {
        reader.close();
      }
    } catch (IOException e) {
      e.printStackTrace();
    }
  }

  public void run() {
    InputStreamReader isr = null;
    BufferedReader br = null;
    final Thread currentThread = Thread.currentThread();
    final String oldName = currentThread.getName();
    try {
      currentThread.setName(THREAD_NAME);
      isr = new InputStreamReader(_inputStream);
      br = new BufferedReader(isr);
      String line;
      while ((line = br.readLine()) != null) {
        LOG.info("[{}] {}", name, line);
      }
    } catch (IOException e) {
      LOG.error("[{}}] Failed to read from stream!", name, e);
    } finally {
      LOG.info("[{}}] Done reading stream", name);
      close(isr);
      close(br);
      currentThread.setName(oldName);
    }
  }
}