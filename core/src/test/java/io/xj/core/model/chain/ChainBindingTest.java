//  Copyright (c) 2020, XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.core.model.chain;

import com.google.common.collect.ImmutableList;
import io.xj.core.CoreTest;
import io.xj.core.exception.CoreException;
import io.xj.core.model.Account;
import io.xj.core.model.Chain;
import io.xj.core.model.ChainBinding;
import io.xj.core.model.ChainBindingType;
import io.xj.core.model.Library;
import io.xj.core.model.Program;
import io.xj.core.model.ProgramMeme;
import org.junit.Rule;
import org.junit.Test;
import org.junit.rules.ExpectedException;

import java.util.UUID;

import static io.xj.core.testing.Assert.assertSameItems;
import static org.junit.Assert.assertEquals;

public class ChainBindingTest extends CoreTest {
  @Rule
  public ExpectedException failure = ExpectedException.none();

  @Test
  public void validate() throws Exception {
    new ChainBinding()
      .setChainId(UUID.randomUUID())
      .setTypeEnum(ChainBindingType.Library)
      .setTargetId(UUID.randomUUID())
      .validate();
  }

  @Test
  public void validate_failsWithoutChainId() throws Exception {
    failure.expect(CoreException.class);
    failure.expectMessage("Chain ID is required");

    new ChainBinding()
      .setTypeEnum(ChainBindingType.Library)
      .setTargetId(UUID.randomUUID())
      .validate();
  }

  @Test
  public void validate_failsWithInvalidTargetClass() throws Exception {
    failure.expect(CoreException.class);
    failure.expectMessage("not a valid entity");

    ProgramMeme target = ProgramMeme.create(Program.create(), "blue");

    ChainBinding.create(Chain.create(), target);
  }

  @Test
  public void validate_failsWithoutTargetClass() throws Exception {
    failure.expect(CoreException.class);
    failure.expectMessage("Type is required");

    new ChainBinding()
      .setChainId(UUID.randomUUID())
      .setTargetId(UUID.randomUUID())
      .validate();
  }

  @Test
  public void validate_failsWithoutTargetId() throws Exception {
    failure.expect(CoreException.class);
    failure.expectMessage("Chain-bound target ID is required");

    new ChainBinding()
      .setChainId(UUID.randomUUID())
      .setTypeEnum(ChainBindingType.Library)
      .validate();
  }

  @Test
  public void setTarget() throws CoreException {
    Library target = Library.create(Account.create(), "Bananas", now());

    ChainBinding subject = new ChainBinding().setTarget(target);

    assertEquals(ChainBindingType.Library, subject.getType());
    assertEquals(target.getId(), subject.getTargetId());
  }

  @Test
  public void fromEntity() throws CoreException {
    Library target = Library.create(Account.create(), "Bananas", now());

    ChainBinding subject = ChainBinding.create(Chain.create(), target);

    assertEquals(ChainBindingType.Library, subject.getType());
    assertEquals(target.getId(), subject.getTargetId());
  }

  @Test
  public void getPayloadAttributeNames() {
    assertSameItems(ImmutableList.of("type", "targetId"), new ChainBinding().getResourceAttributeNames());
  }

}
