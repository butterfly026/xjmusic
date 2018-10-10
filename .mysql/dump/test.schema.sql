# Copyright (c) 2018, XJ Music Inc. (https://xj.io) All Rights Reserved.

-- MySQL dump 10.13  Distrib 5.7.23, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: xj_test
-- ------------------------------------------------------
-- Server version	5.6.34

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `account_user`
--

DROP TABLE IF EXISTS `account_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_user` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `account_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `account_user_fk_account_idx` (`account_id`),
  KEY `account_user_fk_user_idx` (`user_id`),
  CONSTRAINT `account_user_fk_account` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `account_user_fk_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `arrangement`
--

DROP TABLE IF EXISTS `arrangement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `arrangement` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `choice_id` bigint(20) unsigned NOT NULL,
  `voice_id` bigint(20) unsigned NOT NULL,
  `instrument_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `arrangement_fk_choice_idx` (`choice_id`),
  KEY `arrangement_fk_voice_idx` (`voice_id`),
  KEY `arrangement_fk_instrument_idx` (`instrument_id`),
  CONSTRAINT `arrangement_fk_choice` FOREIGN KEY (`choice_id`) REFERENCES `choice` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `arrangement_fk_instrument` FOREIGN KEY (`instrument_id`) REFERENCES `instrument` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `arrangement_fk_voice` FOREIGN KEY (`voice_id`) REFERENCES `voice` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `audio`
--

DROP TABLE IF EXISTS `audio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `audio` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `instrument_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `waveform_key` varchar(2047) NOT NULL,
  `start` float unsigned DEFAULT NULL,
  `length` float unsigned DEFAULT NULL,
  `tempo` float unsigned NOT NULL,
  `pitch` float unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `state` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `audio_fk_instrument_idx` (`instrument_id`),
  CONSTRAINT `audio_fk_instrument` FOREIGN KEY (`instrument_id`) REFERENCES `instrument` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `audio_chord`
--

DROP TABLE IF EXISTS `audio_chord`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `audio_chord` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `audio_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `position` float NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `chord_fk_audio_idx` (`audio_id`),
  CONSTRAINT `chord_fk_audio` FOREIGN KEY (`audio_id`) REFERENCES `audio` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `audio_event`
--

DROP TABLE IF EXISTS `audio_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `audio_event` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `audio_id` bigint(20) unsigned NOT NULL,
  `velocity` float unsigned NOT NULL,
  `tonality` float unsigned NOT NULL,
  `inflection` varchar(63) NOT NULL,
  `position` float NOT NULL,
  `duration` float unsigned NOT NULL,
  `note` varchar(63) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `event_fk_audio_idx` (`audio_id`),
  CONSTRAINT `event_fk_audio` FOREIGN KEY (`audio_id`) REFERENCES `audio` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `chain`
--

