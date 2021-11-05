// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.hub;

import io.xj.hub.tables.pojos.*;
import io.xj.lib.entity.EntityFactory;

/**
 In the future, we will simplify JSON payload
 deprecating this complex abstraction of JSON:API
 in favor of plain POJO
 */
public enum HubTopology {
  ;

  /**
   Given an entity factory, build the Hub REST API entity topology

   @param entityFactory to build topology on
   */
  public static void buildHubApiTopology(EntityFactory entityFactory) {
    // Account
    entityFactory.register(Account.class)
      .createdBy(Account::new)
      .withAttribute("name")
      .hasMany(Library.class)
      .hasMany(AccountUser.class);

    // AccountUser
    entityFactory.register(AccountUser.class)
      .createdBy(AccountUser::new)
      .belongsTo(Account.class)
      .belongsTo(User.class);

    // Instrument
    entityFactory.register(Instrument.class)
      .createdBy(Instrument::new)
      .withAttribute("state")
      .withAttribute("type")
      .withAttribute("name")
      .withAttribute("density")
      .withAttribute("config")
      .belongsTo(User.class)
      .belongsTo(Library.class)
      .hasMany(InstrumentAudio.class)
      .hasMany(InstrumentMeme.class);

    // InstrumentAudio
    entityFactory.register(InstrumentAudio.class)
      .createdBy(InstrumentAudio::new)
      .withAttribute("waveformKey")
      .withAttribute("name")
      .withAttribute("start")
      .withAttribute("length")
      .withAttribute("tempo")
      .withAttribute("density")
      .withAttribute("volume")
      .withAttribute("note")
      .withAttribute("event")
      .belongsTo(Instrument.class);

    // InstrumentMeme
    entityFactory.register(InstrumentMeme.class)
      .createdBy(InstrumentMeme::new)
      .withAttribute("name")
      .belongsTo(Instrument.class);

    // Library
    entityFactory.register(Library.class)
      .createdBy(Library::new)
      .withAttribute("name")
      .belongsTo(Account.class)
      .hasMany(Instrument.class)
      .hasMany(Program.class);

    // Program
    entityFactory.register(Program.class)
      .createdBy(Program::new)
      .withAttribute("state")
      .withAttribute("key")
      .withAttribute("tempo")
      .withAttribute("type")
      .withAttribute("name")
      .withAttribute("density")
      .withAttribute("config")
      .belongsTo(User.class)
      .belongsTo(Library.class)
      .hasMany(ProgramMeme.class)
      .hasMany(ProgramSequence.class)
      .hasMany(ProgramSequenceChord.class)
      .hasMany(ProgramSequencePattern.class)
      .hasMany(ProgramVoiceTrack.class)
      .hasMany(ProgramSequencePatternEvent.class)
      .hasMany(ProgramSequenceBinding.class)
      .hasMany(ProgramSequenceBindingMeme.class)
      .hasMany(ProgramVoice.class);

    // ProgramMeme
    entityFactory.register(ProgramMeme.class)
      .createdBy(ProgramMeme::new)
      .withAttribute("name")
      .belongsTo(Program.class);

    // ProgramSequence
    entityFactory.register(ProgramSequence.class)
      .createdBy(ProgramSequence::new)
      .withAttribute("name")
      .withAttribute("key")
      .withAttribute("density")
      .withAttribute("total")
      .withAttribute("tempo")
      .belongsTo(Program.class)
      .hasMany(ProgramSequencePattern.class)
      .hasMany(ProgramSequenceBinding.class)
      .hasMany(ProgramSequenceChord.class);

    // ProgramSequenceBinding
    entityFactory.register(ProgramSequenceBinding.class)
      .createdBy(ProgramSequenceBinding::new)
      .withAttribute("offset")
      .belongsTo(Program.class)
      .belongsTo(ProgramSequence.class)
      .hasMany(ProgramSequenceBindingMeme.class);

    // ProgramSequenceBindingMeme
    entityFactory.register(ProgramSequenceBindingMeme.class)
      .createdBy(ProgramSequenceBindingMeme::new)
      .withAttribute("name")
      .belongsTo(Program.class)
      .belongsTo(ProgramSequenceBinding.class);

    // ProgramSequenceChord
    entityFactory.register(ProgramSequenceChord.class)
      .createdBy(ProgramSequenceChord::new)
      .withAttribute("name")
      .withAttribute("position")
      .belongsTo(Program.class)
      .belongsTo(ProgramSequence.class);

    // ProgramSequenceChordVoicing
    entityFactory.register(ProgramSequenceChordVoicing.class)
      .createdBy(ProgramSequenceChordVoicing::new)
      .withAttribute("type")
      .withAttribute("notes")
      .belongsTo(Program.class)
      .belongsTo(ProgramSequenceChord.class);

    // ProgramSequencePattern
    entityFactory.register(ProgramSequencePattern.class)
      .createdBy(ProgramSequencePattern::new)
      .withAttribute("total")
      .withAttribute("name")
      .belongsTo(Program.class)
      .belongsTo(ProgramSequence.class)
      .belongsTo(ProgramVoice.class)
      .hasMany(ProgramSequencePatternEvent.class);

    // ProgramSequencePatternEvent
    entityFactory.register(ProgramSequencePatternEvent.class)
      .createdBy(ProgramSequencePatternEvent::new)
      .withAttribute("duration")
      .withAttribute("note")
      .withAttribute("position")
      .withAttribute("velocity")
      .belongsTo(Program.class)
      .belongsTo(ProgramSequencePattern.class)
      .belongsTo(ProgramVoiceTrack.class);

    // ProgramVoice
    entityFactory.register(ProgramVoice.class)
      .createdBy(ProgramVoice::new)
      .withAttribute("type")
      .withAttribute("name")
      .withAttribute("order")
      .belongsTo(Program.class)
      .hasMany(ProgramSequencePattern.class);

    // ProgramVoiceTrack
    entityFactory.register(ProgramVoiceTrack.class)
      .createdBy(ProgramVoiceTrack::new)
      .withAttribute("name")
      .withAttribute("order")
      .belongsTo(Program.class)
      .belongsTo(ProgramVoice.class)
      .hasMany(ProgramSequencePatternEvent.class);

    // User
    entityFactory.register(User.class)
      .createdBy(User::new)
      .withAttribute("name")
      .withAttribute("roles")
      .withAttribute("email")
      .withAttribute("avatarUrl")
      .hasMany(UserAuth.class)
      .hasMany(UserAuthToken.class);

    // UserAuth
    entityFactory.register(UserAuth.class)
      .createdBy(UserAuth::new)
      .withAttribute("type")
      .withAttribute("externalAccessToken")
      .withAttribute("externalRefreshToken")
      .withAttribute("externalAccount")
      .belongsTo(User.class);

    // UserAuthToken
    entityFactory.register(UserAuthToken.class)
      .createdBy(UserAuthToken::new)
      .withAttribute("accessToken")
      .belongsTo(User.class)
      .belongsTo(UserAuth.class);

    // Template
    entityFactory.register(Template.class)
      .createdBy(Template::new)
      .withAttribute("type")
      .withAttribute("name")
      .withAttribute("config")
      .withAttribute("shipKey")
      .belongsTo(Account.class)
      .hasMany(TemplateBinding.class);

    // TemplateBinding
    entityFactory.register(TemplateBinding.class)
      .createdBy(TemplateBinding::new)
      .withAttribute("type")
      .withAttribute("targetId")
      .belongsTo(Template.class);

    // TemplateBinding
    entityFactory.register(TemplatePlayback.class)
      .createdBy(TemplatePlayback::new)
      .withAttribute("createdAt")
      .belongsTo(Template.class)
      .belongsTo(User.class);

    // Feedback
    entityFactory.register(Feedback.class)
      .createdBy(Feedback::new)
      .withAttribute("source")
      .withAttribute("type")
      .withAttribute("timestamp")
      .withAttribute("account_id")
      .withAttribute("body")
      .belongsTo(User.class)
      .belongsTo(Template.class)
      .belongsTo(Program.class)
      .belongsTo(Library.class)
      .belongsTo(Instrument.class);

    // Feedback
    entityFactory.register(FeedbackInstrument.class)
      .createdBy(FeedbackInstrument::new)
      .belongsTo(Feedback.class)
      .belongsTo(Instrument.class);

    // Feedback
    entityFactory.register(FeedbackLibrary.class)
      .createdBy(FeedbackLibrary::new)
      .belongsTo(Feedback.class)
      .belongsTo(Library.class);

    // Feedback
    entityFactory.register(FeedbackProgram.class)
      .createdBy(FeedbackProgram::new)
      .belongsTo(Feedback.class)
      .belongsTo(Program.class);

    // Feedback
    entityFactory.register(FeedbackTemplate.class)
      .createdBy(FeedbackTemplate::new)
      .belongsTo(Feedback.class)
      .belongsTo(Template.class);
  }


}
