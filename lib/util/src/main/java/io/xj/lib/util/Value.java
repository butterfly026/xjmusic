// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.lib.util;

import java.util.Collection;
import java.util.Objects;
import java.util.Set;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

public interface Value {
  String CHORD_SEPARATOR_DESCRIPTOR = ":";
  String CHORD_SEPARATOR_DESCRIPTOR_UNIT = "|";
  String CHORD_MARKER_NON_CHORD = "---";
  double entityPositionDecimalPlaces = 2.0;
  double roundPositionMultiplier = StrictMath.pow(10.0, entityPositionDecimalPlaces);
  Pattern isInteger = Pattern.compile("[0-9]+");

  /**
   Return the first value if it's non-null, else the second

   @param d1 to check if non-null and return
   @param d2 to default to, if s1 is null
   @return s1 if non-null, else s2
   */
  static Double eitherOr(Double d1, Double d2) {
    if (Objects.nonNull(d1) && !d1.isNaN() && !Objects.equals(d1, 0.0d))
      return d1;
    else
      return d2;
  }

  /**
   Return the first value if it's non-null, else the second

   @param s1 to check if non-null and return
   @param s2 to default to, if s1 is null
   @return s1 if non-null, else s2
   */
  static String eitherOr(String s1, String s2) {
    if (Objects.nonNull(s1) && !s1.isEmpty())
      return s1;
    else
      return s2;
  }

  /**
   Divide a set of integers by a double and return the divided set

   @param divisor   to divide by
   @param originals to divide
   @return divided originals
   */
  static Set<Integer> dividedBy(Double divisor, Set<Integer> originals) {
    return originals.stream().map(original -> (int) Math.floor(original / divisor)).collect(Collectors.toSet());
  }

  /**
   Calculate ratio (of 0 to 1) within a zero-to-N limit

   @param value to calculate radio of
   @param limit N where ratio will be calculated based on zero-to-N
   @return ratio between 0 and 1
   */
  static double ratio(double value, double limit) {
    return Math.max(Math.min(1, value / limit), 0);
  }

  /**
   True if input string is an integer

   @param raw text to check if it's an integer
   @return true if it's an integer
   */
  static Boolean isInteger(String raw) {
    return Text.isInteger.matcher(raw).matches();
  }

  /**
   Add an ID if not already added to list

   @param ids   list to which addition will be assured
   @param addId to ensure in list
   */
  static <N> void put(Collection<N> ids, N addId) {
    if (!ids.contains(addId)) ids.add(addId);
  }

  /**
   Add an ID if not already added to list

   @param ids    list to which addition will be assured
   @param addIds to ensure in list
   */
  static <N> void put(Collection<N> ids, Collection<N> addIds) {
    addIds.forEach(addId -> put(ids, addId));
  }

  /**
   Require a non-null value, or else throw an exception with the specified name

   @param notNull value
   @param name    to describe in exception
   @throws ValueException if null
   */
  static <V> void require(V notNull, String name) throws ValueException {
    if (Objects.isNull(notNull) || String.valueOf(notNull).isEmpty())
      throw new ValueException(String.format("%s is required.", name));
  }

  /**
   Require a minimum value, or else throw an exception with the specified name

   @param minimum threshold minimum
   @param value   value
   @param name    to describe in exception
   @throws ValueException if null
   */
  static void requireMinimum(Double minimum, Double value, String name) throws ValueException {
    if (value < minimum)
      throw new ValueException(String.format("%s must be at least %f", name, minimum));
  }

  /**
   Require a non-zero value, or else throw an exception with the specified name

   @param value value
   @param name  to describe in exception
   @throws ValueException if null
   */
  static <V> void requireNonZero(V value, String name) throws ValueException {
    if (Objects.isNull(value) || String.valueOf(value).isEmpty() || Double.valueOf(String.valueOf(value)).equals(0.0))
      throw new ValueException(String.format("Non-zero %s is required.", name));
  }

  /**
   allow only the specified values, or else throw an exception with the specified name

   @param value value
   @param name  to describe in exception
   @throws ValueException if null
   */
  static <V> void require(V value, String name, Collection<V> allowed) throws ValueException {
    require(value, name);
    if (!allowed.contains(value))
      throw new ValueException(String.format("%s '%s' is invalid.", name, value));
  }

  /**
   Require no exception is present, or else throw an exception with the specified name

   @param exception cannot be present
   @param name      to describe in exception
   @throws ValueException if exception is present
   */
  static <E extends Exception> void requireNo(E exception, String name) throws ValueException {
    if (Objects.nonNull(exception))
      throw new ValueException(String.format("%s is invalid because %s", name, exception.getMessage()));
  }

  /**
   Round a value to N decimal places.
   [#154976066] Architect wants to limit the floating point precision of chord and event position, in order to limit obsession over the position of things.

   @param value to round
   @return rounded position
   */
  static Double limitDecimalPrecision(Double value) {
    return Math.floor(value * roundPositionMultiplier) / roundPositionMultiplier;
  }

  /**
   Definitely not null, or string "null"

   @param obj to ingest for non-nullness
   @return true if non-null
   */
  static boolean isNonNull(Object obj) {
    return Objects.nonNull(obj) &&
      !Objects.equals("null", String.valueOf(obj));
  }
}