DROP TABLE IF EXISTS `chain`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chain` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `account_id` bigint(20) unsigned NOT NULL,
  `state` varchar(255) NOT NULL,
  `start_at` timestamp(6) NULL DEFAULT NULL,
  `stop_at` timestamp(6) NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `embed_key` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `unique_embed_key` (`embed_key`),
  KEY `chain_fk_account` (`account_id`),
  CONSTRAINT `chain_fk_account` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `chain_config`
--

DROP TABLE IF EXISTS `chain_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chain_config` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `chain_id` bigint(20) unsigned NOT NULL,
  `type` varchar(255) NOT NULL,
  `value` varchar(32768) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `chain_config_fk_chain_idx` (`chain_id`),
  CONSTRAINT `chain_config_fk_chain` FOREIGN KEY (`chain_id`) REFERENCES `chain` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `chain_instrument`
--

DROP TABLE IF EXISTS `chain_instrument`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chain_instrument` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `chain_id` bigint(20) unsigned NOT NULL,
  `instrument_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `chain_instrument_fk_chain_idx` (`chain_id`),
  KEY `chain_instrument_fk_instrument_idx` (`instrument_id`),
  CONSTRAINT `chain_instrument_fk_chain` FOREIGN KEY (`chain_id`) REFERENCES `chain` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `chain_instrument_fk_instrument` FOREIGN KEY (`instrument_id`) REFERENCES `instrument` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `chain_library`
--

DROP TABLE IF EXISTS `chain_library`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chain_library` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `chain_id` bigint(20) unsigned NOT NULL,
  `library_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `chain_library_fk_chain_idx` (`chain_id`),
  KEY `chain_library_fk_library_idx` (`library_id`),
  CONSTRAINT `chain_library_fk_chain` FOREIGN KEY (`chain_id`) REFERENCES `chain` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `chain_library_fk_library` FOREIGN KEY (`library_id`) REFERENCES `library` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `chain_sequence`
--

DROP TABLE IF EXISTS `chain_sequence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `chain_sequence` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `chain_id` bigint(20) unsigned NOT NULL,
  `sequence_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `chain_sequence_fk_chain` (`chain_id`),
  KEY `chain_sequence_fk_sequence` (`sequence_id`),
  CONSTRAINT `chain_sequence_fk_chain` FOREIGN KEY (`chain_id`) REFERENCES `chain` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `chain_sequence_fk_sequence` FOREIGN KEY (`sequence_id`) REFERENCES `sequence` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `choice`
--

DROP TABLE IF EXISTS `choice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `choice` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `segment_id` bigint(20) unsigned NOT NULL,
  `sequence_id` bigint(20) unsigned NOT NULL,
  `type` varchar(255) NOT NULL,
  `transpose` int(11) NOT NULL,
  `pattern_offset` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `choice_fk_segment` (`segment_id`),
  KEY `choice_fk_sequence` (`sequence_id`),
  CONSTRAINT `choice_fk_segment` FOREIGN KEY (`segment_id`) REFERENCES `segment` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `choice_fk_sequence` FOREIGN KEY (`sequence_id`) REFERENCES `sequence` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `instrument`
--

DROP TABLE IF EXISTS `instrument`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `instrument` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `library_id` bigint(20) unsigned NOT NULL,
  `type` varchar(255) NOT NULL,
  `description` varchar(1023) NOT NULL,
  `density` float unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `instrument_fk_library_idx` (`library_id`),
  KEY `instrument_fk_user` (`user_id`),
  CONSTRAINT `instrument_fk_library` FOREIGN KEY (`library_id`) REFERENCES `library` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `instrument_fk_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `instrument_meme`
--

DROP TABLE IF EXISTS `instrument_meme`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `instrument_meme` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `instrument_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `meme_fk_instrument_idx` (`instrument_id`),
  CONSTRAINT `meme_fk_instrument` FOREIGN KEY (`instrument_id`) REFERENCES `instrument` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `library`
--

DROP TABLE IF EXISTS `library`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `library` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `account_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `library_fk_account_idx` (`account_id`),
  CONSTRAINT `library_fk_account` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pattern`
--

DROP TABLE IF EXISTS `pattern`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pattern` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `sequence_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `offset` bigint(20) unsigned NOT NULL,
  `total` int(10) unsigned DEFAULT NULL,
  `density` float unsigned DEFAULT NULL,
  `key` varchar(255) DEFAULT NULL,
  `tempo` float unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `state` varchar(255) NOT NULL,
  `meter_super` int(11) DEFAULT NULL,
  `meter_sub` int(11) DEFAULT NULL,
  `meter_swing` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `pattern_fk_sequence` (`sequence_id`),
  CONSTRAINT `pattern_fk_sequence` FOREIGN KEY (`sequence_id`) REFERENCES `sequence` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pattern_chord`
--

DROP TABLE IF EXISTS `pattern_chord`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pattern_chord` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `pattern_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `position` float NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `pattern_chord_fk_pattern` (`pattern_id`),
  CONSTRAINT `pattern_chord_fk_pattern` FOREIGN KEY (`pattern_id`) REFERENCES `pattern` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pattern_event`
--

DROP TABLE IF EXISTS `pattern_event`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pattern_event` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `pattern_id` bigint(20) unsigned NOT NULL,
  `voice_id` bigint(20) unsigned NOT NULL,
  `velocity` float unsigned NOT NULL,
  `tonality` float unsigned NOT NULL,
  `inflection` varchar(63) NOT NULL,
  `position` float NOT NULL,
  `duration` float unsigned NOT NULL,
  `note` varchar(63) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `pattern_event_fk_pattern` (`pattern_id`),
  KEY `pattern_event_fk_voice` (`voice_id`),
  CONSTRAINT `pattern_event_fk_pattern` FOREIGN KEY (`pattern_id`) REFERENCES `pattern` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `pattern_event_fk_voice` FOREIGN KEY (`voice_id`) REFERENCES `voice` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pattern_meme`
