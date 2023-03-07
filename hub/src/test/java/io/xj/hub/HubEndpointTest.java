// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.

package io.xj.hub;


import io.xj.hub.access.HubAccess;
import io.xj.hub.manager.Manager;
import io.xj.hub.manager.ManagerException;
import io.xj.hub.persistence.HubSqlStoreProvider;
import io.xj.hub.tables.pojos.Account;
import io.xj.lib.app.AppEnvironment;
import io.xj.lib.entity.EntityFactoryImpl;
import io.xj.lib.json.ApiUrlProvider;
import io.xj.lib.json.JsonProvider;
import io.xj.lib.json.JsonProviderImpl;
import io.xj.lib.jsonapi.*;
import io.xj.lib.util.ValueException;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.Mock;
import org.mockito.junit.MockitoJUnitRunner;
import org.springframework.http.HttpStatus;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import static io.xj.hub.IntegrationTestingFixtures.buildAccount;
import static io.xj.hub.access.HubAccess.CONTEXT_KEY;
import static org.junit.Assert.assertEquals;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.same;
import static org.mockito.Mockito.*;

@RunWith(MockitoJUnitRunner.class)
public class HubEndpointTest {
  private JsonapiPayloadFactory payloadFactory;

  @Mock
  HttpServletRequest req;
  @Mock
  HttpServletResponse res;

  @Mock
  Manager<Account> manager; // can be any class that, we picked a simple one with no belongs-to

  @Mock
  HubSqlStoreProvider sqlStoreProvider;

  //
  HubJsonapiEndpoint subject;

  @Before
  public void setUp() throws Exception {
    var env = AppEnvironment.getDefault();
    JsonProvider jsonProvider = new JsonProviderImpl();
    var entityFactory = new EntityFactoryImpl(jsonProvider);
    payloadFactory = new JsonapiPayloadFactoryImpl(entityFactory);
    HubTopology.buildHubApiTopology(entityFactory);
    ApiUrlProvider apiUrlProvider = new ApiUrlProvider(env);
    JsonapiResponseProvider responseProvider = new JsonapiResponseProviderImpl(apiUrlProvider);
    subject = new HubJsonapiEndpoint(sqlStoreProvider, responseProvider, payloadFactory, entityFactory);
  }

  @Test
  public void create() throws JsonapiException, ValueException, ManagerException {
    HubAccess access = HubAccess.internal();
    JsonapiPayload jsonapiPayload = payloadFactory.newJsonapiPayload()
      .setDataOne(payloadFactory.newPayloadObject()
        .setType(Account.class)
        .setAttribute("name", "test5"));
    when(req.getAttribute(CONTEXT_KEY)).thenReturn(access);
    when(manager.newInstance()).thenReturn(buildAccount("Testing"));
    var createdAccount = buildAccount("Testing");
    createdAccount.setName("test5");
    when(manager.create(same(access), any(Account.class))).thenReturn(createdAccount);

    var result = subject.create(req, manager, jsonapiPayload);

    verify(manager, times(1)).create(same(access), any(Account.class));
    assertEquals(HttpStatus.CREATED, result.getStatusCode());
    JsonapiPayload resultJsonapiPayload = result.getBody();
    (new AssertPayload(resultJsonapiPayload)).hasDataOne(createdAccount);
  }
}
