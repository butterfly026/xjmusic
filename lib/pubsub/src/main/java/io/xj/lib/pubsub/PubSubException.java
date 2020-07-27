// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.lib.pubsub;

import javax.annotation.Nullable;
import java.util.Arrays;
import java.util.Objects;

public class PubSubException extends Exception {

  public PubSubException(String msg) {
    super(msg);
  }

  public PubSubException(String msg, Exception e) {
    super(String.format("%s %s\n%s", msg, e.toString(), formatStackTrace(e)));
  }

  public PubSubException(Throwable targetException) {
    super(String.format("%s\n%s", targetException.getMessage(), formatStackTrace(targetException)));
  }

  /**
   Format a stack trace in carriage-return-separated lines

   @param e exception to format the stack trace of
   @return formatted stack trace
   */
  static String formatStackTrace(@Nullable Throwable e) {
    if (Objects.isNull(e)) return "";
    StackTraceElement[] stack = e.getStackTrace();
    String[] stackLines = Arrays.stream(stack).map(StackTraceElement::toString).toArray(String[]::new);
    return String.join(System.getProperty("line.separator"), stackLines);
  }
}
