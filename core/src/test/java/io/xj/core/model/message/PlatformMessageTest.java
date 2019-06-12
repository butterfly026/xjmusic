//  Copyright (c) 2019, XJ Music Inc. (https://xj.io) All Rights Reserved.

package io.xj.core.model.message;

import com.google.common.collect.ImmutableList;
import io.xj.core.model.message.platform.PlatformMessage;
import org.junit.Test;

import static io.xj.core.testing.Assert.assertSameItems;

public class PlatformMessageTest {

  @Test
  public void getPayloadAttributeNames() {
    assertSameItems(ImmutableList.of("type", "createdAt", "updatedAt", "body"), new PlatformMessage().getResourceAttributeNames());
  }
}
