// Copyright (c) 2017, Outright Mental Inc. (https://w.outright.io) All Rights Reserved.
import { set, get } from '@ember/object';

import { inject as service } from '@ember/service';
import Route from '@ember/routing/route';

export default Route.extend({

  // Inject: flash message service
  display: service(),

  /**
   * Route Model
   * @param params
   * @returns {Promise.<T>}
   */
  model(params) {
    let self = this;
    return this.store.findRecord('user', params.user_id)
      .catch((error) => {
        get(self, 'display').error(error);
        self.transitionTo('users');
      });
  },

  /**
   * Breadcrumb & Headline
   * @param model
   */
  afterModel(model) {
    set(this, 'breadCrumb', {
      title: model.get("name")
    });
  },

  /**
   * Route Actions
   */
  actions: {

    saveUser(model) {
      model.save().then(
        () => {
          get(this, 'display').success('Updated user ' + model.get('name') + '.');
          this.transitionTo('users');
        },
        (error) => {
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

  },

});