// Copyright (c) 2017, Outright Mental Inc. (https://w.outright.io) All Rights Reserved.
import { hash } from 'rsvp';
import Route from '@ember/routing/route';

export default Route.extend({

  /**
   * Route Model
   * @returns {*}
   */
  model: function () {
    let chain = this.modelFor('accounts.one.chains.one');
    let link = this.modelFor('accounts.one.chains.one.links.one');
    return hash({
      chain: chain,
      link: link,
    });
  },

});