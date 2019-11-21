//  Copyright (c) 2020, XJ Music Inc. (https://xj.io) All Rights Reserved.
import Model, {attr, belongsTo} from '@ember-data/model';

export default Model.extend({
  sequenceBinding: belongsTo({}),
  name: attr('string'),
});
