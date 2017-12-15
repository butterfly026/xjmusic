// Copyright (c) 2017, XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.core.model.link_meme;

import io.xj.core.exception.BusinessException;
import io.xj.core.model.meme.Meme;
import io.xj.core.util.Text;

import java.math.BigInteger;

/**
 POJO for persisting data in memory while performing business logic,
or decoding messages received by JAX-RS resources.
 a.k.a. JSON input will be stored into an instance of this object
 <p>
 Business logic ought to be performed beginning with an instance of this object,
 to implement common methods.
 <p>
 NOTE: There can only be ONE of any getter/setter (with the same # of input params)
 */
public class LinkMeme extends Meme {

  /**
   For use in maps.
   */
  public static final String KEY_ONE = "linkMeme";
  public static final String KEY_MANY = "linkMemes";

  // Link ID
  private BigInteger linkId;

  public BigInteger getLinkId() {
    return linkId;
  }

  public LinkMeme setLinkId(BigInteger linkId) {
    this.linkId = linkId;
    return this;
  }

  public LinkMeme setName(String name) {
    this.name = Text.toProperSlug(name);
    return this;
  }

  @Override
  public void validate() throws BusinessException {
    if (null == linkId) {
      throw new BusinessException("Link ID is required.");
    }
    super.validate();
  }

  public static LinkMeme of(BigInteger linkId, String name) {
    return
      new LinkMeme()
        .setLinkId(linkId)
        .setName(name);
  }

}
