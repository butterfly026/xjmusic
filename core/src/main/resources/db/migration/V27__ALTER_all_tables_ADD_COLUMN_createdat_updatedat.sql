ALTER TABLE `account`
  ADD COLUMN `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE `account`
  ADD COLUMN `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
  ON UPDATE CURRENT_TIMESTAMP;

ALTER TABLE `account_user`
  ADD COLUMN `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE `account_user`
  ADD COLUMN `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
  ON UPDATE CURRENT_TIMESTAMP;

ALTER TABLE `arrangement`
  ADD COLUMN `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE `arrangement`
  ADD COLUMN `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
  ON UPDATE CURRENT_TIMESTAMP;

ALTER TABLE `audio`
  ADD COLUMN `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE `audio`
  ADD COLUMN `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
  ON UPDATE CURRENT_TIMESTAMP;

ALTER TABLE `audio_chord`
  ADD COLUMN `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE `audio_chord`
  ADD COLUMN `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
  ON UPDATE CURRENT_TIMESTAMP;

ALTER TABLE `audio_event`
  ADD COLUMN `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE `audio_event`
  ADD COLUMN `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
  ON UPDATE CURRENT_TIMESTAMP;

ALTER TABLE `chain`
  ADD COLUMN `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE `chain`
  ADD COLUMN `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
  ON UPDATE CURRENT_TIMESTAMP;

ALTER TABLE `chain_library`
  ADD COLUMN `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE `chain_library`
  ADD COLUMN `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
  ON UPDATE CURRENT_TIMESTAMP;

ALTER TABLE `choice`
  ADD COLUMN `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE `choice`
  ADD COLUMN `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
  ON UPDATE CURRENT_TIMESTAMP;

ALTER TABLE `idea`
  ADD COLUMN `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE `idea`
  ADD COLUMN `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
  ON UPDATE CURRENT_TIMESTAMP;

ALTER TABLE `idea_meme`
  ADD COLUMN `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE `idea_meme`
  ADD COLUMN `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
  ON UPDATE CURRENT_TIMESTAMP;

ALTER TABLE `instrument`
  ADD COLUMN `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE `instrument`
  ADD COLUMN `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
  ON UPDATE CURRENT_TIMESTAMP;

ALTER TABLE `instrument_meme`
  ADD COLUMN `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE `instrument_meme`
  ADD COLUMN `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
  ON UPDATE CURRENT_TIMESTAMP;

ALTER TABLE `library`
  ADD COLUMN `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE `library`
  ADD COLUMN `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
  ON UPDATE CURRENT_TIMESTAMP;

ALTER TABLE `link`
  ADD COLUMN `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE `link`
  ADD COLUMN `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
  ON UPDATE CURRENT_TIMESTAMP;

ALTER TABLE `link_chord`
  ADD COLUMN `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE `link_chord`
  ADD COLUMN `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
  ON UPDATE CURRENT_TIMESTAMP;

ALTER TABLE `morph`
  ADD COLUMN `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE `morph`
  ADD COLUMN `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
  ON UPDATE CURRENT_TIMESTAMP;

ALTER TABLE `phase`
  ADD COLUMN `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE `phase`
  ADD COLUMN `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
  ON UPDATE CURRENT_TIMESTAMP;

ALTER TABLE `phase_chord`
  ADD COLUMN `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE `phase_chord`
  ADD COLUMN `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
  ON UPDATE CURRENT_TIMESTAMP;

ALTER TABLE `phase_meme`
  ADD COLUMN `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE `phase_meme`
  ADD COLUMN `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
  ON UPDATE CURRENT_TIMESTAMP;

ALTER TABLE `pick`
  ADD COLUMN `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE `pick`
  ADD COLUMN `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
  ON UPDATE CURRENT_TIMESTAMP;

ALTER TABLE `point`
  ADD COLUMN `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE `point`
  ADD COLUMN `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
  ON UPDATE CURRENT_TIMESTAMP;

ALTER TABLE `user`
  ADD COLUMN `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE `user`
  ADD COLUMN `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
  ON UPDATE CURRENT_TIMESTAMP;

ALTER TABLE `user_access_token`
  ADD COLUMN `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE `user_access_token`
  ADD COLUMN `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
  ON UPDATE CURRENT_TIMESTAMP;

ALTER TABLE `user_auth`
  ADD COLUMN `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE `user_auth`
  ADD COLUMN `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
  ON UPDATE CURRENT_TIMESTAMP;

ALTER TABLE `user_role`
  ADD COLUMN `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE `user_role`
  ADD COLUMN `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
  ON UPDATE CURRENT_TIMESTAMP;

ALTER TABLE `voice`
  ADD COLUMN `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE `voice`
  ADD COLUMN `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
  ON UPDATE CURRENT_TIMESTAMP;

ALTER TABLE `voice_event`
  ADD COLUMN `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
ALTER TABLE `voice_event`
  ADD COLUMN `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
  ON UPDATE CURRENT_TIMESTAMP;

