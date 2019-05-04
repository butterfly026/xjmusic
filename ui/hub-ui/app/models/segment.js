//  Copyright (c) 2018, XJ Music Inc. (https://xj.io) All Rights Reserved.
import DS from 'ember-data';
import {computed} from '@ember/object';

const ROW_HEIGHT_PIXELS_PER_BEAT = 9;

export default DS.Model.extend({
  chain: DS.belongsTo({}),
  offset: DS.attr('number'),
  state: DS.attr('string'),
  beginAt: DS.attr('string'),
  endAt: DS.attr('string'),
  total: DS.attr('number'),
  density: DS.attr('number'),
  key: DS.attr('string'),
  tempo: DS.attr('number'),
  waveformKey: DS.attr('string'),

  messages: DS.hasMany('segment-message'),
  memes: DS.hasMany('segment-meme'),
  choices: DS.hasMany('choice'),
  chords: DS.hasMany('segment-chord'),

  title: computed('offset', function () {
    return `Segment@${this.offset}`;
  }),

  rowHeight: computed('total', function () {
    let pixels = this.total * ROW_HEIGHT_PIXELS_PER_BEAT;
    return `${pixels}px`;
  }),

});

