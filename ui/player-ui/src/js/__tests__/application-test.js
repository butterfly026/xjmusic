// Copyright (c) 2018, XJ Music Inc. (https://xj.io) All Rights Reserved.

import {Application} from "../application";

jest.mock('player');

it('can decode option key-values from URL', () => {
  expect(new Application("http://localhost/#one=1&two=2&word=def").options).toEqual({one: 1, two: 2, word: "def"});
});

