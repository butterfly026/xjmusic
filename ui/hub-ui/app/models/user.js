// Copyright (c) 2017, Outright Mental Inc. (https://w.outright.io) All Rights Reserved.
import DS from 'ember-data';

export default DS.Model.extend({
  name: DS.attr('string'),
  avatarUrl: DS.attr('string'),
  email: DS.attr('string'),
  roles: DS.attr('string')
});