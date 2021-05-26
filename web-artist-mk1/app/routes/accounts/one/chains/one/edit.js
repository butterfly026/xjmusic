/*
 * Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.
 */

import {hash, Promise as EmberPromise} from 'rsvp';
import {inject as service} from '@ember/service';
import Route from '@ember/routing/route';

export default Route.extend({

  // Inject: flash message service
  display: service(),

  // Inject: configuration service
  config: service(),

  /**
   * Model is a promise because it depends on promised configs
   * @returns {Promise}
   */
  model() {
    return new EmberPromise((resolve, reject) => {
      let self = this;
      this.config.getConfig().then(
        () => {
          resolve(self.resolvedModel());
        },
        (error) => {
          reject('Could not instantiate Chain model', error);
        }
      );
    });
  },

  /**
   * Resolved (with configs) model
   * @returns {*} hash
   */
  resolvedModel() {
    let account = this.modelFor('accounts.one');
    let chain = this.modelFor('accounts.one.chains.one');
    chain.set('account', account);
    return hash({
      chain: chain,
      chainFromState: chain.get('state')
    }, 'chain and its from-state');
  },

  /**
   * Route Actions
   */
  actions: {

    saveChain(model) {
      model.save().then(
        () => {
          this.display.success('Updated chain.');
          history.back();
        },
        (error) => {
          this.display.error(error);
        });
    },

    willTransition(transition) {
      let model = this.controller.get('model.chain');
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

  }

});