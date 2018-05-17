// Copyright (c) 2018, XJ Music Inc. (https://xj.io) All Rights Reserved.

import { moduleForComponent, test } from 'ember-qunit';
import hbs from 'htmlbars-inline-precompile';

moduleForComponent('chord-markov-observations', 'Integration | Component | chord markov observations', {
  integration: true
});

test('it renders', function(assert) {
  // Set any properties with this.set('myProperty', 'value');
  // Handle any actions with this.on('myAction', function(val) { ... });

  this.render(hbs`{{chord-markov-observations}}`);

  assert.equal(this.$().text().trim(), '');

  // Template block usage:
  this.render(hbs`
    {{#chord-markov-observations}}
      template block text
    {{/chord-markov-observations}}
  `);

  assert.equal(this.$().text().trim(), 'template block text');
});
