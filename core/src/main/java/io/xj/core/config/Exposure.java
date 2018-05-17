// Copyright (c) 2018, XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.core.config;

import io.xj.core.exception.ConfigException;
import io.xj.core.model.chain.ChainState;
import io.xj.core.model.chain.ChainType;
import io.xj.core.model.chain_config.ChainConfigType;
import io.xj.core.model.instrument.InstrumentType;
import io.xj.core.model.segment.SegmentState;
import io.xj.core.model.sequence.SequenceType;
import io.xj.core.model.pattern.PatternType;

import org.json.JSONObject;

import java.net.URI;

/**
 ALL APPLICATION CONSTANTS MUST IMPLEMENT THIS CENTRAL CLASS.
 */
public interface Exposure {

  // wrapError message as JSON output payload.
  String KEY_ERROR_DETAIL = "detail";
  String KEY_ERRORS = "errors";

  // external file references (e.g. audio files)
  String FILE_AUDIO = "audio";
  String FILE_SEGMENT = "segment";
  String FILE_CHAIN = "chain";
  String FILE_DOT = ".";
  String FILE_INSTRUMENT = "instrument";
  String FILE_SEPARATOR = "-";

  // key special resources (e.g. upload policy)
  String KEY_UPLOAD_ACCESS_KEY = "awsAccessKeyId";
  String KEY_UPLOAD_POLICY = "uploadPolicy";
  String KEY_UPLOAD_URL = "uploadUrl";
  String KEY_WAVEFORM_KEY = "waveformKey";
  String KEY_UPLOAD_POLICY_SIGNATURE = "uploadPolicySignature";
  String KEY_UPLOAD_BUCKET_NAME = "bucketName";
  String KEY_UPLOAD_ACL = "acl";

  // configuration endpoint
  String KEY_API_BASE_URL = "apiBaseUrl";
  String KEY_AUDIO_BASE_URL = "audioBaseUrl";
  String KEY_BASE_URL = "baseUrl";
  String KEY_CHAIN_CONFIG_TYPES = "chainConfigTypes";
  String KEY_CHAIN_STATES = "chainStates";
  String KEY_CHAIN_TYPES = "chainTypes";
  String KEY_CHOICE_TYPES = "choiceTypes";
  String KEY_CONFIG = "config";
  String KEY_SEQUENCE_TYPES = "sequenceTypes";
  String KEY_INSTRUMENT_TYPES = "instrumentTypes";
  String KEY_SEGMENT_BASE_URL = "segmentBaseUrl";
  String KEY_SEGMENT_STATES = "segmentStates";
  String KEY_STATS = "stats";
  String KEY_VOICE_TYPES = "voiceTypes";
  String KEY_PATTERN_TYPES = "patternTypes";
  String KEY_PATTERN_DETAIL_TYPES = "patternDetailTypes";

  /**
   Get URL String for an audio file, by key

   @param key of audio to retrieve a URL for (empty for base URL)
   @return String
   */
  static String audioUrl(String key) throws ConfigException {
    return Config.audioBaseUrl() + key;
  }

  /**
   Get URL String for a path within the API

   @param path within API
   @return String
   */
  static String apiUrlString(String path) {
    return Config.appBaseUrl() + Config.apiPath() + path;
  }

  /**
   Get URI object for a path within the API

   @param path within API
   @return String
   */
  static URI apiURI(String path) {
    return URI.create(apiUrlString(path));
  }

  /**
   Get platform configuration

   @return JSON object
   */
  static JSONObject configJSON() throws ConfigException {
    JSONObject config = new JSONObject();
    config.put(KEY_API_BASE_URL, Config.appBaseUrl() + Config.apiPath());
    config.put(KEY_AUDIO_BASE_URL, Config.audioBaseUrl());
    config.put(KEY_SEGMENT_BASE_URL, Config.segmentBaseUrl());
    config.put(KEY_BASE_URL, Config.appBaseUrl());
    config.put(KEY_CHAIN_CONFIG_TYPES, ChainConfigType.stringValues());
    config.put(KEY_CHAIN_CONFIG_TYPES, ChainConfigType.stringValues());
    config.put(KEY_CHAIN_STATES, ChainState.stringValues());
    config.put(KEY_CHAIN_TYPES, ChainType.stringValues());
    config.put(KEY_SEGMENT_STATES, SegmentState.stringValues());
    config.put(KEY_CHOICE_TYPES, SequenceType.stringValues());
    config.put(KEY_SEQUENCE_TYPES, SequenceType.stringValues());
    config.put(KEY_PATTERN_TYPES, PatternType.stringValues());
    config.put(KEY_PATTERN_DETAIL_TYPES, PatternType.stringValuesForDetailSequence());
    config.put(KEY_INSTRUMENT_TYPES, InstrumentType.stringValues());
    config.put(KEY_VOICE_TYPES, InstrumentType.stringValues());
    return config;
  }
}