--

DROP TABLE IF EXISTS `pattern_meme`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pattern_meme` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `pattern_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `pattern_meme_fk_pattern` (`pattern_id`),
  CONSTRAINT `pattern_meme_fk_pattern` FOREIGN KEY (`pattern_id`) REFERENCES `pattern` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `platform_message`
--

DROP TABLE IF EXISTS `platform_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `platform_message` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `body` text NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `schema_version`
--

DROP TABLE IF EXISTS `schema_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema_version` (
  `installed_rank` int(11) NOT NULL,
  `version` varchar(50) DEFAULT NULL,
  `description` varchar(200) NOT NULL,
  `type` varchar(20) NOT NULL,
  `script` varchar(1000) NOT NULL,
  `checksum` int(11) DEFAULT NULL,
  `installed_by` varchar(100) NOT NULL,
  `installed_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `execution_time` int(11) NOT NULL,
  `success` tinyint(1) NOT NULL,
  PRIMARY KEY (`installed_rank`),
  KEY `schema_version_s_idx` (`success`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `segment`
--

DROP TABLE IF EXISTS `segment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `segment` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `chain_id` bigint(20) unsigned NOT NULL,
  `offset` bigint(20) unsigned NOT NULL,
  `state` varchar(255) NOT NULL,
  `begin_at` timestamp(6) NULL DEFAULT NULL,
  `end_at` timestamp(6) NULL DEFAULT NULL,
  `total` int(10) unsigned DEFAULT NULL,
  `density` float unsigned DEFAULT NULL,
  `key` varchar(255) DEFAULT NULL,
  `tempo` float unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `waveform_key` varchar(2047) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `unique_chain_offset_index` (`chain_id`,`offset`),
  CONSTRAINT `segment_fk_chain` FOREIGN KEY (`chain_id`) REFERENCES `chain` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `segment_chord`
--

DROP TABLE IF EXISTS `segment_chord`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `segment_chord` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `segment_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `position` float NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `chord_fk_segment` (`segment_id`),
  CONSTRAINT `chord_fk_segment` FOREIGN KEY (`segment_id`) REFERENCES `segment` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `segment_meme`
--

DROP TABLE IF EXISTS `segment_meme`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `segment_meme` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `segment_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `meme_fk_segment` (`segment_id`),
  CONSTRAINT `meme_fk_segment` FOREIGN KEY (`segment_id`) REFERENCES `segment` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `segment_message`
--

DROP TABLE IF EXISTS `segment_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `segment_message` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `segment_id` bigint(20) unsigned NOT NULL,
  `type` varchar(255) NOT NULL,
  `body` text NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `message_fk_segment` (`segment_id`),
  CONSTRAINT `message_fk_segment` FOREIGN KEY (`segment_id`) REFERENCES `segment` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sequence`
--

DROP TABLE IF EXISTS `sequence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sequence` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `library_id` bigint(20) unsigned NOT NULL,
  `type` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `density` float unsigned NOT NULL,
  `key` varchar(255) NOT NULL,
  `tempo` float unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `state` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `sequence_fk_user` (`user_id`),
  KEY `sequence_fk_library` (`library_id`),
  CONSTRAINT `sequence_fk_library` FOREIGN KEY (`library_id`) REFERENCES `library` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `sequence_fk_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sequence_meme`
--

DROP TABLE IF EXISTS `sequence_meme`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sequence_meme` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `sequence_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `sequence_meme_fk_sequence` (`sequence_id`),
  CONSTRAINT `sequence_meme_fk_sequence` FOREIGN KEY (`sequence_id`) REFERENCES `sequence` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(1023) DEFAULT NULL,
  `avatar_url` varchar(1023) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_access_token`
--

DROP TABLE IF EXISTS `user_access_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_access_token` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_auth_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `access_token` text NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `user_access_token_fk_user_idx` (`user_id`),
  KEY `user_access_token_fk_user_auth_idx` (`user_auth_id`),
  CONSTRAINT `user_access_token_fk_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_access_token_fk_user_auth` FOREIGN KEY (`user_auth_id`) REFERENCES `user_auth` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_auth`
--

DROP TABLE IF EXISTS `user_auth`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_auth` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `external_access_token` varchar(1023) NOT NULL,
  `external_refresh_token` varchar(1023) DEFAULT NULL,
  `external_account` varchar(1023) NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `user_auth_fk_user_idx` (`user_id`),
  CONSTRAINT `user_auth_fk_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_role`
--

DROP TABLE IF EXISTS `user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_role` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `user_role_fk_user_idx` (`user_id`),
  CONSTRAINT `user_role_fk_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `voice`
--

DROP TABLE IF EXISTS `voice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `voice` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `sequence_id` bigint(20) unsigned NOT NULL,
  `type` varchar(255) NOT NULL,
  `description` varchar(1023) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `voice_fk_sequence` (`sequence_id`),
  CONSTRAINT `voice_fk_sequence` FOREIGN KEY (`sequence_id`) REFERENCES `sequence` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-10-10 20:53:11
-- MySQL dump 10.13  Distrib 5.7.23, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: xj_test
-- ------------------------------------------------------
-- Server version	5.6.34

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping data for table `schema_version`
--

LOCK TABLES `schema_version` WRITE;
/*!40000 ALTER TABLE `schema_version` DISABLE KEYS */;
INSERT INTO `schema_version` VALUES (1,'1','user auth','SQL','V1__user_auth.sql',447090788,'root','2018-08-30 15:48:58',154,1),(2,'2','account','SQL','V2__account.sql',-728725086,'root','2018-08-30 15:48:58',157,1),(3,'3','credit','SQL','V3__credit.sql',-385750700,'root','2018-08-30 15:48:58',79,1),(4,'4','library idea phase meme voice event','SQL','V4__library_idea_phase_meme_voice_event.sql',-1534808241,'root','2018-08-30 15:48:59',642,1),(5,'5','instrument meme audio chord event','SQL','V5__instrument_meme_audio_chord_event.sql',-1907897642,'root','2018-08-30 15:49:00',396,1),(6,'6','chain link chord choice','SQL','V6__chain_link_chord_choice.sql',-2093488888,'root','2018-08-30 15:49:00',331,1),(7,'7','arrangement morph point pick','SQL','V7__arrangement_morph_point_pick.sql',-1775760070,'root','2018-08-30 15:49:00',373,1),(8,'8','user auth column renaming','SQL','V8__user_auth_column_renaming.sql',-1774157694,'root','2018-08-30 15:49:00',35,1),(9,'9','user role','SQL','V9__user_role.sql',-2040912989,'root','2018-08-30 15:49:00',85,1),(10,'10','user access token','SQL','V10__user_access_token.sql',-1589285188,'root','2018-08-30 15:49:01',91,1),(11,'11','user auth column renaming','SQL','V11__user_auth_column_renaming.sql',342405360,'root','2018-08-30 15:49:01',14,1),(12,'12','RENAME account user TO account user role','SQL','V12__RENAME_account_user_TO_account_user_role.sql',569433197,'root','2018-08-30 15:49:01',31,1),(13,'14','ALTER user DROP COLUMN admin','SQL','V14__ALTER_user_DROP_COLUMN_admin.sql',660577316,'root','2018-08-30 15:49:01',101,1),(14,'15','ALTER account ADD COLUMN name','SQL','V15__ALTER_account_ADD_COLUMN_name.sql',2013415455,'root','2018-08-30 15:49:01',99,1),(15,'16','ALTER library ADD COLUMN name','SQL','V16__ALTER_library_ADD_COLUMN_name.sql',652666977,'root','2018-08-30 15:49:01',133,1),(16,'17','RENAME ALTER account user role TO account user','SQL','V17__RENAME_ALTER_account_user_role_TO_account_user.sql',-527669089,'root','2018-08-30 15:49:01',146,1),(17,'18','ALTER chain BELONGS TO account HAS MANY library','SQL','V18__ALTER_chain_BELONGS_TO_account_HAS_MANY_library.sql',407528039,'root','2018-08-30 15:49:02',363,1),(18,'19','DROP credit ALTER idea instrument belong directly to user','SQL','V19__DROP_credit_ALTER_idea_instrument_belong_directly_to_user.sql',-940090323,'root','2018-08-30 15:49:03',992,1),(19,'20','ALTER phase choice BIGINT offset total','SQL','V20__ALTER_phase_choice_BIGINT_offset_total.sql',1174421309,'root','2018-08-30 15:49:03',661,1),(20,'21','ALTER DROP order FORM instrument idea phase meme','SQL','V21__ALTER_DROP_order_FORM_instrument_idea_phase_meme.sql',-825269746,'root','2018-08-30 15:49:04',362,1),(21,'22','ALTER phase optional values','SQL','V22__ALTER_phase_optional_values.sql',2115016285,'root','2018-08-30 15:49:04',477,1),(22,'23','ALTER audio COLUMNS waveformUrl','SQL','V23__ALTER_audio_COLUMNS_waveformUrl.sql',-1407515541,'root','2018-08-30 15:49:04',174,1),(23,'24','ALTER audio FLOAT start length','SQL','V24__ALTER_audio_FLOAT_start_length.sql',-2000888804,'root','2018-08-30 15:49:05',325,1),(24,'25','ALTER chain ADD COLUMNS name state startat stopat','SQL','V25__ALTER_chain_ADD_COLUMNS_name_state_startat_stopat.sql',1356557345,'root','2018-08-30 15:49:05',491,1),(25,'26','ALTER link FLOAT start finish','SQL','V26__ALTER_link_FLOAT_start_finish.sql',-1185447213,'root','2018-08-30 15:49:06',332,1),(26,'27','ALTER all tables ADD COLUMN createdat updatedat','SQL','V27__ALTER_all_tables_ADD_COLUMN_createdat_updatedat.sql',-794640015,'root','2018-08-30 15:49:13',6857,1),(27,'28','ALTER chain link TIMESTAMP microsecond precision','SQL','V28__ALTER_chain_link_TIMESTAMP_microsecond_precision.sql',-1850945451,'root','2018-08-30 15:49:13',660,1),(28,'29','ALTER arrangement DROP COLUMNS name density tempo','SQL','V29__ALTER_arrangement_DROP_COLUMNS_name_density_tempo.sql',-1660342705,'root','2018-08-30 15:49:14',419,1),(29,'30','ALTER pick FLOAT start length','SQL','V30__ALTER_pick_FLOAT_start_length.sql',-1842518453,'root','2018-08-30 15:49:14',358,1),(30,'31','ALTER pick ADD BELONGS TO arrangement','SQL','V31__ALTER_pick_ADD_BELONGS_TO_arrangement.sql',1953331613,'root','2018-08-30 15:49:14',367,1),(31,'32','ALTER link OPTIONAL total density key tempo','SQL','V32__ALTER_link_OPTIONAL_total_density_key_tempo.sql',-98188439,'root','2018-08-30 15:49:15',486,1),(32,'33','ALTER link UNIQUE chain offset','SQL','V33__ALTER_link_UNIQUE_chain_offset.sql',1398816976,'root','2018-08-30 15:49:15',56,1),(33,'34','ALTER audio COLUMNS waveformKey','SQL','V34__ALTER_audio_COLUMNS_waveformKey.sql',66858661,'root','2018-08-30 15:49:15',19,1),(34,'35','CREATE TABLE chain config','SQL','V35__CREATE_TABLE_chain_config.sql',-2134731909,'root','2018-08-30 15:49:15',79,1),(35,'36','CREATE TABLE chain idea','SQL','V36__CREATE_TABLE_chain_idea.sql',2038472760,'root','2018-08-30 15:49:15',101,1),(36,'37','CREATE TABLE chain instrument','SQL','V37__CREATE_TABLE_chain_instrument.sql',1486524130,'root','2018-08-30 15:49:15',94,1),(37,'38','ALTER chain ADD COLUMN type','SQL','V38__ALTER_chain_ADD_COLUMN_type.sql',608321610,'root','2018-08-30 15:49:16',126,1),(38,'39','ALTER phase MODIFY COLUMN total No Longer Required','SQL','V39__ALTER_phase_MODIFY_COLUMN_total_No_Longer_Required.sql',-1504223876,'root','2018-08-30 15:49:16',115,1),(39,'40','ALTER choice MODIFY COLUMN phase offset ULONG','SQL','V40__ALTER_choice_MODIFY_COLUMN_phase_offset_ULONG.sql',-240451169,'root','2018-08-30 15:49:16',171,1),(40,'41','CREATE TABLE link meme','SQL','V41__CREATE_TABLE_link_meme.sql',-18883080,'root','2018-08-30 15:49:16',89,1),(41,'42','ALTER phase link INT total','SQL','V42__ALTER_phase_link_INT_total.sql',-1400879099,'root','2018-08-30 15:49:16',375,1),(42,'43','CREATE TABLE link message','SQL','V43__CREATE_TABLE_link_message.sql',1616909549,'root','2018-08-30 15:49:16',83,1),(43,'44','ALTER pick BELONGS TO arrangement DROP morph point','SQL','V44__ALTER_pick_BELONGS_TO_arrangement_DROP_morph_point.sql',449955118,'root','2018-08-30 15:49:17',194,1),(44,'45','ALTER link ADD COLUMN waveform key','SQL','V45__ALTER_link_ADD_COLUMN_waveform_key.sql',-98370,'root','2018-08-30 15:49:17',127,1),(45,'46','ALTER audio ADD COLUMN state','SQL','V46__ALTER_audio_ADD_COLUMN_state.sql',-1300058820,'root','2018-08-30 15:49:17',240,1),(46,'47','ALTER chain ADD COLUMN embed key','SQL','V47__ALTER_chain_ADD_COLUMN_embed_key.sql',317233573,'root','2018-08-30 15:49:17',173,1),(47,'48','CREATE TABLE platform message','SQL','V48__CREATE_TABLE_platform_message.sql',-1332226532,'root','2018-08-30 15:49:17',76,1),(48,'49','CREATE pattern DEPRECATES idea','SQL','V49__CREATE_pattern_DEPRECATES_idea.sql',517513730,'root','2018-08-30 15:49:19',1550,1),(49,'50','REFACTOR voice BELONGS TO pattern','SQL','V50__REFACTOR_voice_BELONGS_TO_pattern.sql',1202195806,'root','2018-08-30 15:49:20',1078,1),(50,'51','DROP TABLE pick','SQL','V51__DROP_TABLE_pick.sql',-319463966,'root','2018-08-30 15:49:20',80,1),(51,'52','ALTER phase ADD COLUMN type','SQL','V52__ALTER_phase_ADD_COLUMN_type.sql',-95957482,'root','2018-08-30 15:49:20',243,1),(52,'53','ALTER chord MODIFY COLUMN position INTEGER','SQL','V53__ALTER_chord_MODIFY_COLUMN_position_INTEGER.sql',523400926,'root','2018-08-30 15:49:21',488,1),(53,'54','RENAME voice event TO phase event','SQL','V54__RENAME_voice_event_TO_phase_event.sql',-370585949,'root','2018-08-30 15:49:21',35,1),(54,'55','ALTER pattern phase ADD COLUMN state','SQL','V55__ALTER_pattern_phase_ADD_COLUMN_state.sql',-1299872216,'root','2018-08-30 15:49:22',522,1),(55,'56','ALTER chord MODIFY COLUMN position FLOAT','SQL','V56__ALTER_chord_MODIFY_COLUMN_position_FLOAT.sql',-894225407,'root','2018-08-30 15:49:22',499,1),(56,'57','REFACTORING chain segment sequence pattern','SQL','V57__REFACTORING_chain_segment_sequence_pattern.sql',-1235024870,'root','2018-08-30 15:49:26',4047,1),(57,'58','ALTER pattern ADD COLUMNS meter','SQL','V58__ALTER_pattern_ADD_COLUMNS_meter.sql',1342735981,'root','2018-08-30 15:49:27',357,1);
/*!40000 ALTER TABLE `schema_version` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-10-10 20:53:11