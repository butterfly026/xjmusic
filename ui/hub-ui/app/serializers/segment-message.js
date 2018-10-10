//  Copyright (c) 2018, XJ Music Inc. (https://xj.io) All Rights Reserved.

import DS from 'ember-data';

export default DS.RESTSerializer.extend({
  keyForRelationship: function(key /*, relationship, method*/) {
    return key + 'Id';
  }
});