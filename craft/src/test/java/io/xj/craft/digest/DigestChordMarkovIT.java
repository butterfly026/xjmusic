// Copyright (c) 2020, XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.craft.digest;

import com.google.common.collect.ImmutableList;
import com.google.inject.Guice;
import io.xj.core.CoreModule;
import io.xj.core.FixtureIT;
import io.xj.core.access.Access;
import io.xj.core.ingest.IngestFactory;
import io.xj.core.model.Chain;
import io.xj.core.model.ChainBinding;
import io.xj.core.model.Library;
import io.xj.craft.CraftModule;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.runners.MockitoJUnitRunner;

import static org.junit.Assert.assertNotNull;

@RunWith(MockitoJUnitRunner.class)
public class DigestChordMarkovIT extends FixtureIT {
  private IngestFactory ingestFactory;
  private DigestFactory digestFactory;

  @Before
  public void setUp() throws Exception {
    reset();
    insertFixtureA();

    chain1 = Chain.create();

    injector = Guice.createInjector(new CoreModule(), new CraftModule());
    ingestFactory = injector.getInstance(IngestFactory.class);
    digestFactory = injector.getInstance(DigestFactory.class);
  }


  @Test
  public void digest() throws Exception {
    Access access = Access.create(ImmutableList.of(account1), "User,Artist");

    DigestChordMarkov result = digestFactory.chordMarkov(ingestFactory.ingest(access, ImmutableList.of(ChainBinding.create(chain1, library10000001))));

    assertNotNull(result);
  }

}
