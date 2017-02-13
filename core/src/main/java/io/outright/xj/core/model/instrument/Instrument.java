// Copyright (c) 2017, Outright Mental Inc. (http://outright.io) All Rights Reserved.
package io.outright.xj.core.model.instrument;

import io.outright.xj.core.app.exception.BusinessException;
import io.outright.xj.core.model.Entity;
import io.outright.xj.core.util.CSV.CSV;
import io.outright.xj.core.util.Purify;

import org.jooq.Field;
import org.jooq.types.ULong;

import com.google.api.client.util.Maps;
import com.google.common.collect.ImmutableList;

import java.math.BigInteger;
import java.util.List;
import java.util.Map;

import static io.outright.xj.core.Tables.INSTRUMENT;

public class Instrument extends Entity {
  public final static String PERCUSSIVE = "percussive";
  public final static String HARMONIC = "harmonic";
  public final static String MELODIC = "melodic";
  public final static String VOCAL = "vocal";

  public final static List<String> allTypes = ImmutableList.of(
    PERCUSSIVE,
    HARMONIC,
    MELODIC,
    VOCAL
  );

  // Description
  private String description;

  public String getDescription() {
    return description;
  }

  public Instrument setDescription(String description) {
    this.description = description;
    return this;
  }

  // Type
  private String type;

  public String getType() {
    return type;
  }

  public Instrument setType(String type) {
    this.type = Purify.LowerSlug(type);
    return this;
  }

  // Library
  private ULong libraryId;

  public ULong getLibraryId() {
    return libraryId;
  }

  public Instrument setLibraryId(BigInteger libraryId) {
    this.libraryId = ULong.valueOf(libraryId);
    return this;
  }

  // User
  private ULong userId;

  public ULong getUserId() {
    return userId;
  }

  public Instrument setUserId(BigInteger userId) {
    this.userId = ULong.valueOf(userId);
    return this;
  }

  // Density
  private Double density;

  public Double getDensity() {
    return density;
  }

  public Instrument setDensity(Double density) {
    this.density = density;
    return this;
  }

  /**
   * Validate data.
   *
   * @throws BusinessException if invalid.
   */
  public void validate() throws BusinessException {
    if (this.description == null || this.description.length() == 0) {
      throw new BusinessException("Name is required.");
    }
    if (this.libraryId == null) {
      throw new BusinessException("Library ID is required.");
    }
    if (this.userId == null) {
      throw new BusinessException("User ID is required.");
    }
    if (this.type == null || this.type.length() == 0) {
      throw new BusinessException("Type is required.");
    }
    if (!allTypes.contains(this.type)) {
      throw new BusinessException("'" + this.type + "' is not a valid type (" + CSV.join(allTypes) + ").");
    }
    if (this.density == null) {
      throw new BusinessException("Density is required.");
    }
  }

  /**
   * Model info jOOQ-field : Value map
   *
   * @return map
   */
  public Map<Field, Object> intoFieldValueMap() {
    Map<Field, Object> fieldValues = Maps.newHashMap();
    fieldValues.put(INSTRUMENT.DESCRIPTION, description);
    fieldValues.put(INSTRUMENT.LIBRARY_ID, libraryId);
    fieldValues.put(INSTRUMENT.USER_ID, userId);
    fieldValues.put(INSTRUMENT.TYPE, type);
    fieldValues.put(INSTRUMENT.DENSITY, density);
    return fieldValues;
  }

  @Override
  public String toString() {
    return "{" +
      "description:" + this.description +
      ", density:" + this.density +
      ", libraryId:" + this.libraryId +
      ", type:" + this.type +
      ", userId:" + this.userId +
      "}";
  }

  /**
   * For use in maps.
   */
  public static final String KEY_ONE = "instrument";
  public static final String KEY_MANY = "instruments";

}