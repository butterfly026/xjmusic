\-\- Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.

--
-- PostgreSQL database dump
--

-- Dumped from database version 11.6 (Debian 11.6-1.pgdg90+1)
-- Dumped by pg_dump version 12.2 (Ubuntu 12.2-2.pgdg18.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: xj_test; Type: DATABASE; Schema: -; Owner: root
--

CREATE DATABASE xj_test WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.utf8' LC_CTYPE = 'en_US.utf8';


ALTER DATABASE xj_test OWNER TO root;

\connect xj_test

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: xj; Type: SCHEMA; Schema: -; Owner: root
--

CREATE SCHEMA xj;


ALTER SCHEMA xj OWNER TO root;

--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA xj;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: updated_at_now(); Type: FUNCTION; Schema: xj; Owner: root
--

CREATE FUNCTION xj.updated_at_now() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$;


ALTER FUNCTION xj.updated_at_now() OWNER TO root;

SET default_tablespace = '';

--
-- Name: account; Type: TABLE; Schema: xj; Owner: root
--

CREATE TABLE xj.account (
    id uuid DEFAULT xj.uuid_generate_v1mc() NOT NULL,
    name character varying(255) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE xj.account OWNER TO root;

--
-- Name: account_user; Type: TABLE; Schema: xj; Owner: root
--

CREATE TABLE xj.account_user (
    id uuid DEFAULT xj.uuid_generate_v1mc() NOT NULL,
    user_id uuid NOT NULL,
    account_id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE xj.account_user OWNER TO root;

--
-- Name: chain; Type: TABLE; Schema: xj; Owner: root
--

CREATE TABLE xj.chain (
    id uuid DEFAULT xj.uuid_generate_v1mc() NOT NULL,
    account_id uuid NOT NULL,
    name character varying(255) NOT NULL,
    state character varying(255) NOT NULL,
    type character varying(255) NOT NULL,
    start_at timestamp without time zone NOT NULL,
    stop_at timestamp without time zone,
    embed_key character varying(1023) DEFAULT NULL::character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE xj.chain OWNER TO root;

--
-- Name: chain_binding; Type: TABLE; Schema: xj; Owner: root
--

CREATE TABLE xj.chain_binding (
    id uuid DEFAULT xj.uuid_generate_v1mc() NOT NULL,
    chain_id uuid NOT NULL,
    target_id uuid NOT NULL,
    type character varying(255) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE xj.chain_binding OWNER TO root;

--
-- Name: chain_config; Type: TABLE; Schema: xj; Owner: root
--

CREATE TABLE xj.chain_config (
    id uuid DEFAULT xj.uuid_generate_v1mc() NOT NULL,
    chain_id uuid NOT NULL,
    type character varying(255) NOT NULL,
    value text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE xj.chain_config OWNER TO root;

--
-- Name: flyway_schema_history; Type: TABLE; Schema: xj; Owner: root
--

CREATE TABLE xj.flyway_schema_history (
    installed_rank integer NOT NULL,
    version character varying(50),
    description character varying(200) NOT NULL,
    type character varying(20) NOT NULL,
    script character varying(1000) NOT NULL,
    checksum integer,
    installed_by character varying(100) NOT NULL,
    installed_on timestamp without time zone DEFAULT now() NOT NULL,
    execution_time integer NOT NULL,
    success boolean NOT NULL
);


ALTER TABLE xj.flyway_schema_history OWNER TO root;

--
-- Name: instrument; Type: TABLE; Schema: xj; Owner: root
--

CREATE TABLE xj.instrument (
    id uuid DEFAULT xj.uuid_generate_v1mc() NOT NULL,
    user_id uuid NOT NULL,
    library_id uuid NOT NULL,
    type character varying(255) NOT NULL,
    state character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    density real NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE xj.instrument OWNER TO root;

--
-- Name: instrument_audio; Type: TABLE; Schema: xj; Owner: root
--

CREATE TABLE xj.instrument_audio (
    id uuid DEFAULT xj.uuid_generate_v1mc() NOT NULL,
    instrument_id uuid NOT NULL,
    name character varying(255) NOT NULL,
    waveform_key character varying(2047) NOT NULL,
    start real NOT NULL,
    length real NOT NULL,
    tempo real NOT NULL,
    pitch real NOT NULL,
    density real NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE xj.instrument_audio OWNER TO root;

--
-- Name: instrument_audio_chord; Type: TABLE; Schema: xj; Owner: root
--

CREATE TABLE xj.instrument_audio_chord (
    id uuid DEFAULT xj.uuid_generate_v1mc() NOT NULL,
    instrument_id uuid NOT NULL,
    instrument_audio_id uuid NOT NULL,
    name character varying(255) NOT NULL,
    "position" double precision NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE xj.instrument_audio_chord OWNER TO root;

--
-- Name: instrument_audio_event; Type: TABLE; Schema: xj; Owner: root
--

CREATE TABLE xj.instrument_audio_event (
    id uuid DEFAULT xj.uuid_generate_v1mc() NOT NULL,
    instrument_id uuid NOT NULL,
    instrument_audio_id uuid NOT NULL,
    name character varying(255) NOT NULL,
    velocity real NOT NULL,
    "position" double precision NOT NULL,
    duration real NOT NULL,
    note character varying(255) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE xj.instrument_audio_event OWNER TO root;

--
-- Name: instrument_meme; Type: TABLE; Schema: xj; Owner: root
--

CREATE TABLE xj.instrument_meme (
    id uuid DEFAULT xj.uuid_generate_v1mc() NOT NULL,
    instrument_id uuid NOT NULL,
    name character varying(255) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE xj.instrument_meme OWNER TO root;

--
-- Name: library; Type: TABLE; Schema: xj; Owner: root
--

CREATE TABLE xj.library (
    id uuid DEFAULT xj.uuid_generate_v1mc() NOT NULL,
    name character varying(255) NOT NULL,
    account_id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE xj.library OWNER TO root;

--
-- Name: platform_message; Type: TABLE; Schema: xj; Owner: root
--

CREATE TABLE xj.platform_message (
    id uuid DEFAULT xj.uuid_generate_v1mc() NOT NULL,
    type character varying(255) NOT NULL,
    body text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE xj.platform_message OWNER TO root;

--
-- Name: program; Type: TABLE; Schema: xj; Owner: root
--

CREATE TABLE xj.program (
    id uuid DEFAULT xj.uuid_generate_v1mc() NOT NULL,
    user_id uuid NOT NULL,
    library_id uuid NOT NULL,
    state character varying(255) NOT NULL,
    key character varying(255) NOT NULL,
    tempo real NOT NULL,
    type character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    density real NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE xj.program OWNER TO root;

--
-- Name: program_meme; Type: TABLE; Schema: xj; Owner: root
--

CREATE TABLE xj.program_meme (
    id uuid DEFAULT xj.uuid_generate_v1mc() NOT NULL,
    name character varying(255) NOT NULL,
    program_id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE xj.program_meme OWNER TO root;

--
-- Name: program_sequence; Type: TABLE; Schema: xj; Owner: root
--

CREATE TABLE xj.program_sequence (
    id uuid DEFAULT xj.uuid_generate_v1mc() NOT NULL,
    program_id uuid NOT NULL,
    name character varying(255) NOT NULL,
    key character varying(255) NOT NULL,
    density real NOT NULL,
    total smallint NOT NULL,
    tempo real NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE xj.program_sequence OWNER TO root;

--
-- Name: program_sequence_binding; Type: TABLE; Schema: xj; Owner: root
--

CREATE TABLE xj.program_sequence_binding (
    id uuid DEFAULT xj.uuid_generate_v1mc() NOT NULL,
    program_id uuid NOT NULL,
    program_sequence_id uuid NOT NULL,
    "offset" integer NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE xj.program_sequence_binding OWNER TO root;

--
-- Name: program_sequence_binding_meme; Type: TABLE; Schema: xj; Owner: root
--

CREATE TABLE xj.program_sequence_binding_meme (
    id uuid DEFAULT xj.uuid_generate_v1mc() NOT NULL,
    program_id uuid NOT NULL,
    program_sequence_binding_id uuid NOT NULL,
    name character varying(255) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE xj.program_sequence_binding_meme OWNER TO root;

--
-- Name: program_sequence_chord; Type: TABLE; Schema: xj; Owner: root
--

CREATE TABLE xj.program_sequence_chord (
    id uuid DEFAULT xj.uuid_generate_v1mc() NOT NULL,
    program_id uuid NOT NULL,
    program_sequence_id uuid NOT NULL,
    name character varying(255) NOT NULL,
    "position" double precision NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE xj.program_sequence_chord OWNER TO root;

--
-- Name: program_sequence_pattern; Type: TABLE; Schema: xj; Owner: root
--

CREATE TABLE xj.program_sequence_pattern (
    id uuid DEFAULT xj.uuid_generate_v1mc() NOT NULL,
    program_id uuid NOT NULL,
    program_sequence_id uuid NOT NULL,
    program_voice_id uuid NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255) NOT NULL,
    total smallint NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE xj.program_sequence_pattern OWNER TO root;

--
-- Name: program_sequence_pattern_event; Type: TABLE; Schema: xj; Owner: root
--

CREATE TABLE xj.program_sequence_pattern_event (
    id uuid DEFAULT xj.uuid_generate_v1mc() NOT NULL,
    program_id uuid NOT NULL,
    program_sequence_pattern_id uuid NOT NULL,
    program_voice_track_id uuid NOT NULL,
    velocity real NOT NULL,
    "position" double precision NOT NULL,
    duration real NOT NULL,
    note character varying(255) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE xj.program_sequence_pattern_event OWNER TO root;

--
-- Name: program_voice; Type: TABLE; Schema: xj; Owner: root
--

CREATE TABLE xj.program_voice (
    id uuid DEFAULT xj.uuid_generate_v1mc() NOT NULL,
    program_id uuid NOT NULL,
    type character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE xj.program_voice OWNER TO root;

--
-- Name: program_voice_track; Type: TABLE; Schema: xj; Owner: root
--

CREATE TABLE xj.program_voice_track (
    id uuid DEFAULT xj.uuid_generate_v1mc() NOT NULL,
    program_id uuid NOT NULL,
    program_voice_id uuid NOT NULL,
    name character varying(255) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE xj.program_voice_track OWNER TO root;

--
-- Name: segment; Type: TABLE; Schema: xj; Owner: root
--

CREATE TABLE xj.segment (
    chain_id uuid NOT NULL,
    id uuid DEFAULT xj.uuid_generate_v1mc() NOT NULL,
    state character varying(255) NOT NULL,
    begin_at timestamp without time zone NOT NULL,
    "offset" bigint NOT NULL,
    type character varying(255) DEFAULT NULL::character varying,
    end_at timestamp without time zone,
    total smallint,
    density real,
    tempo real,
    key character varying(255) DEFAULT NULL::character varying,
    waveform_key character varying(255) DEFAULT NULL::character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    waveform_preroll double precision DEFAULT 0
);


ALTER TABLE xj.segment OWNER TO root;

--
-- Name: segment_choice; Type: TABLE; Schema: xj; Owner: root
--

CREATE TABLE xj.segment_choice (
    id uuid DEFAULT xj.uuid_generate_v1mc() NOT NULL,
    segment_id uuid NOT NULL,
    program_id uuid NOT NULL,
    program_sequence_binding_id uuid,
    type character varying(255) NOT NULL,
    transpose smallint NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE xj.segment_choice OWNER TO root;

--
-- Name: segment_choice_arrangement; Type: TABLE; Schema: xj; Owner: root
--

CREATE TABLE xj.segment_choice_arrangement (
    id uuid DEFAULT xj.uuid_generate_v1mc() NOT NULL,
    segment_id uuid NOT NULL,
    segment_choice_id uuid NOT NULL,
    program_voice_id uuid NOT NULL,
    instrument_id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE xj.segment_choice_arrangement OWNER TO root;

--
-- Name: segment_choice_arrangement_pick; Type: TABLE; Schema: xj; Owner: root
--

CREATE TABLE xj.segment_choice_arrangement_pick (
    id uuid DEFAULT xj.uuid_generate_v1mc() NOT NULL,
    segment_id uuid NOT NULL,
    segment_choice_arrangement_id uuid NOT NULL,
    instrument_audio_id uuid NOT NULL,
    program_sequence_pattern_event_id uuid NOT NULL,
    start real NOT NULL,
    length real NOT NULL,
    amplitude real NOT NULL,
    pitch real NOT NULL,
    name character varying(255) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE xj.segment_choice_arrangement_pick OWNER TO root;

--
-- Name: segment_chord; Type: TABLE; Schema: xj; Owner: root
--

CREATE TABLE xj.segment_chord (
    id uuid DEFAULT xj.uuid_generate_v1mc() NOT NULL,
    segment_id uuid NOT NULL,
    name character varying(255) NOT NULL,
    "position" double precision NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE xj.segment_chord OWNER TO root;

--
-- Name: segment_meme; Type: TABLE; Schema: xj; Owner: root
--

CREATE TABLE xj.segment_meme (
    id uuid DEFAULT xj.uuid_generate_v1mc() NOT NULL,
    segment_id uuid NOT NULL,
    name character varying(255) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE xj.segment_meme OWNER TO root;

--
-- Name: segment_message; Type: TABLE; Schema: xj; Owner: root
--

CREATE TABLE xj.segment_message (
    id uuid DEFAULT xj.uuid_generate_v1mc() NOT NULL,
    segment_id uuid NOT NULL,
    type character varying(255) NOT NULL,
    body text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE xj.segment_message OWNER TO root;

--
-- Name: user; Type: TABLE; Schema: xj; Owner: root
--

CREATE TABLE xj."user" (
    id uuid DEFAULT xj.uuid_generate_v1mc() NOT NULL,
    name character varying(255) NOT NULL,
    email character varying(1023) DEFAULT NULL::character varying,
    avatar_url character varying(1023) DEFAULT NULL::character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE xj."user" OWNER TO root;

--
-- Name: user_auth; Type: TABLE; Schema: xj; Owner: root
--

CREATE TABLE xj.user_auth (
    id uuid DEFAULT xj.uuid_generate_v1mc() NOT NULL,
    type character varying(255) NOT NULL,
    external_access_token character varying(1023) NOT NULL,
    external_refresh_token character varying(1023) DEFAULT NULL::character varying,
    external_account character varying(1023) NOT NULL,
    user_id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE xj.user_auth OWNER TO root;

--
-- Name: user_auth_token; Type: TABLE; Schema: xj; Owner: root
--

CREATE TABLE xj.user_auth_token (
    id uuid DEFAULT xj.uuid_generate_v1mc() NOT NULL,
    user_auth_id uuid NOT NULL,
    user_id uuid NOT NULL,
    access_token text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE xj.user_auth_token OWNER TO root;

--
-- Name: user_role; Type: TABLE; Schema: xj; Owner: root
--

CREATE TABLE xj.user_role (
    id uuid DEFAULT xj.uuid_generate_v1mc() NOT NULL,
    type character varying(255) NOT NULL,
    user_id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE xj.user_role OWNER TO root;

--
-- Name: work; Type: TABLE; Schema: xj; Owner: root
--

CREATE TABLE xj.work (
    id uuid DEFAULT xj.uuid_generate_v1mc() NOT NULL,
    type character varying(255) NOT NULL,
    target_id uuid,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE xj.work OWNER TO root;

--
-- Name: account account_pkey; Type: CONSTRAINT; Schema: xj; Owner: root
--

ALTER TABLE ONLY xj.account
    ADD CONSTRAINT account_pkey PRIMARY KEY (id);


--
-- Name: account_user account_user_pkey; Type: CONSTRAINT; Schema: xj; Owner: root
--

ALTER TABLE ONLY xj.account_user
    ADD CONSTRAINT account_user_pkey PRIMARY KEY (id);


--
-- Name: chain_binding chain_binding_pkey; Type: CONSTRAINT; Schema: xj; Owner: root
--

ALTER TABLE ONLY xj.chain_binding
    ADD CONSTRAINT chain_binding_pkey PRIMARY KEY (id);


--
-- Name: chain_config chain_config_pkey; Type: CONSTRAINT; Schema: xj; Owner: root
--

ALTER TABLE ONLY xj.chain_config
    ADD CONSTRAINT chain_config_pkey PRIMARY KEY (id);


--
-- Name: chain chain_pkey; Type: CONSTRAINT; Schema: xj; Owner: root
--

ALTER TABLE ONLY xj.chain
    ADD CONSTRAINT chain_pkey PRIMARY KEY (id);


--
-- Name: flyway_schema_history flyway_schema_history_pk; Type: CONSTRAINT; Schema: xj; Owner: root
--

ALTER TABLE ONLY xj.flyway_schema_history
    ADD CONSTRAINT flyway_schema_history_pk PRIMARY KEY (installed_rank);


--
-- Name: instrument_audio_chord instrument_audio_chord_pkey; Type: CONSTRAINT; Schema: xj; Owner: root
--

ALTER TABLE ONLY xj.instrument_audio_chord
    ADD CONSTRAINT instrument_audio_chord_pkey PRIMARY KEY (id);


--
-- Name: instrument_audio_event instrument_audio_event_pkey; Type: CONSTRAINT; Schema: xj; Owner: root
--

ALTER TABLE ONLY xj.instrument_audio_event
    ADD CONSTRAINT instrument_audio_event_pkey PRIMARY KEY (id);


--
-- Name: instrument_audio instrument_audio_pkey; Type: CONSTRAINT; Schema: xj; Owner: root
--

ALTER TABLE ONLY xj.instrument_audio
    ADD CONSTRAINT instrument_audio_pkey PRIMARY KEY (id);


--
-- Name: instrument_meme instrument_meme_pkey; Type: CONSTRAINT; Schema: xj; Owner: root
--

ALTER TABLE ONLY xj.instrument_meme
    ADD CONSTRAINT instrument_meme_pkey PRIMARY KEY (id);


--
-- Name: instrument instrument_pkey; Type: CONSTRAINT; Schema: xj; Owner: root
--

ALTER TABLE ONLY xj.instrument
    ADD CONSTRAINT instrument_pkey PRIMARY KEY (id);


--
-- Name: library library_pkey; Type: CONSTRAINT; Schema: xj; Owner: root
--

ALTER TABLE ONLY xj.library
    ADD CONSTRAINT library_pkey PRIMARY KEY (id);


--
-- Name: platform_message platform_message_pkey; Type: CONSTRAINT; Schema: xj; Owner: root
--

ALTER TABLE ONLY xj.platform_message
    ADD CONSTRAINT platform_message_pkey PRIMARY KEY (id);


--
-- Name: program_meme program_meme_pkey; Type: CONSTRAINT; Schema: xj; Owner: root
--

ALTER TABLE ONLY xj.program_meme
    ADD CONSTRAINT program_meme_pkey PRIMARY KEY (id);


--
-- Name: program program_pkey; Type: CONSTRAINT; Schema: xj; Owner: root
--

ALTER TABLE ONLY xj.program
    ADD CONSTRAINT program_pkey PRIMARY KEY (id);


--
-- Name: program_sequence_binding_meme program_sequence_binding_meme_pkey; Type: CONSTRAINT; Schema: xj; Owner: root
--

ALTER TABLE ONLY xj.program_sequence_binding_meme
    ADD CONSTRAINT program_sequence_binding_meme_pkey PRIMARY KEY (id);


--
-- Name: program_sequence_binding program_sequence_binding_pkey; Type: CONSTRAINT; Schema: xj; Owner: root
--

ALTER TABLE ONLY xj.program_sequence_binding
    ADD CONSTRAINT program_sequence_binding_pkey PRIMARY KEY (id);


--
-- Name: program_sequence_chord program_sequence_chord_pkey; Type: CONSTRAINT; Schema: xj; Owner: root
--

ALTER TABLE ONLY xj.program_sequence_chord
    ADD CONSTRAINT program_sequence_chord_pkey PRIMARY KEY (id);


--
-- Name: program_sequence_pattern_event program_sequence_pattern_event_pkey; Type: CONSTRAINT; Schema: xj; Owner: root
--

ALTER TABLE ONLY xj.program_sequence_pattern_event
    ADD CONSTRAINT program_sequence_pattern_event_pkey PRIMARY KEY (id);


--
-- Name: program_sequence_pattern program_sequence_pattern_pkey; Type: CONSTRAINT; Schema: xj; Owner: root
--

ALTER TABLE ONLY xj.program_sequence_pattern
    ADD CONSTRAINT program_sequence_pattern_pkey PRIMARY KEY (id);


--
-- Name: program_sequence program_sequence_pkey; Type: CONSTRAINT; Schema: xj; Owner: root
--

ALTER TABLE ONLY xj.program_sequence
    ADD CONSTRAINT program_sequence_pkey PRIMARY KEY (id);


--
-- Name: program_voice program_voice_pkey; Type: CONSTRAINT; Schema: xj; Owner: root
--

ALTER TABLE ONLY xj.program_voice
    ADD CONSTRAINT program_voice_pkey PRIMARY KEY (id);


--
-- Name: program_voice_track program_voice_track_pkey; Type: CONSTRAINT; Schema: xj; Owner: root
--

ALTER TABLE ONLY xj.program_voice_track
    ADD CONSTRAINT program_voice_track_pkey PRIMARY KEY (id);


--
-- Name: segment_choice_arrangement_pick segment_choice_arrangement_pick_pkey; Type: CONSTRAINT; Schema: xj; Owner: root
--

ALTER TABLE ONLY xj.segment_choice_arrangement_pick
    ADD CONSTRAINT segment_choice_arrangement_pick_pkey PRIMARY KEY (id);


--
-- Name: segment_choice_arrangement segment_choice_arrangement_pkey; Type: CONSTRAINT; Schema: xj; Owner: root
--

ALTER TABLE ONLY xj.segment_choice_arrangement
    ADD CONSTRAINT segment_choice_arrangement_pkey PRIMARY KEY (id);


--
-- Name: segment_choice segment_choice_pkey; Type: CONSTRAINT; Schema: xj; Owner: root
--

ALTER TABLE ONLY xj.segment_choice
    ADD CONSTRAINT segment_choice_pkey PRIMARY KEY (id);


--
-- Name: segment_chord segment_chord_pkey; Type: CONSTRAINT; Schema: xj; Owner: root
--

ALTER TABLE ONLY xj.segment_chord
    ADD CONSTRAINT segment_chord_pkey PRIMARY KEY (id);


--
-- Name: segment_meme segment_meme_pkey; Type: CONSTRAINT; Schema: xj; Owner: root
--

ALTER TABLE ONLY xj.segment_meme
    ADD CONSTRAINT segment_meme_pkey PRIMARY KEY (id);


--
-- Name: segment_message segment_message_pkey; Type: CONSTRAINT; Schema: xj; Owner: root
--

ALTER TABLE ONLY xj.segment_message
    ADD CONSTRAINT segment_message_pkey PRIMARY KEY (id);


--
-- Name: segment segment_pkey; Type: CONSTRAINT; Schema: xj; Owner: root
--

ALTER TABLE ONLY xj.segment
    ADD CONSTRAINT segment_pkey PRIMARY KEY (id);


--
-- Name: user_auth user_auth_pkey; Type: CONSTRAINT; Schema: xj; Owner: root
--

ALTER TABLE ONLY xj.user_auth
    ADD CONSTRAINT user_auth_pkey PRIMARY KEY (id);


--
-- Name: user_auth_token user_auth_token_pkey; Type: CONSTRAINT; Schema: xj; Owner: root
--

ALTER TABLE ONLY xj.user_auth_token
    ADD CONSTRAINT user_auth_token_pkey PRIMARY KEY (id);


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: xj; Owner: root
--

ALTER TABLE ONLY xj."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: user_role user_role_pkey; Type: CONSTRAINT; Schema: xj; Owner: root
--

ALTER TABLE ONLY xj.user_role
    ADD CONSTRAINT user_role_pkey PRIMARY KEY (id);


--
-- Name: work work_pkey; Type: CONSTRAINT; Schema: xj; Owner: root
--

ALTER TABLE ONLY xj.work
    ADD CONSTRAINT work_pkey PRIMARY KEY (id);


--
-- Name: flyway_schema_history_s_idx; Type: INDEX; Schema: xj; Owner: root
--

CREATE INDEX flyway_schema_history_s_idx ON xj.flyway_schema_history USING btree (success);


--
-- Name: account account___updated; Type: TRIGGER; Schema: xj; Owner: root
--

CREATE TRIGGER account___updated BEFORE UPDATE ON xj.account FOR EACH ROW EXECUTE PROCEDURE xj.updated_at_now();


--
-- Name: account_user account_user___updated; Type: TRIGGER; Schema: xj; Owner: root
--

CREATE TRIGGER account_user___updated BEFORE UPDATE ON xj.account_user FOR EACH ROW EXECUTE PROCEDURE xj.updated_at_now();


--
-- Name: chain chain___updated; Type: TRIGGER; Schema: xj; Owner: root
--

CREATE TRIGGER chain___updated BEFORE UPDATE ON xj.chain FOR EACH ROW EXECUTE PROCEDURE xj.updated_at_now();


--
-- Name: chain_binding chain_binding___updated; Type: TRIGGER; Schema: xj; Owner: root
--

CREATE TRIGGER chain_binding___updated BEFORE UPDATE ON xj.chain_binding FOR EACH ROW EXECUTE PROCEDURE xj.updated_at_now();


--
-- Name: chain_config chain_config___updated; Type: TRIGGER; Schema: xj; Owner: root
--

CREATE TRIGGER chain_config___updated BEFORE UPDATE ON xj.chain_config FOR EACH ROW EXECUTE PROCEDURE xj.updated_at_now();


--
-- Name: instrument instrument___updated; Type: TRIGGER; Schema: xj; Owner: root
--

CREATE TRIGGER instrument___updated BEFORE UPDATE ON xj.instrument FOR EACH ROW EXECUTE PROCEDURE xj.updated_at_now();


--
-- Name: instrument_audio instrument_audio___updated; Type: TRIGGER; Schema: xj; Owner: root
--

CREATE TRIGGER instrument_audio___updated BEFORE UPDATE ON xj.instrument_audio FOR EACH ROW EXECUTE PROCEDURE xj.updated_at_now();


--
-- Name: instrument_audio_chord instrument_audio_chord___updated; Type: TRIGGER; Schema: xj; Owner: root
--

CREATE TRIGGER instrument_audio_chord___updated BEFORE UPDATE ON xj.instrument_audio_chord FOR EACH ROW EXECUTE PROCEDURE xj.updated_at_now();


--
-- Name: instrument_audio_event instrument_audio_event___updated; Type: TRIGGER; Schema: xj; Owner: root
--

CREATE TRIGGER instrument_audio_event___updated BEFORE UPDATE ON xj.instrument_audio_event FOR EACH ROW EXECUTE PROCEDURE xj.updated_at_now();


--
-- Name: instrument_meme instrument_meme___updated; Type: TRIGGER; Schema: xj; Owner: root
--

CREATE TRIGGER instrument_meme___updated BEFORE UPDATE ON xj.instrument_meme FOR EACH ROW EXECUTE PROCEDURE xj.updated_at_now();


--
-- Name: library library___updated; Type: TRIGGER; Schema: xj; Owner: root
--

CREATE TRIGGER library___updated BEFORE UPDATE ON xj.library FOR EACH ROW EXECUTE PROCEDURE xj.updated_at_now();


--
-- Name: platform_message platform_message___updated; Type: TRIGGER; Schema: xj; Owner: root
--

CREATE TRIGGER platform_message___updated BEFORE UPDATE ON xj.platform_message FOR EACH ROW EXECUTE PROCEDURE xj.updated_at_now();


--
-- Name: program program___updated; Type: TRIGGER; Schema: xj; Owner: root
--

CREATE TRIGGER program___updated BEFORE UPDATE ON xj.program FOR EACH ROW EXECUTE PROCEDURE xj.updated_at_now();


--
-- Name: program_meme program_meme___updated; Type: TRIGGER; Schema: xj; Owner: root
--

CREATE TRIGGER program_meme___updated BEFORE UPDATE ON xj.program_meme FOR EACH ROW EXECUTE PROCEDURE xj.updated_at_now();


--
-- Name: program_sequence program_sequence___updated; Type: TRIGGER; Schema: xj; Owner: root
--

CREATE TRIGGER program_sequence___updated BEFORE UPDATE ON xj.program_sequence FOR EACH ROW EXECUTE PROCEDURE xj.updated_at_now();


--
-- Name: program_sequence_binding program_sequence_binding___updated; Type: TRIGGER; Schema: xj; Owner: root
--

CREATE TRIGGER program_sequence_binding___updated BEFORE UPDATE ON xj.program_sequence_binding FOR EACH ROW EXECUTE PROCEDURE xj.updated_at_now();


--
-- Name: program_sequence_binding_meme program_sequence_binding_meme___updated; Type: TRIGGER; Schema: xj; Owner: root
--

CREATE TRIGGER program_sequence_binding_meme___updated BEFORE UPDATE ON xj.program_sequence_binding_meme FOR EACH ROW EXECUTE PROCEDURE xj.updated_at_now();


--
-- Name: program_sequence_chord program_sequence_chord___updated; Type: TRIGGER; Schema: xj; Owner: root
--

CREATE TRIGGER program_sequence_chord___updated BEFORE UPDATE ON xj.program_sequence_chord FOR EACH ROW EXECUTE PROCEDURE xj.updated_at_now();


--
-- Name: program_sequence_pattern program_sequence_pattern___updated; Type: TRIGGER; Schema: xj; Owner: root
--

CREATE TRIGGER program_sequence_pattern___updated BEFORE UPDATE ON xj.program_sequence_pattern FOR EACH ROW EXECUTE PROCEDURE xj.updated_at_now();


--
-- Name: program_sequence_pattern_event program_sequence_pattern_event___updated; Type: TRIGGER; Schema: xj; Owner: root
--

CREATE TRIGGER program_sequence_pattern_event___updated BEFORE UPDATE ON xj.program_sequence_pattern_event FOR EACH ROW EXECUTE PROCEDURE xj.updated_at_now();


--
-- Name: program_voice program_voice___updated; Type: TRIGGER; Schema: xj; Owner: root
--

CREATE TRIGGER program_voice___updated BEFORE UPDATE ON xj.program_voice FOR EACH ROW EXECUTE PROCEDURE xj.updated_at_now();


--
-- Name: program_voice_track program_voice_track___updated; Type: TRIGGER; Schema: xj; Owner: root
--

CREATE TRIGGER program_voice_track___updated BEFORE UPDATE ON xj.program_voice_track FOR EACH ROW EXECUTE PROCEDURE xj.updated_at_now();


--
-- Name: segment segment___updated; Type: TRIGGER; Schema: xj; Owner: root
--

CREATE TRIGGER segment___updated BEFORE UPDATE ON xj.segment FOR EACH ROW EXECUTE PROCEDURE xj.updated_at_now();


--
-- Name: segment_choice segment_choice___updated; Type: TRIGGER; Schema: xj; Owner: root
--

CREATE TRIGGER segment_choice___updated BEFORE UPDATE ON xj.segment_choice FOR EACH ROW EXECUTE PROCEDURE xj.updated_at_now();


--
-- Name: segment_choice_arrangement segment_choice_arrangement___updated; Type: TRIGGER; Schema: xj; Owner: root
--

CREATE TRIGGER segment_choice_arrangement___updated BEFORE UPDATE ON xj.segment_choice_arrangement FOR EACH ROW EXECUTE PROCEDURE xj.updated_at_now();


--
-- Name: segment_choice_arrangement_pick segment_choice_arrangement_pick___updated; Type: TRIGGER; Schema: xj; Owner: root
--

CREATE TRIGGER segment_choice_arrangement_pick___updated BEFORE UPDATE ON xj.segment_choice_arrangement_pick FOR EACH ROW EXECUTE PROCEDURE xj.updated_at_now();


--
-- Name: segment_chord segment_chord___updated; Type: TRIGGER; Schema: xj; Owner: root
--

CREATE TRIGGER segment_chord___updated BEFORE UPDATE ON xj.segment_chord FOR EACH ROW EXECUTE PROCEDURE xj.updated_at_now();


--
-- Name: segment_meme segment_meme___updated; Type: TRIGGER; Schema: xj; Owner: root
--

CREATE TRIGGER segment_meme___updated BEFORE UPDATE ON xj.segment_meme FOR EACH ROW EXECUTE PROCEDURE xj.updated_at_now();


--
-- Name: segment_message segment_message___updated; Type: TRIGGER; Schema: xj; Owner: root
--

CREATE TRIGGER segment_message___updated BEFORE UPDATE ON xj.segment_message FOR EACH ROW EXECUTE PROCEDURE xj.updated_at_now();


--
-- Name: user user___updated; Type: TRIGGER; Schema: xj; Owner: root
--

CREATE TRIGGER user___updated BEFORE UPDATE ON xj."user" FOR EACH ROW EXECUTE PROCEDURE xj.updated_at_now();


--
-- Name: user_auth user_auth____updated; Type: TRIGGER; Schema: xj; Owner: root
--

CREATE TRIGGER user_auth____updated BEFORE UPDATE ON xj.user_auth FOR EACH ROW EXECUTE PROCEDURE xj.updated_at_now();


--
-- Name: user_auth_token user_auth_token___updated; Type: TRIGGER; Schema: xj; Owner: root
--

CREATE TRIGGER user_auth_token___updated BEFORE UPDATE ON xj.user_auth_token FOR EACH ROW EXECUTE PROCEDURE xj.updated_at_now();


--
-- Name: user_role user_role___updated; Type: TRIGGER; Schema: xj; Owner: root
--

CREATE TRIGGER user_role___updated BEFORE UPDATE ON xj.user_role FOR EACH ROW EXECUTE PROCEDURE xj.updated_at_now();


--
-- Name: work work___updated; Type: TRIGGER; Schema: xj; Owner: root
--

CREATE TRIGGER work___updated BEFORE UPDATE ON xj.work FOR EACH ROW EXECUTE PROCEDURE xj.updated_at_now();


--
-- Name: account_user account_user_account_id_fkey; Type: FK CONSTRAINT; Schema: xj; Owner: root
--

ALTER TABLE ONLY xj.account_user
    ADD CONSTRAINT account_user_account_id_fkey FOREIGN KEY (account_id) REFERENCES xj.account(id);


--
-- Name: account_user account_user_user_id_fkey; Type: FK CONSTRAINT; Schema: xj; Owner: root
--

ALTER TABLE ONLY xj.account_user
    ADD CONSTRAINT account_user_user_id_fkey FOREIGN KEY (user_id) REFERENCES xj."user"(id);


--
-- Name: chain chain_account_id_fkey; Type: FK CONSTRAINT; Schema: xj; Owner: root
--

ALTER TABLE ONLY xj.chain
    ADD CONSTRAINT chain_account_id_fkey FOREIGN KEY (account_id) REFERENCES xj.account(id);


--
-- Name: chain_binding chain_binding_chain_id_fkey; Type: FK CONSTRAINT; Schema: xj; Owner: root
--

ALTER TABLE ONLY xj.chain_binding
    ADD CONSTRAINT chain_binding_chain_id_fkey FOREIGN KEY (chain_id) REFERENCES xj.chain(id);


--
-- Name: chain_config chain_config_chain_id_fkey; Type: FK CONSTRAINT; Schema: xj; Owner: root
--

ALTER TABLE ONLY xj.chain_config
    ADD CONSTRAINT chain_config_chain_id_fkey FOREIGN KEY (chain_id) REFERENCES xj.chain(id);


--
-- Name: instrument_audio_chord instrument_audio_chord_instrument_audio_id_fkey; Type: FK CONSTRAINT; Schema: xj; Owner: root
--

ALTER TABLE ONLY xj.instrument_audio_chord
    ADD CONSTRAINT instrument_audio_chord_instrument_audio_id_fkey FOREIGN KEY (instrument_audio_id) REFERENCES xj.instrument_audio(id);


--
-- Name: instrument_audio_chord instrument_audio_chord_instrument_id_fkey; Type: FK CONSTRAINT; Schema: xj; Owner: root
--

ALTER TABLE ONLY xj.instrument_audio_chord
    ADD CONSTRAINT instrument_audio_chord_instrument_id_fkey FOREIGN KEY (instrument_id) REFERENCES xj.instrument(id);


--
-- Name: instrument_audio_event instrument_audio_event_instrument_audio_id_fkey; Type: FK CONSTRAINT; Schema: xj; Owner: root
--

ALTER TABLE ONLY xj.instrument_audio_event
    ADD CONSTRAINT instrument_audio_event_instrument_audio_id_fkey FOREIGN KEY (instrument_audio_id) REFERENCES xj.instrument_audio(id);


--
-- Name: instrument_audio_event instrument_audio_event_instrument_id_fkey; Type: FK CONSTRAINT; Schema: xj; Owner: root
--

ALTER TABLE ONLY xj.instrument_audio_event
    ADD CONSTRAINT instrument_audio_event_instrument_id_fkey FOREIGN KEY (instrument_id) REFERENCES xj.instrument(id);


--
-- Name: instrument_audio instrument_audio_instrument_id_fkey; Type: FK CONSTRAINT; Schema: xj; Owner: root
--

ALTER TABLE ONLY xj.instrument_audio
    ADD CONSTRAINT instrument_audio_instrument_id_fkey FOREIGN KEY (instrument_id) REFERENCES xj.instrument(id);


--
-- Name: instrument instrument_library_id_fkey; Type: FK CONSTRAINT; Schema: xj; Owner: root
--

ALTER TABLE ONLY xj.instrument
    ADD CONSTRAINT instrument_library_id_fkey FOREIGN KEY (library_id) REFERENCES xj.library(id);


--
-- Name: instrument_meme instrument_meme_instrument_id_fkey; Type: FK CONSTRAINT; Schema: xj; Owner: root
--

ALTER TABLE ONLY xj.instrument_meme
    ADD CONSTRAINT instrument_meme_instrument_id_fkey FOREIGN KEY (instrument_id) REFERENCES xj.instrument(id);


--
-- Name: instrument instrument_user_id_fkey; Type: FK CONSTRAINT; Schema: xj; Owner: root
--

ALTER TABLE ONLY xj.instrument
    ADD CONSTRAINT instrument_user_id_fkey FOREIGN KEY (user_id) REFERENCES xj."user"(id);


--
-- Name: library library_account_id_fkey; Type: FK CONSTRAINT; Schema: xj; Owner: root
--

ALTER TABLE ONLY xj.library
    ADD CONSTRAINT library_account_id_fkey FOREIGN KEY (account_id) REFERENCES xj.account(id);


--
-- Name: program program_library_id_fkey; Type: FK CONSTRAINT; Schema: xj; Owner: root
--

ALTER TABLE ONLY xj.program
    ADD CONSTRAINT program_library_id_fkey FOREIGN KEY (library_id) REFERENCES xj.library(id);


--
-- Name: program_meme program_meme_program_id_fkey; Type: FK CONSTRAINT; Schema: xj; Owner: root
--

ALTER TABLE ONLY xj.program_meme
    ADD CONSTRAINT program_meme_program_id_fkey FOREIGN KEY (program_id) REFERENCES xj.program(id);


--
-- Name: program_sequence_binding_meme program_sequence_binding_meme_program_id_fkey; Type: FK CONSTRAINT; Schema: xj; Owner: root
--

ALTER TABLE ONLY xj.program_sequence_binding_meme
    ADD CONSTRAINT program_sequence_binding_meme_program_id_fkey FOREIGN KEY (program_id) REFERENCES xj.program(id);


--
-- Name: program_sequence_binding_meme program_sequence_binding_meme_program_sequence_binding_id_fkey; Type: FK CONSTRAINT; Schema: xj; Owner: root
--

ALTER TABLE ONLY xj.program_sequence_binding_meme
    ADD CONSTRAINT program_sequence_binding_meme_program_sequence_binding_id_fkey FOREIGN KEY (program_sequence_binding_id) REFERENCES xj.program_sequence_binding(id);


--
-- Name: program_sequence_binding program_sequence_binding_program_id_fkey; Type: FK CONSTRAINT; Schema: xj; Owner: root
--

ALTER TABLE ONLY xj.program_sequence_binding
    ADD CONSTRAINT program_sequence_binding_program_id_fkey FOREIGN KEY (program_id) REFERENCES xj.program(id);


--
-- Name: program_sequence_binding program_sequence_binding_program_sequence_id_fkey; Type: FK CONSTRAINT; Schema: xj; Owner: root
--

ALTER TABLE ONLY xj.program_sequence_binding
    ADD CONSTRAINT program_sequence_binding_program_sequence_id_fkey FOREIGN KEY (program_sequence_id) REFERENCES xj.program_sequence(id);


--
-- Name: program_sequence_chord program_sequence_chord_program_id_fkey; Type: FK CONSTRAINT; Schema: xj; Owner: root
--

ALTER TABLE ONLY xj.program_sequence_chord
    ADD CONSTRAINT program_sequence_chord_program_id_fkey FOREIGN KEY (program_id) REFERENCES xj.program(id);


--
-- Name: program_sequence_chord program_sequence_chord_program_sequence_id_fkey; Type: FK CONSTRAINT; Schema: xj; Owner: root
--

ALTER TABLE ONLY xj.program_sequence_chord
    ADD CONSTRAINT program_sequence_chord_program_sequence_id_fkey FOREIGN KEY (program_sequence_id) REFERENCES xj.program_sequence(id);


--
-- Name: program_sequence_pattern_event program_sequence_pattern_event_program_id_fkey; Type: FK CONSTRAINT; Schema: xj; Owner: root
--

ALTER TABLE ONLY xj.program_sequence_pattern_event
    ADD CONSTRAINT program_sequence_pattern_event_program_id_fkey FOREIGN KEY (program_id) REFERENCES xj.program(id);


--
-- Name: program_sequence_pattern_event program_sequence_pattern_event_program_sequence_pattern_id_fkey; Type: FK CONSTRAINT; Schema: xj; Owner: root
--

ALTER TABLE ONLY xj.program_sequence_pattern_event
    ADD CONSTRAINT program_sequence_pattern_event_program_sequence_pattern_id_fkey FOREIGN KEY (program_sequence_pattern_id) REFERENCES xj.program_sequence_pattern(id);


--
-- Name: program_sequence_pattern_event program_sequence_pattern_event_program_voice_track_id_fkey; Type: FK CONSTRAINT; Schema: xj; Owner: root
--

ALTER TABLE ONLY xj.program_sequence_pattern_event
    ADD CONSTRAINT program_sequence_pattern_event_program_voice_track_id_fkey FOREIGN KEY (program_voice_track_id) REFERENCES xj.program_voice_track(id);


--
-- Name: program_sequence_pattern program_sequence_pattern_program_id_fkey; Type: FK CONSTRAINT; Schema: xj; Owner: root
--

ALTER TABLE ONLY xj.program_sequence_pattern
    ADD CONSTRAINT program_sequence_pattern_program_id_fkey FOREIGN KEY (program_id) REFERENCES xj.program(id);


--
-- Name: program_sequence_pattern program_sequence_pattern_program_sequence_id_fkey; Type: FK CONSTRAINT; Schema: xj; Owner: root
--

ALTER TABLE ONLY xj.program_sequence_pattern
    ADD CONSTRAINT program_sequence_pattern_program_sequence_id_fkey FOREIGN KEY (program_sequence_id) REFERENCES xj.program_sequence(id);


--
-- Name: program_sequence_pattern program_sequence_pattern_program_voice_id_fkey; Type: FK CONSTRAINT; Schema: xj; Owner: root
--

ALTER TABLE ONLY xj.program_sequence_pattern
    ADD CONSTRAINT program_sequence_pattern_program_voice_id_fkey FOREIGN KEY (program_voice_id) REFERENCES xj.program_voice(id);


--
-- Name: program_sequence program_sequence_program_id_fkey; Type: FK CONSTRAINT; Schema: xj; Owner: root
--

ALTER TABLE ONLY xj.program_sequence
    ADD CONSTRAINT program_sequence_program_id_fkey FOREIGN KEY (program_id) REFERENCES xj.program(id);


--
-- Name: program program_user_id_fkey; Type: FK CONSTRAINT; Schema: xj; Owner: root
--

ALTER TABLE ONLY xj.program
    ADD CONSTRAINT program_user_id_fkey FOREIGN KEY (user_id) REFERENCES xj."user"(id);


--
-- Name: program_voice program_voice_program_id_fkey; Type: FK CONSTRAINT; Schema: xj; Owner: root
--

ALTER TABLE ONLY xj.program_voice
    ADD CONSTRAINT program_voice_program_id_fkey FOREIGN KEY (program_id) REFERENCES xj.program(id);


--
-- Name: program_voice_track program_voice_track_program_id_fkey; Type: FK CONSTRAINT; Schema: xj; Owner: root
--

ALTER TABLE ONLY xj.program_voice_track
    ADD CONSTRAINT program_voice_track_program_id_fkey FOREIGN KEY (program_id) REFERENCES xj.program(id);


--
-- Name: program_voice_track program_voice_track_program_voice_id_fkey; Type: FK CONSTRAINT; Schema: xj; Owner: root
--

ALTER TABLE ONLY xj.program_voice_track
    ADD CONSTRAINT program_voice_track_program_voice_id_fkey FOREIGN KEY (program_voice_id) REFERENCES xj.program_voice(id);


--
-- Name: segment segment_chain_id_fkey; Type: FK CONSTRAINT; Schema: xj; Owner: root
--

ALTER TABLE ONLY xj.segment
    ADD CONSTRAINT segment_chain_id_fkey FOREIGN KEY (chain_id) REFERENCES xj.chain(id);


--
-- Name: segment_choice_arrangement_pick segment_choice_arrangement_pi_segment_choice_arrangement_i_fkey; Type: FK CONSTRAINT; Schema: xj; Owner: root
--

ALTER TABLE ONLY xj.segment_choice_arrangement_pick
    ADD CONSTRAINT segment_choice_arrangement_pi_segment_choice_arrangement_i_fkey FOREIGN KEY (segment_choice_arrangement_id) REFERENCES xj.segment_choice_arrangement(id);


--
-- Name: segment_choice_arrangement_pick segment_choice_arrangement_pick_segment_id_fkey; Type: FK CONSTRAINT; Schema: xj; Owner: root
--

ALTER TABLE ONLY xj.segment_choice_arrangement_pick
    ADD CONSTRAINT segment_choice_arrangement_pick_segment_id_fkey FOREIGN KEY (segment_id) REFERENCES xj.segment(id);


--
-- Name: segment_choice_arrangement segment_choice_arrangement_segment_choice_id_fkey; Type: FK CONSTRAINT; Schema: xj; Owner: root
--

ALTER TABLE ONLY xj.segment_choice_arrangement
    ADD CONSTRAINT segment_choice_arrangement_segment_choice_id_fkey FOREIGN KEY (segment_choice_id) REFERENCES xj.segment_choice(id);


--
-- Name: segment_choice_arrangement segment_choice_arrangement_segment_id_fkey; Type: FK CONSTRAINT; Schema: xj; Owner: root
--

ALTER TABLE ONLY xj.segment_choice_arrangement
    ADD CONSTRAINT segment_choice_arrangement_segment_id_fkey FOREIGN KEY (segment_id) REFERENCES xj.segment(id);


--
-- Name: segment_choice segment_choice_segment_id_fkey; Type: FK CONSTRAINT; Schema: xj; Owner: root
--

ALTER TABLE ONLY xj.segment_choice
    ADD CONSTRAINT segment_choice_segment_id_fkey FOREIGN KEY (segment_id) REFERENCES xj.segment(id);


--
-- Name: segment_chord segment_chord_segment_id_fkey; Type: FK CONSTRAINT; Schema: xj; Owner: root
--

ALTER TABLE ONLY xj.segment_chord
    ADD CONSTRAINT segment_chord_segment_id_fkey FOREIGN KEY (segment_id) REFERENCES xj.segment(id);


--
-- Name: segment_meme segment_meme_segment_id_fkey; Type: FK CONSTRAINT; Schema: xj; Owner: root
--

ALTER TABLE ONLY xj.segment_meme
    ADD CONSTRAINT segment_meme_segment_id_fkey FOREIGN KEY (segment_id) REFERENCES xj.segment(id);


--
-- Name: segment_message segment_message_segment_id_fkey; Type: FK CONSTRAINT; Schema: xj; Owner: root
--

ALTER TABLE ONLY xj.segment_message
    ADD CONSTRAINT segment_message_segment_id_fkey FOREIGN KEY (segment_id) REFERENCES xj.segment(id);


--
-- Name: user_auth_token user_auth_token_user_auth_id_fkey; Type: FK CONSTRAINT; Schema: xj; Owner: root
--

ALTER TABLE ONLY xj.user_auth_token
    ADD CONSTRAINT user_auth_token_user_auth_id_fkey FOREIGN KEY (user_auth_id) REFERENCES xj.user_auth(id);


--
-- Name: user_auth_token user_auth_token_user_id_fkey; Type: FK CONSTRAINT; Schema: xj; Owner: root
--

ALTER TABLE ONLY xj.user_auth_token
    ADD CONSTRAINT user_auth_token_user_id_fkey FOREIGN KEY (user_id) REFERENCES xj."user"(id);


--
-- Name: user_auth user_auth_user_id_fkey; Type: FK CONSTRAINT; Schema: xj; Owner: root
--

ALTER TABLE ONLY xj.user_auth
    ADD CONSTRAINT user_auth_user_id_fkey FOREIGN KEY (user_id) REFERENCES xj."user"(id);


--
-- Name: user_role user_role_user_id_fkey; Type: FK CONSTRAINT; Schema: xj; Owner: root
--

ALTER TABLE ONLY xj.user_role
    ADD CONSTRAINT user_role_user_id_fkey FOREIGN KEY (user_id) REFERENCES xj."user"(id);


--
-- PostgreSQL database dump complete
--

