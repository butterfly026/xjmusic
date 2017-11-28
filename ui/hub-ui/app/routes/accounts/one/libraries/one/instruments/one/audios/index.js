// Copyright (c) 2017, Outright Mental Inc. (https://w.outright.io) All Rights Reserved.
import { get } from '@ember/object';

import { Promise as EmberPromise, hash } from 'rsvp';
import { inject as service } from '@ember/service';
import Route from '@ember/routing/route';

export default Route.extend({

  // Inject: authentication service
  auth: service(),

  // Inject: configuration service
  config: service(),

  // Inject: flash message service
  display: service(),

  /**
   * Route Model
   * @returns {Ember.RSVP.Promise}
   */
  model: function () {
    let self = this;
    let auth = this.get('auth');

    if (auth.isArtist || auth.isAdmin) {
      return new EmberPromise((resolve, reject) => {
        get(self, 'config').promises.config.then(
          (config) => {
            let instrument = self.modelFor('accounts.one.libraries.one.instruments.one');
            let audios = self.store.query('audio', {instrumentId: instrument.get('id')})
              .catch((error) => {
                get(self, 'display').error(error);
                self.transitionTo('');
              });
            resolve(hash({
              instrument: instrument,
              audioBaseUrl: config.audioBaseUrl,
              audios: audios,
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
   * Route Actions
   */
  actions: {

    editAudio(model) {
      this.transitionTo('accounts.one.libraries.one.instruments.one.audios.one', model.instrument.library.account, model.instrument.library, model.instrument, model);
    },
  }

});