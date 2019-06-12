//  Copyright (c) 2018, XJ Music Inc. (https://xj.io) All Rights Reserved.

import Model, {attr, belongsTo} from '@ember-data/model';

export default Model.extend({
  chain: belongsTo({}),
  type: attr('string'),
  value: attr('string'),

  ready() {

  }
});
