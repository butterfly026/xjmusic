// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.

package io.xj.hub.api;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.common.collect.ImmutableList;
import com.google.common.collect.ImmutableSet;
import com.google.inject.AbstractModule;
import com.google.inject.Guice;
import com.google.inject.util.Modules;
import com.typesafe.config.Config;
import io.xj.api.Account;
import io.xj.api.Library;
import io.xj.api.Program;
import io.xj.api.ProgramState;
import io.xj.api.ProgramType;
import io.xj.hub.access.HubAccess;
import io.xj.hub.access.HubAccessControlModule;
import io.xj.hub.dao.DAOException;
import io.xj.hub.dao.DAOModule;
import io.xj.hub.dao.ProgramDAO;
import io.xj.hub.ingest.HubIngestModule;
import io.xj.hub.persistence.HubPersistenceModule;
import io.xj.hub.HubTestConfiguration;
import io.xj.lib.app.AppException;
import io.xj.lib.app.Environment;
import io.xj.lib.entity.EntityFactory;
import io.xj.lib.entity.common.Topology;
import io.xj.lib.filestore.FileStoreModule;
import io.xj.lib.jsonapi.JsonapiException;
import io.xj.lib.jsonapi.JsonapiModule;
import io.xj.lib.jsonapi.JsonapiPayload;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.Mock;
import org.mockito.junit.MockitoJUnitRunner;

import javax.ws.rs.container.ContainerRequestContext;
import javax.ws.rs.core.Response;
import java.io.IOException;
import java.util.Collection;
import java.util.UUID;

import static io.xj.hub.access.HubAccess.CONTEXT_KEY;
import static io.xj.lib.jsonapi.AssertPayload.assertPayload;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;
import static org.mockito.Matchers.eq;
import static org.mockito.Matchers.same;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@RunWith(MockitoJUnitRunner.class)
public class ProgramEndpointTest {
  @Mock
  ContainerRequestContext crc;
  @Mock
  ProgramDAO programDAO;
  private HubAccess hubAccess;
  private ProgramEndpoint subject;
  private Library library25;
  private Library library1;

  @Before
  public void setUp() throws AppException {
    Config config = HubTestConfiguration.getDefault();
    var env = Environment.getDefault();
    var injector = Guice.createInjector(Modules.override(ImmutableSet.of(new HubAccessControlModule(), new DAOModule(), new HubIngestModule(), new HubPersistenceModule(), new JsonapiModule(), new FileStoreModule())).with(new AbstractModule() {
      @Override
      protected void configure() {
        bind(Config.class).toInstance(config);
        bind(Environment.class).toInstance(env);
        bind(ProgramDAO.class).toInstance(programDAO);
      }
    }));

    Topology.buildHubApiTopology(injector.getInstance(EntityFactory.class));
    var account1 = new Account()
      .id(UUID.randomUUID())
      ;
    hubAccess = HubAccess.create(ImmutableList.of(account1), "User,Artist");
    library25 = new Library()
      .id(UUID.randomUUID())
      ;
    library1 = new Library()
      .id(UUID.randomUUID())
      ;
    subject = injector.getInstance(ProgramEndpoint.class);
    injector.injectMembers(subject);
  }

  @Test
  public void readMany() throws DAOException, IOException, JsonapiException {
    when(crc.getProperty(CONTEXT_KEY)).thenReturn(hubAccess);
    Program program1 = new Program()
      .id(UUID.randomUUID())
      .libraryId(library25.getId())
      .type(ProgramType.MAIN)
      .state(ProgramState.PUBLISHED)
      .name("fonds")
      .key("C#")
      .tempo(120.0)
      .density(0.6)
      ;
    Program program2 = new Program()
      .id(UUID.randomUUID())
      .libraryId(library25.getId())
      .type(ProgramType.MAIN)
      .state(ProgramState.PUBLISHED)
      .name("trunk")
      .key("B")
      .tempo(120.0)
      .density(0.6)
      ;
    Collection<Program> programs = ImmutableList.of(program1, program2);
    when(programDAO.readMany(same(hubAccess), eq(ImmutableList.of(library25.getId()))))
      .thenReturn(programs);

    Response result = subject.readMany(crc, null, library25.getId().toString(), false);

    verify(programDAO).readMany(same(hubAccess), eq(ImmutableList.of(library25.getId())));
    assertEquals(200, result.getStatus());
    assertTrue(result.hasEntity());
    assertPayload(new ObjectMapper().readValue(String.valueOf(result.getEntity()), JsonapiPayload.class))
      .hasDataMany("programs", ImmutableList.of(program1.getId().toString(), program2.getId().toString()));
  }

  @Test
  public void readOne() throws DAOException, IOException, JsonapiException {
    when(crc.getProperty(CONTEXT_KEY)).thenReturn(hubAccess);
    Program program1 = new Program()
      .id(UUID.randomUUID())
      .libraryId(library1.getId())
      .type(ProgramType.MAIN)
      .state(ProgramState.PUBLISHED)
      .name("fonds")
      .key("C#")
      .tempo(120.0)
      .density(0.6)
      ;
    when(programDAO.readOne(same(hubAccess), eq(program1.getId()))).thenReturn(program1);

    Response result = subject.readOne(crc, program1.getId().toString(), "");

    assertEquals(200, result.getStatus());
    assertTrue(result.hasEntity());
    JsonapiPayload resultJsonapiPayload = new ObjectMapper().readValue(String.valueOf(result.getEntity()), JsonapiPayload.class);
    assertPayload(resultJsonapiPayload)
      .hasDataOne("programs", program1.getId().toString());
  }
}