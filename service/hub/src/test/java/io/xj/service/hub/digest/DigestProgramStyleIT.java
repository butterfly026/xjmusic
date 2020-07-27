// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.service.hub.digest;

import com.google.common.collect.ImmutableList;
import com.google.common.collect.ImmutableSet;
import com.google.inject.Injector;
import com.typesafe.config.Config;
import io.xj.lib.app.AppConfiguration;
import io.xj.lib.pubsub.FileStoreModule;
import io.xj.lib.jsonapi.JsonApiModule;
import io.xj.lib.mixer.MixerModule;
import io.xj.service.hub.IntegrationTestingFixtures;
import io.xj.service.hub.access.HubAccess;
import io.xj.service.hub.access.HubAccessControlModule;
import io.xj.service.hub.dao.DAOModule;
import io.xj.service.hub.dao.ProgramDAO;
import io.xj.service.hub.entity.ProgramSequence;
import io.xj.service.hub.entity.ProgramSequenceBinding;
import io.xj.service.hub.entity.ProgramSequenceChord;
import io.xj.service.hub.ingest.HubIngestFactory;
import io.xj.service.hub.ingest.HubIngestModule;
import io.xj.service.hub.persistence.HubPersistenceModule;
import io.xj.service.hub.testing.HubIntegrationTestModule;
import io.xj.service.hub.testing.HubIntegrationTestProvider;
import io.xj.service.hub.testing.HubTestConfiguration;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.runners.MockitoJUnitRunner;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

@RunWith(MockitoJUnitRunner.class)
public class DigestProgramStyleIT {
  private HubIngestFactory ingestFactory;
  private DigestFactory digestFactory;
  private ProgramDAO programDAO;

  private HubIntegrationTestProvider test;
  private IntegrationTestingFixtures fake;

  @Before
  public void setUp() throws Exception {
    Config config = HubTestConfiguration.getDefault();
    Injector injector = AppConfiguration.inject(config, ImmutableSet.of(new HubAccessControlModule(), new DAOModule(), new HubIngestModule(), new HubPersistenceModule(), new MixerModule(), new JsonApiModule(), new FileStoreModule(), new HubDigestModule(), new HubIntegrationTestModule()));
    test = injector.getInstance(HubIntegrationTestProvider.class);
    fake = new IntegrationTestingFixtures(test);

    test.reset();
    fake.insertFixtureB1();
    fake.insertFixtureB2();
    fake.insertFixtureB3();

    programDAO = injector.getInstance(ProgramDAO.class);
    ingestFactory = injector.getInstance(HubIngestFactory.class);
    digestFactory = injector.getInstance(DigestFactory.class);
  }

  @After
  public void tearDown() {
    test.shutdown();
  }

  @Test
  public void digest() throws Exception {
    HubAccess hubAccess = HubAccess.create(ImmutableList.of(fake.content.account1), "User,Artist");
    // Add two sequences to Main program 15
    fake.content.program15 = programDAO.readOne(HubAccess.internal(), fake.content.program15.getId());
    ProgramSequence sequence15c = test.insert(ProgramSequence.create(fake.content.program15, 32, "Encore", 0.5, "A major", 135.0));
    test.insert(ProgramSequenceChord.create(sequence15c, 0.0, "NC"));
    test.insert(ProgramSequenceBinding.create(sequence15c, 2));
    ProgramSequence sequence15d = test.insert(ProgramSequence.create(fake.content.program15, 32, "Encore", 0.5, "A major", 135.0));
    test.insert(ProgramSequenceChord.create(sequence15d, 0.0, "NC"));
    test.insert(ProgramSequenceBinding.create(sequence15d, 3));
    programDAO.update(HubAccess.internal(), fake.content.program15.getId(), fake.content.program15);


    DigestProgramStyle result = digestFactory.programStyle(ingestFactory.ingest(hubAccess, ImmutableSet.of(fake.content.library2.getId()), ImmutableSet.of(), ImmutableSet.of()));

    assertNotNull(result);
    assertEquals(2.0, result.getMainSequencesPerProgramStats().min(), 0.1);
    assertEquals(4.0, result.getMainSequencesPerProgramStats().max(), 0.1);
    assertEquals(3.0, result.getMainSequencesPerProgramStats().mean(), 0.1);
    assertEquals(2.0, result.getMainSequencesPerProgramStats().count(), 0.1);
    assertEquals(1, result.getMainSequencesPerProgramHistogram().count(2));
    assertEquals(1, result.getMainSequencesPerProgramHistogram().count(4));
    assertEquals(0, result.getMainSequencesPerProgramHistogram().count(1));
    assertEquals(16.0, result.getMainSequenceTotalStats().min(), 0.1);
    assertEquals(32.0, result.getMainSequenceTotalStats().max(), 0.1);
    assertEquals(26.6, result.getMainSequenceTotalStats().mean(), 0.1);
    assertEquals(6.0, result.getMainSequenceTotalStats().count(), 0.1);
    assertEquals(2, result.getMainSequenceTotalHistogram().count(16));
    assertEquals(4, result.getMainSequenceTotalHistogram().count(32));
  }

}
