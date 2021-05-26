/*
 * Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.
 */
import { expect } from 'chai';
import { describe, it } from 'mocha';
import { setupTest } from 'ember-mocha';

describe('Unit | Controller | accounts/one/chains/one/sequences', function() {
  setupTest('controller:accounts/one/chains/one/sequences', {
    needs: ['service:config','service:display']
  });

  // Replace this with your real tests.
  it('exists', function() {
    let controller = this.subject();
    expect(controller).to.be.ok;
  });
});