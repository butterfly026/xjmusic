// Copyright (c) 2020, XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.craft.digest;

import com.google.common.collect.ImmutableList;
import com.google.inject.Injector;
import com.typesafe.config.Config;
import io.xj.core.CoreModule;
import io.xj.core.IntegrationTestingFixtures;
import io.xj.core.access.Access;
import io.xj.core.app.AppConfiguration;
import io.xj.core.dao.ProgramDAO;
import io.xj.core.dao.ProgramMemeDAO;
import io.xj.core.ingest.IngestFactory;
import io.xj.core.model.Chain;
import io.xj.core.model.ChainBinding;
import io.xj.core.model.Program;
import io.xj.core.model.ProgramState;
import io.xj.core.model.ProgramType;
import io.xj.core.testing.AppTestConfiguration;
import io.xj.core.testing.IntegrationTestProvider;
import io.xj.craft.CraftModule;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.runners.MockitoJUnitRunner;

import java.util.Collection;

import static org.junit.Assert.assertNotNull;

@RunWith(MockitoJUnitRunner.class)
public class DigestHashIT {
  private IngestFactory ingestFactory;
  private DigestFactory digestFactory;
  private IntegrationTestingFixtures fake;
  private Injector injector;
  private IntegrationTestProvider test;

  @Before
  public void setUp() throws Exception {
    Config config = AppTestConfiguration.getDefault();
    injector = AppConfiguration.inject(config, ImmutableList.of(new CoreModule(), new CraftModule()));
    test = injector.getInstance(IntegrationTestProvider.class);
    fake = new IntegrationTestingFixtures(test);

    test.reset();
    fake.insertFixtureA();

    fake.chain1 = Chain.create();

    ingestFactory = injector.getInstance(IngestFactory.class);
    digestFactory = injector.getInstance(DigestFactory.class);
  }

  @After
  public void tearDown() {
    test.shutdown();
  }

  @Test
  public void readHash_ofLibrary() throws Exception {
    Access access = Access.create(ImmutableList.of(fake.account1), "User,Artist");
    Collection<ChainBinding> entities = ImmutableList.of(ChainBinding.create(fake.chain1, fake.library10000001));

    DigestHash result = digestFactory.hashOf(ingestFactory.ingest(access, entities));

    assertNotNull(result);
  }

  @Test
  public void readHash_ofLibrary_afterUpdateEntity() throws Exception {
    Access access = Access.create(ImmutableList.of(fake.account1), "User,Artist");
    Collection<ChainBinding> entities = ImmutableList.of(ChainBinding.create(fake.chain1, fake.library10000001));
    injector.getInstance(ProgramDAO.class).update(Access.internal(), fake.program703.getId(),
      new Program()
        .setUserId(fake.program703.getUserId())
        .setLibraryId(fake.program703.getLibraryId())
        .setKey("G")
        .setDensity(1.0)
        .setStateEnum(ProgramState.Published)
        .setTypeEnum(ProgramType.Rhythm)
        .setName("new name")
        .setTempo(150.0));

    DigestHash result = digestFactory.hashOf(ingestFactory.ingest(access, entities));

    assertNotNull(result);
    Program updatedProgram = injector.getInstance(ProgramDAO.class).readOne(Access.internal(), fake.program703.getId());
    assertNotNull(updatedProgram);
  }

  @Test
  public void readHash_ofLibrary_afterDestroyEntity() throws Exception {
    Access access = Access.create(ImmutableList.of(fake.account1), "User,Artist");
    Collection<ChainBinding> entities = ImmutableList.of(ChainBinding.create(fake.chain1, fake.library10000001));
    injector.getInstance(ProgramMemeDAO.class).destroy(Access.internal(), fake.program701_meme0.getId());

    DigestHash result = digestFactory.hashOf(ingestFactory.ingest(access, entities));
  }

}
