// Copyright (c) 2017, Outright Mental Inc. (http://outright.io) All Rights Reserved.
import Ember from "ember";

export default Ember.Route.extend({

  display: Ember.inject.service(),

  model: function() {
    let library = this.modelFor('accounts.one.libraries.one');
    let instruments = this.store.query('instrument', { library: library.get('id') }).catch((error)=>{
      Ember.get(this, 'display').error(error);
      this.transitionTo('');
    });
    return Ember.RSVP.hash({
      library: library,
      instruments: instruments,
    });
  },

  actions: {

    editInstrument(instrument) {
      this.transitionTo('accounts.one.libraries.one.instruments.one', instrument);
    },

  }
});
