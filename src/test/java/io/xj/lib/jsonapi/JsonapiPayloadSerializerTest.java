// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.lib.jsonapi;

import com.google.common.collect.ImmutableList;
import com.google.common.collect.ImmutableSet;
import com.google.inject.AbstractModule;
import com.google.inject.Guice;
import com.typesafe.config.Config;
import com.typesafe.config.ConfigFactory;
import io.xj.Program;
import io.xj.lib.entity.EntityFactory;
import org.junit.Before;
import org.junit.Test;

import java.util.UUID;

import static org.junit.Assert.assertFalse;

/**
 Payload serializer test
 <p>
 Created by Charney Kaye on 2020/03/09
 */
public class JsonapiPayloadSerializerTest {
  private JsonapiPayloadFactory jsonapiPayloadFactory;
  private EntityFactory entityFactory;

  @Before
  public void setUp() {
    var injector = Guice.createInjector(new JsonApiModule(), new AbstractModule() {
      @Override
      protected void configure() {
        bind(Config.class).toInstance(ConfigFactory.empty());
      }
    });
    entityFactory = injector.getInstance(EntityFactory.class);
    jsonapiPayloadFactory = injector.getInstance(JsonapiPayloadFactory.class);
    entityFactory.register(Program.class);
  }

  @Test
  public void serialize() throws JsonApiException {
    Program program = Program.newBuilder()
      .setId(UUID.randomUUID().toString())
      .setName("test_print")
      .build();
    JsonapiPayload jsonapiPayload = jsonapiPayloadFactory.setDataEntity(jsonapiPayloadFactory.newJsonapiPayload(), program);

    String result = jsonapiPayloadFactory.serialize(jsonapiPayload);

    AssertPayload.assertPayload(jsonapiPayloadFactory.deserialize(result))
      .hasDataOne("programs", program.getId());
  }

  @Test
  public void serializeOne() throws JsonApiException {
    JsonapiPayload jsonapiPayload = jsonapiPayloadFactory.newJsonapiPayload();
    Program library = Program.newBuilder()
      .setId(UUID.randomUUID().toString())
      .setName("Test Program")
      .build();
    jsonapiPayloadFactory.setDataEntity(jsonapiPayload, library);

    String result = jsonapiPayloadFactory.serialize(jsonapiPayload);

    AssertPayload.assertPayload(jsonapiPayloadFactory.deserialize(result))
      .hasDataOne("programs", library.getId());
  }

  @Test
  public void serializeOne_withBelongsTo() throws JsonApiException {
    entityFactory.register("Library");
    entityFactory.register("Program").belongsTo("Library");
    JsonapiPayload jsonapiPayload = jsonapiPayloadFactory.newJsonapiPayload();
    Program library = Program.newBuilder()
      .setId(UUID.randomUUID().toString())
      .setName("y")
      .build();
    Program program = Program.newBuilder()
      .setId(UUID.randomUUID().toString())
      .setLibraryId(library.getId())
      .setName("x")
      .build();
    jsonapiPayloadFactory.setDataEntity(jsonapiPayload, program);

    String result = jsonapiPayloadFactory.serialize(jsonapiPayload);

    AssertPayload.assertPayload(jsonapiPayloadFactory.deserialize(result))
      .hasDataOne("programs", program.getId())
      .belongsTo("Library", library.getId());
  }

  /**
   [#175792528] JSON:API serializer must not include relationship payload where there is none
   */
  @Test
  public void serializeOne_withBelongsTo_empty() throws JsonApiException {
    entityFactory.register("Library");
    entityFactory.register("Program").belongsTo("Library");
    JsonapiPayload jsonapiPayload = jsonapiPayloadFactory.newJsonapiPayload();
    Program program = Program.newBuilder()
      .setId(UUID.randomUUID().toString())
      .setLibraryId("")
      .setName("x")
      .build();
    jsonapiPayloadFactory.setDataEntity(jsonapiPayload, program);

    String result = jsonapiPayloadFactory.serialize(jsonapiPayload);

    assertFalse(result.contains("libraries"));
  }

  @Test
  public void serializeOne_withHasMany() throws JsonApiException {
    entityFactory.register("Program").hasMany("Program");
    Program program0 = Program.newBuilder()
      .setId(UUID.randomUUID().toString())
      .setName("y")
      .build();
    Program program1 = Program.newBuilder()
      .setId(UUID.randomUUID().toString())
      .setLibraryId(program0.getId())
      .setName("x")
      .build();
    Program program2 = Program.newBuilder()
      .setId(UUID.randomUUID().toString())
      .setLibraryId(program1.getId())
      .setName("b")
      .build();
    Program program3 = Program.newBuilder()
      .setId(UUID.randomUUID().toString())
      .setLibraryId(program1.getId())
      .setName("c")
      .build();
    JsonapiPayloadObject mainObj = jsonapiPayloadFactory.toPayloadObject(program1, ImmutableSet.of(program2, program3));
    JsonapiPayload jsonapiPayload = jsonapiPayloadFactory.newJsonapiPayload().setDataOne(mainObj);
    jsonapiPayloadFactory.addIncluded(jsonapiPayload, jsonapiPayloadFactory.toPayloadObject(program2));
    jsonapiPayloadFactory.addIncluded(jsonapiPayload, jsonapiPayloadFactory.toPayloadObject(program3));

    String result = jsonapiPayloadFactory.serialize(jsonapiPayload);

    JsonapiPayload resultJsonapiPayload = jsonapiPayloadFactory.deserialize(result);
    AssertPayload.assertPayload(resultJsonapiPayload)
      .hasIncluded("programs", ImmutableList.of(program2, program3))
      .hasDataOne("programs", program1.getId());
  }

  @Test
  public void serializeMany() throws JsonApiException {
    JsonapiPayload jsonapiPayload = jsonapiPayloadFactory.newJsonapiPayload();
    Program accountA = Program.newBuilder()
      .setId(UUID.randomUUID().toString())
      .setName("Test Program A")
      .build();
    Program accountB = Program.newBuilder()
      .setId(UUID.randomUUID().toString())
      .setName("Test Program B")
      .build();
    Program accountC = Program.newBuilder()
      .setId(UUID.randomUUID().toString())
      .setName("Test Program C")
      .build();
    jsonapiPayloadFactory.setDataEntities(jsonapiPayload, ImmutableList.of(accountA, accountB, accountC));

    String result = jsonapiPayloadFactory.serialize(jsonapiPayload);

    AssertPayload.assertPayload(jsonapiPayloadFactory.deserialize(result))
      .hasDataMany("programs", ImmutableList.of(
        accountA.getId(),
        accountB.getId(),
        accountC.getId()))
      .hasIncluded("programs", ImmutableList.of());
  }

}
