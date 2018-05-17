// Copyright (c) 2018, XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.core.model.library;

import io.xj.core.exception.BusinessException;
import io.xj.core.model.entity.EntityWrapper;

import java.util.Objects;

/**
 Wrapper for use as POJO for decoding messages received by JAX-RS resources
 a.k.a. JSON input will be stored into an entity inside this object
 */
public class LibraryWrapper extends EntityWrapper {

  // Library
  private Library library;

  public Library getLibrary() {
    return library;
  }

  public LibraryWrapper setLibrary(Library library) {
    this.library = library;
    return this;
  }

  /**
   Validate data.

   @throws BusinessException if invalid.
   */
  @Override
  public Library validate() throws BusinessException {
    if (Objects.isNull(library)) {
      throw new BusinessException("Library is required.");
    }
    library.validate();
    return library;
  }

}
