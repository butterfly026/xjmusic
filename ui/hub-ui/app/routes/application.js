// Copyright (c) 2017, Outright Mental Inc. (https://w.outright.io) All Rights Reserved.
import Route from '@ember/routing/route';

export default Route.extend({
  init() {
    this.deleteStaticContent();
  },

  /**
   [#155] Create actual static content on default index.html that gets deleted by Ember init, in order to build search engine value at https://hub.xj.io
   */
  deleteStaticContent() {
    let element = document.getElementById("static-content");
    element.parentNode.removeChild(element);
  },

  actions: {
    sessionChanged: function () {
      this.refresh();
    },
    goBack: function() {
      console.log("GO BACK!!!");
      history.back();
    }
  }
});