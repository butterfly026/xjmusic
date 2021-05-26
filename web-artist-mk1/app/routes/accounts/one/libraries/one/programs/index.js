/*
 * Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.
 */
import {hash, Promise as EmberPromise} from 'rsvp';
import {inject as service} from '@ember/service';
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
   * @returns {*} hash
   */
  model: function () {
    let self = this;
    let library = self.modelFor('accounts.one.libraries.one');

    let programs = self.store.query('program', {libraryId: library.get('id'), detailed: true})
      .catch((error) => {
        self.display.error(error);
        self.transitionTo('');
      });

    return new EmberPromise((resolve, reject) => {
      self.config.getConfig().then(function () {
          let newProgram = self.store.createRecord('program', {
            type: self.config.programTypes[0],
            state: self.config.programStates[0],
            config: self.config.defaultProgramConfig,
            library: self.modelFor('accounts.one.libraries.one')
          });
          resolve(hash({
            library: library,
            programs: programs,
            newProgram: newProgram
          }, 'library, programs, new Program'));
        },
        (error) => {
          reject(error);
        }
      );
    });
  },

});