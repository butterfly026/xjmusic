//  Copyright (c) 2018, XJ Music Inc. (https://xj.io) All Rights Reserved.
import DS from 'ember-data';

export default DS.Model.extend({
  sequence: DS.belongsTo({}),
  name: DS.attr('string'),
});