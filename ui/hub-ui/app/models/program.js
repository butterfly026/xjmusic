// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.
import Model, {attr, belongsTo, hasMany} from '@ember-data/model';

export default Model.extend({
  density: attr('number'),
  key: attr('string'),
  name: attr('string'),
  tempo: attr('number'),
  type: attr('string'),
  state: attr('string'),

  user: belongsTo('user'),
  library: belongsTo('library'),
  sequencePatterns: hasMany('program-sequence-pattern'),
  sequencePatternEvents: hasMany('program-sequence-pattern-event'),
  memes: hasMany('program-meme'),
  sequences: hasMany('program-sequence'),
  sequenceBindings: hasMany('program-sequence-binding'),
  sequenceBindingMemes: hasMany('program-sequence-binding-meme'),
  sequenceChords: hasMany('program-sequence-chord'),
  voices: hasMany('program-voice'),
  choices: hasMany('segment-choice'),
});
