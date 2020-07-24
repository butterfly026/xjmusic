// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.

package io.xj.service.hub.client;

import com.github.tomakehurst.wiremock.junit.WireMockRule;
import com.github.tomakehurst.wiremock.matching.EqualToPattern;
import com.google.common.collect.ImmutableList;
import com.google.common.collect.ImmutableMap;
import com.google.common.collect.ImmutableSet;
import com.google.inject.AbstractModule;
import com.google.inject.Guice;
import com.google.inject.Injector;
import com.typesafe.config.Config;
import com.typesafe.config.ConfigFactory;
import com.typesafe.config.ConfigValueFactory;
import io.xj.lib.entity.Entity;
import io.xj.lib.entity.EntityFactory;
import io.xj.lib.entity.EntityModule;
import io.xj.lib.jsonapi.JsonApiModule;
import io.xj.lib.jsonapi.MediaType;
import io.xj.lib.jsonapi.PayloadFactory;
import io.xj.lib.jsonapi.JsonApiException;
import io.xj.service.hub.HubContentFixtures;
import io.xj.service.hub.HubApp;
import io.xj.service.hub.entity.*;
import org.junit.Before;
import org.junit.Rule;
import org.junit.Test;

import java.util.Collection;

import static com.github.tomakehurst.wiremock.client.WireMock.*;
import static org.junit.Assert.assertEquals;

/**
 [#171553408] XJ Mk3 Distributed Architecture
 <p>
 HubClient** allows a service that depends on Hub (e.g. Nexus) to connect to the Hub REST API via an HTTP client and deserialize results into usable entities
 */
public class HubClientImplTest {
  @Rule
  public WireMockRule wireMockRule = new WireMockRule(8089); // No-args constructor defaults to port 8080

  PayloadFactory payloadFactory;

  HubClient subject;
  private HubContentFixtures content;
  private Collection<? extends Entity> hubEntities;

  @Before
  public void setUp() throws Exception {
    Config config = ConfigFactory.parseResources("test.conf")
      .withValue("access.tokenName", ConfigValueFactory.fromAnyRef("access_token"))
      .withValue("hub.baseUrl", ConfigValueFactory.fromAnyRef("http://localhost:8089/"))
      .withValue("hub.internalToken", ConfigValueFactory.fromAnyRef("internal_secret_456"));

    Injector injector = Guice.createInjector(
      ImmutableSet.of(
        new HubClientModule(),
        new EntityModule(),
        new JsonApiModule(),
        new AbstractModule() {
          @Override
          protected void configure() {
            bind(Config.class).toInstance(config);
          }
        }));
    HubApp.buildApiTopology(injector.getInstance(EntityFactory.class));
    content = new HubContentFixtures();
    payloadFactory = injector.getInstance(PayloadFactory.class);
    subject = injector.getInstance(HubClient.class);
    hubEntities = content.setupFixtureB1(false);
  }

  @Test
  public void ingest() throws JsonApiException, HubClientException {
    String hubContentBody = payloadFactory.serialize(payloadFactory.newPayload()
      .setDataMany(payloadFactory.toPayloadObjects(hubEntities)));
    stubFor(com.github.tomakehurst.wiremock.client.WireMock.get(urlPathEqualTo("/ingest"))
      .withQueryParams(ImmutableMap.of(
        "libraryIds", new EqualToPattern(content.library2.getId().toString()),
        "programIds", new EqualToPattern(""),
        "instrumentIds", new EqualToPattern("")
      ))
      .withHeader("Cookie", equalTo("access_token=internal_secret_456"))
      .willReturn(aResponse()
        .withStatus(200)
        .withHeader("Content-Type", MediaType.APPLICATION_JSON)
        .withBody(hubContentBody)));
    HubClientAccess access = HubClientAccess.create(content.user2, ImmutableList.of(content.account1), "Artist")
      .setToken("secret_token_123");

    HubContent result = subject.ingest(access, ImmutableSet.of(content.library2.getId()), ImmutableSet.of(), ImmutableSet.of());

    assertEquals(45, result.getAllEntities().size());
    assertEquals(0, result.getAllInstrumentAudioChords().size());
    assertEquals(0, result.getAllInstrumentAudios().size());
    assertEquals(0, result.getAllInstrumentAudioEvents().size());
    assertEquals(0, result.getAllInstruments().size());
    assertEquals(0, result.getAllInstrumentMemes().size());
    assertEquals(5, result.getAllPrograms().size());
    assertEquals(8, result.getAllProgramSequencePatternEvents().size());
    assertEquals(3, result.getAllProgramMemes().size());
    assertEquals(2, result.getAllProgramSequencePatterns().size());
    assertEquals(5, result.getAllProgramSequenceBindings().size());
    assertEquals(6, result.getAllProgramSequenceBindingMemes().size());
    assertEquals(5, result.getAllProgramSequenceChords().size());
    assertEquals(6, result.getAllProgramSequences().size());
    assertEquals(4, result.getAllProgramTracks().size());
    assertEquals(1, result.getAllProgramVoices().size());
  }

  @Test
  public void auth() throws HubClientException {
    User user1 = User.create();
    Account account1 = Account.create();
    UserAuth userAuth1 = UserAuth.create(user1, UserAuthType.Google);
    stubFor(com.github.tomakehurst.wiremock.client.WireMock.any(urlEqualTo("/auth"))
      .withHeader("Cookie", equalTo("access_token=secret_token_123"))
      .willReturn(aResponse()
        .withStatus(200)
        .withHeader("Content-Type", MediaType.APPLICATION_JSON)
        .withBody(String.format("{\"userAuthId\":\"%s\",\"roles\":\"User,Admin\",\"accountIds\":[\"%s\"],\"userId\":\"%s\"}",
          userAuth1.getId(), account1.getId(), user1.getId()))));

    HubClientAccess result = subject.auth("secret_token_123");

    assertEquals(2, result.getRoleTypes().size());
    assertEquals(UserRoleType.User, result.getRoleTypes().toArray()[0]);
    assertEquals(UserRoleType.Admin, result.getRoleTypes().toArray()[1]);
    assertEquals(1, result.getAccountIds().size());
    assertEquals(account1.getId(), result.getAccountIds().toArray()[0]);
    assertEquals(user1.getId(), result.getUserId());
    assertEquals(userAuth1.getId(), result.getUserAuthId());
  }
}