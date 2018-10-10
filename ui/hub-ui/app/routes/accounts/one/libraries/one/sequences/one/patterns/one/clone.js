//  Copyright (c) 2018, XJ Music Inc. (https://xj.io) All Rights Reserved.
import { get } from '@ember/object';

import { hash, Promise as EmberPromise } from 'rsvp';
import { inject as service } from '@ember/service';
import Route from '@ember/routing/route';

export default Route.extend({

  // Inject: configuration service
  config: service(),

  // Inject: flash message service
  display: service(),

  /**
   * Model is a promise because it depends on promised configs
   * @returns {Ember.RSVP.Promise}
   */
  model() {
    return new EmberPromise((resolve, reject) => {
      let self = this;
      get(this, 'config').promises.config.then(
        () => {
          resolve(self.resolvedModel());
        },
        (error) => {
          reject('Could not instantiate new Pattern', error);
        }
      );
    });
  },

  /**
   * Resolved (with configs) model
   * @returns {*} hash
   */
  resolvedModel() {
    let fromPattern = this.modelFor('accounts.one.libraries.one.sequences.one.patterns.one');
    this.set('fromPatternId', fromPattern.get('id'));
    let pattern = this.store.createRecord('pattern', {
      name: fromPattern.get('name'),
      type: fromPattern.get('type'),
      sequence: fromPattern.get('sequence'),
      offset: fromPattern.get('offset')
    });

    return hash({
      sequences: this.store.query('sequence', {}),
      pattern: pattern
    }, 'sequences, pattern');
  },

  /**
   * Route Actions
   */
  actions: {

    sessionChanged: function () {
      this.refresh();
    },

    clonePattern(model) {
      if (!model) {
        get(this, 'display').warning('Not enough information to clone.');
        return;
      }

      let sequence = model.get('sequence');
      let library = sequence.get('library');
      let account = library.get('account');
      let clonePatternId = this.get('fromPatternId');

      model.save({
        adapterOptions: {
          query: {
            cloneId: clonePatternId
          }
        }
      }).then(
        () => {
          get(this, 'display').success('Cloned pattern ' + model.get('name') + '.');
          this.transitionTo('accounts.one.libraries.one.sequences.one.patterns.one', account, library, sequence, model);
        },
        (error) => {
          get(this, 'display').error(error);
        });
    },

  },

});