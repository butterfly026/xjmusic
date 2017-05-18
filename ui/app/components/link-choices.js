// Copyright (c) 2017, Outright Mental Inc. (https://w.outright.io) All Rights Reserved.
import Ember from "ember";

/**
 * Displays Link Choices
 */
const LinkChoicesComponent = Ember.Component.extend({

  // Inject: flash message service
  display: Ember.inject.service(),

  /**
   * Component Actions
   */
  actions: {

  },

});

/**
 * Usage (e.g, in Handlebars, where link model is "myLinkModel"):
 *
 *   {{link-choices myLinkModel}}
 */
LinkChoicesComponent.reopenClass({
  positionalParams: ['model']
});

export default LinkChoicesComponent;
