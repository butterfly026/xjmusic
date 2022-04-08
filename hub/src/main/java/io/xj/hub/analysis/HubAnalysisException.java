// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.hub.analysis;

import io.xj.lib.util.Text;

/**
 Template content Analysis https://www.pivotaltracker.com/story/show/161199945
 */
public class HubAnalysisException extends Exception {

  public HubAnalysisException(String msg) {
    super(msg);
  }

  public HubAnalysisException(String msg, Exception e) {
    super(String.format("%s %s\n%s", msg, e.toString(), Text.formatStackTrace(e)));
  }

  public HubAnalysisException(Throwable targetException) {
    super(String.format("%s\n%s", targetException.getMessage(), Text.formatStackTrace(targetException)));
  }
}