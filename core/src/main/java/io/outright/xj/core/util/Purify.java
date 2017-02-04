// Copyright (c) 2017, Outright Mental Inc. (http://outright.io) All Rights Reserved.
package io.outright.xj.core.util;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public interface Purify {
  Pattern nonAlphabet = Pattern.compile("[^a-zA-Z]");
  Pattern nonNote = Pattern.compile("[^#0-9a-zA-Z ]");

  static String Slug(String raw) {
    Matcher m = nonAlphabet.matcher(raw);
    return m.replaceAll("");
  }

  static String Slug(String raw, String defaultValue) {
    String slug = Slug(raw);
    return slug.length() > 0 ? slug : defaultValue;
  }

  static String ProperSlug(String raw) {
    return toProper(Slug(raw));
  }

  static String ProperSlug(String raw, String defaultValue) {
    return toProper(Slug(raw, defaultValue));
  }

  static String LowerSlug(String raw) {
    return Slug(raw).toLowerCase();
  }

  static String LowerSlug(String raw, String defaultValue) {
    if (raw == null) {
      return defaultValue.toLowerCase();
    }
    String out = Slug(raw).toLowerCase();
    if (out.length() > 0) {
      return out;
    } else {
      return defaultValue.toLowerCase();
    }
  }

  static String toProper(String from) {
    if (from.length() > 1) {
      String lower = from.toLowerCase();
      return lower.substring(0, 1).toUpperCase() + lower.substring(1);
    } else if (from.length() > 0) {
      return from.toUpperCase();
    } else {
      return "";
    }
  }

  static String UpperSlug(String raw) {
    return Slug(raw).toUpperCase();
  }

  static String UpperSlug(String raw, String defaultValue) {
    if (raw == null) {
      return defaultValue.toUpperCase();
    }
    String out = Slug(raw).toUpperCase();
    if (out.length() > 0) {
      return out;
    } else {
      return defaultValue.toUpperCase();
    }
  }

  static String Note(String raw) {
    Matcher m = nonNote.matcher(raw);
    return m.replaceAll("").trim();
  }
}
