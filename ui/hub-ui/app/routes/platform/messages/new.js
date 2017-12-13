// Copyright (c) 2017, Outright Mental Inc. (https://w.outright.io) All Rights Reserved.
import {get} from '@ember/object';

import {inject as service} from '@ember/service';
import Route from '@ember/routing/route';

export default Route.extend({

  // Inject: flash message service
  display: service(),

  /**
   * Route Model
   * @returns {*|DS.Model|Promise}
   */
  model: function () {
    return this.store.createRecord('platformMessage');
  },

  /**
   * Route Actions
   */
  actions: {

    createMessage(model) {
      let self = this;
      model.save().then(
        () => {
          get(this, 'display').success('Created message ' + model.get('type') + ': "' + model.get('body') + '"');
          self.transitionTo('platform.messages');
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

    cancelCreateMessage(transition) {
      let model = this.controller.get('model');
      if (model.get('hasDirtyAttributes')) {
        let confirmation = confirm("Your changes haven't saved yet. Would you like to leave this form?");
        if (confirmation) {
          model.rollbackAttributes();
          this.transitionTo('platform.messages');
        } else {
          transition.abort();
        }
      }
    },
  }
});