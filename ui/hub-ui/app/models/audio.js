// Copyright (c) 2017, Outright Mental Inc. (https://w.outright.io) All Rights Reserved.
import DS from 'ember-data';

export default DS.Model.extend({
  instrument: DS.belongsTo({}),
  name: DS.attr('string'),
  waveformKey: DS.attr('string'),
  start: DS.attr('number'),
  length: DS.attr('number'),
  tempo: DS.attr('number'),
  pitch: DS.attr('number'),
});