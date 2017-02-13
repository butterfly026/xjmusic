// Copyright (c) 2017, Outright Mental Inc. (http://outright.io) All Rights Reserved.
import Ember from 'ember';

export default Ember.Route.extend({

  auth: Ember.inject.service(),

  display: Ember.inject.service(),

  model: function () {
    let auth = this.get('auth');
    if (auth.isArtist || auth.isAdmin) {
      return this.store.createRecord('audio-event', {
        audio: this.modelFor('accounts.one.libraries.one.instruments.one.audios.one')
      });
    } else {
      this.transitionTo('accounts.one.libraries.one.instruments.one.audios.one.events');
    }
  },

  actions: {

    createEvent(model) {
      model.save().then(() => {
        Ember.get(this, 'display').success('Created "' + model.get('inflection') + '" event in ' + model.get('note') + '.');
        this.transitionTo('accounts.one.libraries.one.instruments.one.audios.one.events');
      }).catch((error) => {
        Ember.get(this, 'display').error(error);
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
    }

  }
});