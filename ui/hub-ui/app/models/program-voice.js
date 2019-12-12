// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.
import Model, {attr, belongsTo, hasMany} from '@ember-data/model';

export default Model.extend({
  type: attr('string'),
  name: attr('string'),
  segmentChoiceArrangements: hasMany('segment-choice-arrangement'),
  sequencePatterns: hasMany('program-sequence-pattern'),
  program: belongsTo('program'),
  tracks: hasMany('program-voice-track'),
});