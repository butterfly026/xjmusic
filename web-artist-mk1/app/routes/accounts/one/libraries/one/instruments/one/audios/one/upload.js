/*
 * Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.
 */
import {isEmpty} from '@ember/utils';
import $ from 'jquery';
import Uploader from 'ember-uploader/uploaders/uploader';
import {get, set} from '@ember/object';
import {later} from '@ember/runloop';

import {inject as service} from '@ember/service';
import Route from '@ember/routing/route';

export default Route.extend({

  // stub for instantiating an uploader
  uploader: {},

  // Inject: authentication service
  auth: service(),

  // Inject: configuration service
  config: service(),

  // Inject: flash message service
  display: service(),

  // audio base url will be set by promise after config resolves
  audioBaseUrl: '',

  /**
   * Route Model
   * @returns {*}
   */
  model() {
    let auth = this.get('auth');
    if (auth.isArtist || auth.isAdmin) {
      let instrument = this.modelFor('accounts.one.libraries.one.instruments.one');
      let audio = this.modelFor('accounts.one.libraries.one.instruments.one.audios.one');
      audio.set('instrument', instrument);
      return audio;
    } else {
      history.back();
    }
  },

  /**
   * For Uploading a file
   */
  uploadFiles: [],

  /**
   * Route Actions
   */
  actions: {

    filesChanged: function (files) {
      set(this, 'uploadFiles', files);
    },

    saveAudio() {
      let self = this;
      let model = this.controller.get('model');
      let audioId = model.get('id');
      get(this, 'display').success('Created audio "' + model.get('name') + '".');

      $.ajax({
        url: '/api/1/instrument-audios/' + String(audioId) + '/upload'
      }).then(
        (result) => {
          self.didGetUploadAuthorization(result);
        }, (error) => {
          self.failedToGetUploadAuthorization(error);
        });
    },

    willTransition(transition) {
      let model = this.controller.get('model');
      if (model.get('hasDirtyAttributes')) {
        let confirmation = confirm("Your changes haven't saved yet. Would you like to leave this form?");
        if (confirmation) {
          model.rollbackAttributes();
        } else {
          transition.abort();
        }
      }
    },

    cancel() {
      history.back();
    },

  },

  /**
   * we have upload authorization
   * @param result
   */
  didGetUploadAuthorization(result) {
    console.debug("did get upload authorization", result);
    let self = this;
    let waveformKey = result['waveformKey'];
    let uploadUrl = result['uploadUrl'];
    let uploadPolicy = result['uploadPolicy'];
    let signature = result['uploadPolicySignature'];
    let awsAccessKeyId = result['awsAccessKeyId'];
    let bucketName = result['bucketName'];
    let acl = result['acl'];

    self.uploader = Uploader.create({
      url: uploadUrl,
      method: 'POST'
    });

    self.uploader.on('progress', e => {
      console.debug("Upload progress: " + e.percent);
    });

    let files = get(self, 'uploadFiles');
    if (!isEmpty(files)) {
      self.uploadFile(files[0], waveformKey, uploadPolicy, signature, awsAccessKeyId, bucketName, acl);
    }
  },

  /**
   * we failed to get upload authorization
   */
  failedToGetUploadAuthorization(error) {
    this.throwError('Failed to get upload authorization.', error);
  },

  /**
   * upload the file to a 3rd party storage resource (e.g. Amazon S3)
   * @param file
   * @param waveformKey
   * @param uploadPolicy
   * @param signature
   * @param awsAccessKeyId
   * @param bucketName
   * @param acl
   */
  uploadFile(file, waveformKey, uploadPolicy, signature, awsAccessKeyId, bucketName, acl) {
    let self = this;
    console.debug("Will uploadFile(...)", {
      file: file,
      waveformKey: waveformKey,
      uploadPolicy: uploadPolicy,
      signature: signature,
      awsAccessKeyId: awsAccessKeyId,
      bucketName: bucketName,
      acl: acl
    });
    self.get("uploader").upload(file, {
      key: waveformKey,
      policy: uploadPolicy,
      signature: signature,
      awsAccessKeyId: awsAccessKeyId,
      bucket: bucketName,
      acl: acl
    }).then(() => {
      self.didUploadFile(waveformKey);
    }, (error) => {
      self.failedToUploadFile(error, waveformKey);
    });
  },

  /**
   * we have uploaded the file successfully
   * @param waveformKey
   */
  didUploadFile(waveformKey) {
    let self = this;
    get(this, 'display').success('Uploaded "' + this.audioBaseUrl + waveformKey);
    let model = this.controller.get('model');
    model.set("waveformKey", waveformKey);
    model.save().then(
      () => {
        get(this, 'display').success('Updated audio "' + model.get('name') + '".');
        let instrument = model.get("instrument");
        let library = instrument.get("library");
        let account = library.get("account");
        self.transitionTo('accounts.one.libraries.one.instruments.one', account, library, instrument);
        later(() => {
          self.transitionTo('accounts.one.libraries.one.instruments.one.audios.one', account, library, instrument, model);
        }, 1);
      },
      (error) => {
        get(this, 'display').error(error);
      });
  },

  /**
   * we failed to upload the audio file
   * @param error
   * @param waveformKey
   */
  failedToUploadFile(error, waveformKey) {
    this.throwError('Failed to upload "' + this.audioBaseUrl + waveformKey, error);
  },

  /**
   * Log errors in console and flash message
   * @param msg
   * @param error
   */
  throwError(msg, error) {
    get(this, 'display').error([msg]);
    console.error(msg, error);
  }

});