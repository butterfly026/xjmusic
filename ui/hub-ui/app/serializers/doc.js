// Copyright (c) 2017, Outright Mental Inc. (https://w.outright.io) All Rights Reserved.
import DS from 'ember-data';

export default DS.RESTSerializer.extend({
  keyForRelationship: function(key /*, relationship, method*/) {
    return key + 'Id';
  }
});