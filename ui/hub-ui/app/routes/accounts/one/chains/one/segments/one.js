//  Copyright (c) 2018, XJ Music Inc. (https://xj.io) All Rights Reserved.
import { get, set } from '@ember/object';

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
    return this.store.findRecord('segment', params.segment_id)
      .catch((error) => {
        get(self, 'display').error(error);
        self.transitionTo('accounts.one.chains.one.segments');
      });
  },

  /**
   * Route Breadcrumb
   * @param model
   */
  afterModel(model) {
    set(this, 'breadCrumb', {
      title: model.getTitle()
    });
  }

});