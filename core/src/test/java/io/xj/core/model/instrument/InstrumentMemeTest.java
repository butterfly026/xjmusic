//  Copyright (c) 2020, XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.core.model.instrument;

import com.google.common.collect.ImmutableList;
import io.xj.core.exception.CoreException;
import io.xj.core.model.InstrumentMeme;
import org.junit.Rule;
import org.junit.Test;
import org.junit.rules.ExpectedException;

import java.util.UUID;

import static io.xj.core.testing.Assert.assertSameItems;

public class InstrumentMemeTest {

  @Rule
  public ExpectedException failure = ExpectedException.none();

  @Test
  public void validate() throws Exception {
    new InstrumentMeme()
      .setName("MicrophoneCheckOneTwoOneTwo")
      .setInstrumentId(UUID.randomUUID())
      .validate();
  }

  @Test
  public void validate_failsWithoutInstrumentID() throws Exception {
    failure.expect(CoreException.class);
    failure.expectMessage("Instrument ID is required");

    new InstrumentMeme()
      .setName("MicrophoneCheckOneTwoOneTwo")
      .validate();
  }

  @Test
  public void validate_failsWithoutName() throws Exception {
    failure.expect(CoreException.class);
    failure.expectMessage("Name is required");

    new InstrumentMeme()
      .setInstrumentId(UUID.randomUUID())
      .validate();
  }

  @Test
  public void getPayloadAttributeNames() {
    assertSameItems(ImmutableList.of("name"), new InstrumentMeme().getResourceAttributeNames());
  }

}
