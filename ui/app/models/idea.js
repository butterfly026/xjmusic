import DS from 'ember-data';

export default DS.Model.extend({
  density: DS.attr('number'),
  key: DS.attr('string'),
  library: DS.belongsTo({}),
  name: DS.attr('string'),
  tempo: DS.attr('number'),
  type: DS.attr('string'),
  user: DS.belongsTo({}),
});