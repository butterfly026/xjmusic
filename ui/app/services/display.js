import Ember from 'ember';

export default Ember.Service.extend({

  flashMessages: Ember.inject.service(),

  error(error) {
    if ('errors' in error && error.errors.length >= 1) {
      Ember.get(this, 'flashMessages').danger('Error: ' + error.errors[0].detail);
    } else if ('message' in error) {
      Ember.get(this, 'flashMessages').danger('Error: ' + error.message);
    } else {
      Ember.get(this, 'flashMessages').danger('Error: ' + error.toString());
    }
  },

  success(message) {
    Ember.get(this, 'flashMessages').success(message);
  }

});