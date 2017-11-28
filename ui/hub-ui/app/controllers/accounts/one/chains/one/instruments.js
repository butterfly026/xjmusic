// Copyright (c) 2017, Outright Mental Inc. (https://w.outright.io) All Rights Reserved.
import { inject as service } from '@ember/service';

import Controller from '@ember/controller';

export default Controller.extend({

  display: service(),

  actions: {

    /**
     * Ember power-select uses this as onChange to set value
     * @param instrument
     * @returns {*}
     */
    setInstrumentToAdd(instrument){
      this.set('model.instrumentToAdd', instrument);
      return instrument;
    },

  }

});