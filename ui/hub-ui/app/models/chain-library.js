// Copyright (c) 2017, Outright Mental Inc. (https://w.outright.io) All Rights Reserved.
import DS from 'ember-data';

export default DS.Model.extend({
  chain: DS.belongsTo({}),
  library: DS.belongsTo({})
});