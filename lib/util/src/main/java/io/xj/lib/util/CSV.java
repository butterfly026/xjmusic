// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.lib.util;

import com.google.common.collect.ImmutableList;
import com.google.common.collect.ImmutableMap;
import com.google.common.collect.Lists;

import java.util.*;
import java.util.stream.Collectors;

public interface CSV {
  static Collection<String> split(String csv) {
    return Arrays.asList(csv.split(","));
  }

  static Collection<String> splitProperSlug(String csv) {
    List<String> items = Arrays.asList(csv.split(","));
    ImmutableList.Builder<String> slugs = new ImmutableList.Builder<>();
    items.stream().filter(item -> Objects.nonNull(item) && !item.isEmpty()).map(Text::toProperSlug).forEach(slugs::add);
    return slugs.build();
  }

  static String join(Collection<String> parts) {
    return String.join(",", parts);
  }

  @SafeVarargs
  static <E extends Enum<E>> String joinEnum(E... objects) {
    List<String> objectStrings = Arrays.stream(objects).filter(Objects::nonNull).map(Enum::toString).collect(Collectors.toList());
    return join(objectStrings);
  }

  /**
   write a collection of ids to a CSV string

   @param ids to write
   @return CSV of ids
   */
  static <T> String fromStringsOf(Collection<T> ids) {
    if (Objects.isNull(ids) || ids.isEmpty()) {
      return "";
    }
    Iterator<T> it = ids.iterator();
    StringBuilder result = new StringBuilder(it.next().toString());
    while (it.hasNext()) {
      result.append(",").append(it.next());
    }
    return result.toString();
  }

  /**
   Get a CSV string of key=value properties

   @param properties key=value
   @return CSV string
   */
  static String from(ImmutableMap<String, String> properties) {
    Collection<String> pieces = Lists.newArrayList();
    properties.forEach((key, value) -> pieces.add(String.format("%s=%s", key, value)));
    return join(pieces);
  }
}