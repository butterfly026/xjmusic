// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.

package io.xj.nexus.dao.exception;

import io.xj.lib.util.Text;

public class DAOFatalException extends Exception {

  public DAOFatalException(String msg) {
    super(msg);
  }

  public DAOFatalException(String msg, Exception e) {
    super(String.format("%s %s\n%s", msg, e.toString(), Text.formatStackTrace(e)));
  }

  public DAOFatalException(Throwable targetException) {
    super(String.format("%s\n%s", targetException.getMessage(), Text.formatStackTrace(targetException)));
  }
}