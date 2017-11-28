import { get } from '@ember/object';
import { inject as service } from '@ember/service';
import Controller from '@ember/controller';

export default Controller.extend({
  config: service(),

  actions: {

    selectVoiceType(type) {
      get(this, 'model').set('type', type);
    },

  }

});