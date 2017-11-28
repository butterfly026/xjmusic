// Copyright (c) 2017, Outright Mental Inc. (https://w.outright.io) All Rights Reserved.
import { get } from '@ember/object';

import { inject as service } from '@ember/service';
import Route from '@ember/routing/route';

export default Route.extend({

  // Inject: flash message service
  display: service(),

  /**
   * Route Model
   * @returns {*|DS.Model|Promise}
   */
  model: function () {
    let account = this.modelFor('accounts.one');
    return this.store.createRecord('library', {
      account: account
    });
  },

  /**
   * Route Actions
   */
  actions: {

    createLibrary(model) {
      model.save().then(
        () => {
          get(this, 'display').success('Created library ' + model.get('name') + '.');
          this.transitionTo('accounts.one.libraries.one', model);
        }, (error) => {
          get(this, 'display').error(error);
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

    cancelCreateLibrary(transition)
    {
      let model = this.controller.get('model');
      if (model.get('hasDirtyAttributes')) {
        let confirmation = confirm("Your changes haven't saved yet. Would you like to leave this form?");
        if (confirmation) {
          model.rollbackAttributes();
          this.transitionTo('accounts.one.libraries');

        } else {
          transition.abort();
        }
      }
    }


  }
});