import { moduleFor, test } from 'ember-qunit';

moduleFor('route:platform/works', 'Unit | Route | platform/works', {
  // Specify the other units that are required for this test.
  needs: ['service:auth','service:config','service:display']
});

test('it exists', function(assert) {
  let route = this.subject();
  assert.ok(route);
});