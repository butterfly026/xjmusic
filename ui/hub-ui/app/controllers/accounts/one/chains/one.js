//  Copyright (c) 2018, XJ Music Inc. (https://xj.io) All Rights Reserved.
import {inject as service} from '@ember/service';

import Controller from '@ember/controller';

export default Controller.extend({

  /**
   Inject: chain-segment player service, implemented directly by the template in order to
   [#279] Now-playing Chain or Segment appears highlighted
   */
  player: service(),

  /**
   * Actions
   */
  actions: {
    chainsUpdated() {
      this.send("sessionChanged");
    }
  }

});