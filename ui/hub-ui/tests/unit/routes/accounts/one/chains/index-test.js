//  Copyright (c) 2018, XJ Music Inc. (https://xj.io) All Rights Reserved.

import { expect } from 'chai';
import { describe, it } from 'mocha';
import { setupTest } from 'ember-mocha';

describe('Unit | Route | accounts/one/chains/index', function() {
  setupTest('route:accounts/one/chains/index', {
    // Specify the other units that are required for this test.
    needs: ['service:config','service:display','service:auth','service:player']
  });

  it('exists', function() {
    let route = this.subject();
    expect(route).to.be.ok;
  });
});