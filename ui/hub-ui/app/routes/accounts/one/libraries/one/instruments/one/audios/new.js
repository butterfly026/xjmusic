//  Copyright (c) 2018, XJ Music Inc. (https://xj.io) All Rights Reserved.
import {later} from '@ember/runloop';
import {isEmpty} from '@ember/utils';
import $ from 'jquery';
import {get, set} from '@ember/object';
import {inject as service} from '@ember/service';
import Route from '@ember/routing/route';
import Uploader from 'ember-uploader/uploaders/uploader';
import RSVP from "rsvp";

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
   * @returns {Promise}
   */
  model: function () {
    let self = this;
    let auth = this.get('auth');

    if (auth.isArtist || auth.isAdmin) {
      return new RSVP.Promise((resolve, reject) => {
        get(this, 'config').promises.audioBaseUrl.then(
          (url) => {
            self.audioBaseUrl = url;
            resolve(self.store.createRecord('audio', {
              instrument: self.modelFor('accounts.one.libraries.one.instruments.one')
            }));
          },
          (error) => {
            reject(error);
          }
        );
      });
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

    createAudio(model) {
      let self = this;
      model.save().then(
        () => {
          self.afterSave();
        },
        (error) => {
          get(this, 'display').error(['Failed to save.', error]);
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

    cancelCreateAudio() {
      let model = this.controller.get('model');
      if (model.get('hasDirtyAttributes')) {
        let confirmation = confirm("Your changes haven't saved yet. Would you like to leave this form?");
        if (confirmation) {
          model.rollbackAttributes();
          this.transitionTo('accounts.one.libraries.one.instruments.one.audios', model.instrument.library.account, model.instrument.library, model.instrument);
        }
      }
    }

  },

  /**
   * Post- model.save() -hook
   */
  afterSave() {
    let self = this;
    let model = this.controller.get('model');
    let audioId = model.get('id');
    get(this, 'display').success('Created audio "' + model.get('name') + '".');

    $.ajax({
      url: '/api/1/audios/' + String(audioId) + '/upload'
    }).then(
      (result) => {
        self.didGetUploadAuthorization(result);
      }, (error) => {
        self.failedToGetUploadAuthorization(error);
      });
  },

  /**
   * we have upload authorization
   * @param result
   */
  didGetUploadAuthorization(result) {
    let self = this;
    let waveformKey = result.audio['waveformKey'];
    let uploadUrl = result.audio['uploadUrl'];
    let uploadPolicy = result.audio['uploadPolicy'];
    let signature = result.audio['uploadPolicySignature'];
    let awsAccessKeyId = result.audio['awsAccessKeyId'];
    let bucketName = result.audio['bucketName'];
    let acl = result.audio['acl'];

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
    get(this, 'display').success('Uploaded "' + this.audioBaseUrl + waveformKey);
    let model = this.controller.get('model');
    let instrument = model.get("instrument");
    let library = instrument.get("library");
    let account = library.get("account");
    let self = this;
    later(() => {
      self.transitionTo('accounts.one.libraries.one.instruments.one.audios.one', account, library, instrument, model);
    }, 2);
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
