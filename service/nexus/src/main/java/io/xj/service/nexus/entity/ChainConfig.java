// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.service.nexus.entity;

import io.xj.lib.entity.Entity;
import io.xj.lib.util.Text;
import io.xj.lib.util.Value;
import io.xj.lib.util.ValueException;

import java.util.Objects;
import java.util.UUID;

/**
 [#160980748] Developer wants all chain binding models to extend `ChainBinding` with common properties and methods pertaining to Chain membership.
 <p>
 POJO for persisting data in memory while performing business logic,
 or decoding messages received by JAX-RS resources.
 a.k.a. JSON input will be stored into an instance of this object
 <p>
 Business logic ought to be performed beginning with an instance of this object,
 to implement common methods.
 <p>
 NOTE: There can only be ONE of any getter/setter (with the same # of input params)
 */
public class ChainConfig extends Entity {
  private ChainConfigType type;
  private String value;
  private Exception typeException;
  private UUID chainId;

  /**
   Create a new ChainConfig

   @return new ChainConfig
   */
  public static ChainConfig create() {
    return (ChainConfig) new ChainConfig().setId(UUID.randomUUID());
  }

  /**
   Create a new ChainConfig

   @param chain of ChainConfig
   @param type  of ChainConfig
   @param value of ChainConfig
   @return new ChainConfig
   */
  public static ChainConfig create(Chain chain, ChainConfigType type, String value) {
    return create()
      .setChainId(chain.getId())
      .setTypeEnum(type)
      .setValue(value);
  }

  /**
   Get id of Chain to which this entity belongs

   @return chain id
   */
  public UUID getChainId() {
    return chainId;
  }

  /**
   Set id of Chain to which this entity belongs

   @param chainId to which this entity belongs
   @return this Chain Entity (for chaining setters)
   */
  public ChainConfig setChainId(UUID chainId) {
    this.chainId = chainId;
    return this;
  }

  /**
   Get type

   @return type
   */
  public ChainConfigType getType() {
    return type;
  }

  /**
   Get value

   @return value
   */
  public String getValue() {
    return value;
  }

  /**
   @param typeString pending validation
   */
  public ChainConfig setType(String typeString) {
    try {
      type = ChainConfigType.validate(typeString);
    } catch (ValueException e) {
      typeException = e;
    }
    return this;
  }

  /**
   Set type enum

   @param type enum to set
   @return self
   */
  public ChainConfig setTypeEnum(ChainConfigType type) {
    this.type = type;
    return this;
  }

  /**
   Set value

   @param value to set
   @return self
   */
  public ChainConfig setValue(String value) {
    this.value = value;
    return this;
  }

  @Override
  public void validate() throws ValueException {
    super.validate();

    Value.require(chainId, "Chain ID");

    Value.requireNo(typeException, "Type");
    Value.require(type, "Type");

    if (Objects.isNull(value) || value.isEmpty())
      throw new ValueException("Value is required.");

    switch (type) {
      case OutputSampleBits:
      case OutputFrameRate:
      case OutputChannels:
      case OutputEncodingQuality:
        value = Text.toNumeric(value);
        Value.require(value, String.format("Chain %s requires numeric value!", type));
        break;

      case OutputEncoding:
      case OutputContainer:
        value = Text.toAlphaSlug(value).toUpperCase();
        Value.require(value, String.format("Chain %s requires text value!", type));
        break;
    }
  }

  @Override
  public String toString() {
    return String.format("Config[%s=%s]", type, value);
  }

}
