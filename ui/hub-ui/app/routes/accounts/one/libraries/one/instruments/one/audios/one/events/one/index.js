// Copyright (c) 2017, Outright Mental Inc. (https://w.outright.io) All Rights Reserved.
import { hash } from 'rsvp';
import Route from '@ember/routing/route';

export default Route.extend({

  /**
   * Route Model
   * @returns {*}
   */
  model: function() {
    let audio = this.modelFor('accounts.one.libraries.one.instruments.one.audios.one');
    let event = this.modelFor('accounts.one.libraries.one.instruments.one.audios.one.events.one');
    return hash({
      audio: audio,
      event: event,
    });
  },

});