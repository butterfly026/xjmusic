// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.

package org.xiph.libvorbis.books.coupled.resbook_44;

import org.xiph.libvorbis.encode_aux_threshmatch;
import org.xiph.libvorbis.static_bookblock;
import org.xiph.libvorbis.static_codebook;

class resbook_44s_9 {

  static int[] _vq_quantlist__44c9_s_p1_0 = {
    1,
    0,
    2,
  };

  static int[] _vq_lengthlist__44c9_s_p1_0 = {
    1, 5, 5, 0, 5, 5, 0, 5, 5, 6, 8, 8, 0, 9, 8, 0,
    9, 8, 6, 8, 8, 0, 8, 9, 0, 8, 9, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 5, 8, 8, 0, 7, 7, 0, 8, 8, 5, 8, 8,
    0, 7, 8, 0, 8, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5,
    9, 8, 0, 8, 8, 0, 7, 7, 5, 8, 9, 0, 8, 8, 0, 7,
    7,
  };

  static float[] _vq_quantthresh__44c9_s_p1_0 = {
    -0.5f, 0.5f,
  };

  static int[] _vq_quantmap__44c9_s_p1_0 = {
    1, 0, 2,
  };

  static encode_aux_threshmatch _vq_auxt__44c9_s_p1_0 = new encode_aux_threshmatch(
    _vq_quantthresh__44c9_s_p1_0,
    _vq_quantmap__44c9_s_p1_0,
    3,
    3
  );

  static static_codebook _44c9_s_p1_0 = new static_codebook(
    4, 81,
    _vq_lengthlist__44c9_s_p1_0,
    1, -535822336, 1611661312, 2, 0,
    _vq_quantlist__44c9_s_p1_0,
    null,
    _vq_auxt__44c9_s_p1_0,
    null,
    0
  );

  static int[] _vq_quantlist__44c9_s_p2_0 = {
    2,
    1,
    3,
    0,
    4,
  };

  static int[] _vq_lengthlist__44c9_s_p2_0 = {
    3, 5, 5, 8, 8, 0, 5, 5, 8, 8, 0, 5, 5, 8, 8, 0,
    7, 7, 9, 9, 0, 0, 0, 9, 9, 6, 7, 7, 9, 8, 0, 8,
    8, 9, 9, 0, 8, 7, 9, 9, 0, 9, 10, 10, 10, 0, 0, 0,
    11, 10, 6, 7, 7, 8, 9, 0, 8, 8, 9, 9, 0, 7, 8, 9,
    9, 0, 10, 9, 11, 10, 0, 0, 0, 10, 10, 8, 9, 8, 10, 10,
    0, 10, 10, 12, 11, 0, 10, 10, 11, 11, 0, 12, 13, 13, 13, 0,
    0, 0, 13, 12, 8, 8, 9, 10, 10, 0, 10, 10, 11, 12, 0, 10,
    10, 11, 11, 0, 13, 12, 13, 13, 0, 0, 0, 13, 13, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 6, 8, 7, 10, 10, 0, 7, 7, 10, 9,
    0, 7, 7, 10, 10, 0, 9, 9, 10, 10, 0, 0, 0, 10, 10, 6,
    7, 8, 10, 10, 0, 7, 7, 9, 10, 0, 7, 7, 10, 10, 0, 9,
    9, 10, 10, 0, 0, 0, 10, 10, 8, 9, 9, 11, 11, 0, 10, 10,
    11, 11, 0, 10, 10, 11, 11, 0, 12, 12, 12, 12, 0, 0, 0, 12,
    12, 8, 9, 10, 11, 11, 0, 9, 10, 11, 11, 0, 10, 10, 11, 11,
    0, 12, 12, 12, 12, 0, 0, 0, 12, 12, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 5, 8, 7, 10, 10, 0, 7, 7, 10, 10, 0, 7, 7,
    10, 9, 0, 9, 9, 10, 10, 0, 0, 0, 10, 10, 6, 7, 8, 10,
    10, 0, 7, 7, 10, 10, 0, 7, 7, 9, 10, 0, 9, 9, 10, 10,
    0, 0, 0, 10, 10, 8, 10, 9, 12, 11, 0, 10, 10, 12, 11, 0,
    10, 9, 11, 11, 0, 11, 12, 12, 12, 0, 0, 0, 12, 12, 8, 9,
    10, 11, 12, 0, 10, 10, 11, 11, 0, 9, 10, 11, 11, 0, 12, 11,
    12, 12, 0, 0, 0, 12, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    7, 10, 9, 12, 12, 0, 9, 9, 12, 11, 0, 9, 9, 11, 11, 0,
    10, 10, 12, 11, 0, 0, 0, 11, 12, 7, 9, 10, 12, 12, 0, 9,
    9, 11, 12, 0, 9, 9, 11, 11, 0, 10, 10, 11, 12, 0, 0, 0,
    11, 11, 9, 11, 10, 13, 12, 0, 10, 10, 12, 12, 0, 10, 10, 12,
    12, 0, 11, 11, 12, 12, 0, 0, 0, 13, 12, 9, 10, 11, 12, 13,
    0, 10, 10, 12, 12, 0, 10, 10, 12, 12, 0, 11, 12, 12, 12, 0,
    0, 0, 12, 13, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 9,
    11, 10, 13, 13, 0, 10, 10, 12, 12, 0, 10, 10, 12, 12, 0, 11,
    12, 12, 12, 0, 0, 0, 12, 12, 9, 10, 11, 13, 13, 0, 10, 10,
    12, 12, 0, 10, 10, 12, 12, 0, 12, 11, 13, 12, 0, 0, 0, 12,
    12,
  };

  static float[] _vq_quantthresh__44c9_s_p2_0 = {
    -1.5f, -0.5f, 0.5f, 1.5f,
  };

  static int[] _vq_quantmap__44c9_s_p2_0 = {
    3, 1, 0, 2, 4,
  };

  static encode_aux_threshmatch _vq_auxt__44c9_s_p2_0 = new encode_aux_threshmatch(
    _vq_quantthresh__44c9_s_p2_0,
    _vq_quantmap__44c9_s_p2_0,
    5,
    5
  );

  static static_codebook _44c9_s_p2_0 = new static_codebook(
    4, 625,
    _vq_lengthlist__44c9_s_p2_0,
    1, -533725184, 1611661312, 3, 0,
    _vq_quantlist__44c9_s_p2_0,
    null,
    _vq_auxt__44c9_s_p2_0,
    null,
    0
  );

  static int[] _vq_quantlist__44c9_s_p3_0 = {
    4,
    3,
    5,
    2,
    6,
    1,
    7,
    0,
    8,
  };

  static int[] _vq_lengthlist__44c9_s_p3_0 = {
    3, 4, 4, 5, 5, 6, 6, 8, 8, 0, 4, 4, 5, 5, 6, 7,
    8, 8, 0, 4, 4, 5, 5, 7, 7, 8, 8, 0, 5, 5, 6, 6,
    7, 7, 9, 9, 0, 0, 0, 6, 6, 7, 7, 9, 9, 0, 0, 0,
    7, 7, 8, 8, 9, 9, 0, 0, 0, 7, 7, 8, 8, 9, 9, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0,
  };

  static float[] _vq_quantthresh__44c9_s_p3_0 = {
    -3.5f, -2.5f, -1.5f, -0.5f, 0.5f, 1.5f, 2.5f, 3.5f,
  };

  static int[] _vq_quantmap__44c9_s_p3_0 = {
    7, 5, 3, 1, 0, 2, 4, 6,
    8,
  };

  static encode_aux_threshmatch _vq_auxt__44c9_s_p3_0 = new encode_aux_threshmatch(
    _vq_quantthresh__44c9_s_p3_0,
    _vq_quantmap__44c9_s_p3_0,
    9,
    9
  );

  static static_codebook _44c9_s_p3_0 = new static_codebook(
    2, 81,
    _vq_lengthlist__44c9_s_p3_0,
    1, -531628032, 1611661312, 4, 0,
    _vq_quantlist__44c9_s_p3_0,
    null,
    _vq_auxt__44c9_s_p3_0,
    null,
    0
  );

  static int[] _vq_quantlist__44c9_s_p4_0 = {
    8,
    7,
    9,
    6,
    10,
    5,
    11,
    4,
    12,
    3,
    13,
    2,
    14,
    1,
    15,
    0,
    16,
  };

  static int[] _vq_lengthlist__44c9_s_p4_0 = {
    3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10, 10,
    10, 0, 5, 4, 5, 5, 7, 7, 8, 8, 8, 8, 9, 9, 10, 10,
    11, 11, 0, 5, 5, 6, 6, 7, 7, 8, 8, 8, 8, 9, 9, 10,
    10, 11, 11, 0, 6, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10,
    11, 11, 11, 12, 0, 0, 0, 6, 6, 7, 7, 8, 8, 9, 9, 10,
    10, 11, 11, 12, 12, 0, 0, 0, 7, 7, 7, 7, 9, 9, 9, 9,
    10, 10, 11, 11, 12, 12, 0, 0, 0, 7, 7, 7, 8, 9, 9, 9,
    9, 10, 10, 11, 11, 12, 12, 0, 0, 0, 7, 7, 8, 8, 9, 9,
    10, 10, 11, 11, 12, 12, 13, 13, 0, 0, 0, 0, 0, 8, 8, 9,
    9, 10, 10, 11, 11, 12, 12, 12, 12, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0,
  };

  static float[] _vq_quantthresh__44c9_s_p4_0 = {
    -7.5f, -6.5f, -5.5f, -4.5f, -3.5f, -2.5f, -1.5f, -0.5f,
    0.5f, 1.5f, 2.5f, 3.5f, 4.5f, 5.5f, 6.5f, 7.5f,
  };

  static int[] _vq_quantmap__44c9_s_p4_0 = {
    15, 13, 11, 9, 7, 5, 3, 1,
    0, 2, 4, 6, 8, 10, 12, 14,
    16,
  };

  static encode_aux_threshmatch _vq_auxt__44c9_s_p4_0 = new encode_aux_threshmatch(
    _vq_quantthresh__44c9_s_p4_0,
    _vq_quantmap__44c9_s_p4_0,
    17,
    17
  );

  static static_codebook _44c9_s_p4_0 = new static_codebook(
    2, 289,
    _vq_lengthlist__44c9_s_p4_0,
    1, -529530880, 1611661312, 5, 0,
    _vq_quantlist__44c9_s_p4_0,
    null,
    _vq_auxt__44c9_s_p4_0,
    null,
    0
  );

  static int[] _vq_quantlist__44c9_s_p5_0 = {
    1,
    0,
    2,
  };

  static int[] _vq_lengthlist__44c9_s_p5_0 = {
    1, 4, 4, 5, 7, 7, 6, 7, 7, 4, 7, 6, 9, 10, 10, 10,
    10, 9, 4, 6, 7, 9, 10, 10, 10, 9, 10, 5, 9, 9, 9, 11,
    11, 10, 11, 11, 7, 10, 9, 11, 12, 11, 12, 12, 12, 7, 9, 10,
    11, 11, 12, 12, 12, 12, 6, 10, 10, 10, 12, 12, 10, 12, 11, 7,
    10, 10, 11, 12, 12, 11, 12, 12, 7, 10, 10, 11, 12, 12, 12, 12,
    12,
  };

  static float[] _vq_quantthresh__44c9_s_p5_0 = {
    -5.5f, 5.5f,
  };

  static int[] _vq_quantmap__44c9_s_p5_0 = {
    1, 0, 2,
  };

  static encode_aux_threshmatch _vq_auxt__44c9_s_p5_0 = new encode_aux_threshmatch(
    _vq_quantthresh__44c9_s_p5_0,
    _vq_quantmap__44c9_s_p5_0,
    3,
    3
  );

  static static_codebook _44c9_s_p5_0 = new static_codebook(
    4, 81,
    _vq_lengthlist__44c9_s_p5_0,
    1, -529137664, 1618345984, 2, 0,
    _vq_quantlist__44c9_s_p5_0,
    null,
    _vq_auxt__44c9_s_p5_0,
    null,
    0
  );

  static int[] _vq_quantlist__44c9_s_p5_1 = {
    5,
    4,
    6,
    3,
    7,
    2,
    8,
    1,
    9,
    0,
    10,
  };

  static int[] _vq_lengthlist__44c9_s_p5_1 = {
    4, 5, 5, 6, 6, 7, 7, 7, 7, 7, 7, 11, 5, 5, 6, 6,
    7, 7, 7, 7, 8, 8, 11, 5, 5, 6, 6, 7, 7, 7, 7, 8,
    8, 11, 5, 5, 6, 6, 7, 7, 8, 8, 8, 8, 11, 11, 11, 6,
    6, 7, 7, 7, 8, 8, 8, 11, 11, 11, 6, 6, 7, 7, 7, 8,
    8, 8, 11, 11, 11, 6, 6, 7, 7, 7, 7, 8, 8, 11, 11, 11,
    7, 7, 7, 7, 7, 7, 8, 8, 11, 11, 11, 10, 10, 7, 7, 7,
    7, 8, 8, 11, 11, 11, 11, 11, 7, 7, 7, 7, 7, 7, 11, 11,
    11, 11, 11, 7, 7, 7, 7, 7, 7,
  };

  static float[] _vq_quantthresh__44c9_s_p5_1 = {
    -4.5f, -3.5f, -2.5f, -1.5f, -0.5f, 0.5f, 1.5f, 2.5f,
    3.5f, 4.5f,
  };

  static int[] _vq_quantmap__44c9_s_p5_1 = {
    9, 7, 5, 3, 1, 0, 2, 4,
    6, 8, 10,
  };

  static encode_aux_threshmatch _vq_auxt__44c9_s_p5_1 = new encode_aux_threshmatch(
    _vq_quantthresh__44c9_s_p5_1,
    _vq_quantmap__44c9_s_p5_1,
    11,
    11
  );

  static static_codebook _44c9_s_p5_1 = new static_codebook(
    2, 121,
    _vq_lengthlist__44c9_s_p5_1,
    1, -531365888, 1611661312, 4, 0,
    _vq_quantlist__44c9_s_p5_1,
    null,
    _vq_auxt__44c9_s_p5_1,
    null,
    0
  );

  static int[] _vq_quantlist__44c9_s_p6_0 = {
    6,
    5,
    7,
    4,
    8,
    3,
    9,
    2,
    10,
    1,
    11,
    0,
    12,
  };

  static int[] _vq_lengthlist__44c9_s_p6_0 = {
    2, 4, 4, 6, 6, 7, 7, 7, 7, 8, 8, 9, 9, 5, 4, 4,
    6, 6, 8, 8, 9, 9, 9, 9, 10, 10, 6, 4, 4, 6, 6, 8,
    8, 9, 9, 9, 9, 10, 10, 0, 6, 6, 7, 7, 8, 8, 9, 9,
    10, 10, 11, 11, 0, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10, 11,
    11, 0, 10, 10, 8, 8, 9, 9, 10, 10, 11, 11, 12, 12, 0, 11,
    11, 8, 8, 9, 9, 10, 10, 11, 11, 12, 12, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
    0, 0, 0, 0, 0, 0, 0, 0, 0,
  };

  static float[] _vq_quantthresh__44c9_s_p6_0 = {
    -27.5f, -22.5f, -17.5f, -12.5f, -7.5f, -2.5f, 2.5f, 7.5f,
    12.5f, 17.5f, 22.5f, 27.5f,
  };

  static int[] _vq_quantmap__44c9_s_p6_0 = {
    11, 9, 7, 5, 3, 1, 0, 2,
    4, 6, 8, 10, 12,
  };

  static encode_aux_threshmatch _vq_auxt__44c9_s_p6_0 = new encode_aux_threshmatch(
    _vq_quantthresh__44c9_s_p6_0,
    _vq_quantmap__44c9_s_p6_0,
    13,
    13
  );

  static static_codebook _44c9_s_p6_0 = new static_codebook(
    2, 169,
    _vq_lengthlist__44c9_s_p6_0,
    1, -526516224, 1616117760, 4, 0,
    _vq_quantlist__44c9_s_p6_0,
    null,
    _vq_auxt__44c9_s_p6_0,
    null,
    0
  );

  static int[] _vq_quantlist__44c9_s_p6_1 = {
    2,
    1,
    3,
    0,
    4,
  };

  static int[] _vq_lengthlist__44c9_s_p6_1 = {
    4, 4, 4, 5, 5, 5, 4, 4, 5, 5, 5, 4, 4, 5, 5, 5,
    5, 5, 5, 5, 5, 5, 5, 5, 5,
  };

  static float[] _vq_quantthresh__44c9_s_p6_1 = {
    -1.5f, -0.5f, 0.5f, 1.5f,
  };

  static int[] _vq_quantmap__44c9_s_p6_1 = {
    3, 1, 0, 2, 4,
  };

  static encode_aux_threshmatch _vq_auxt__44c9_s_p6_1 = new encode_aux_threshmatch(
    _vq_quantthresh__44c9_s_p6_1,
    _vq_quantmap__44c9_s_p6_1,
    5,
    5
  );

  static static_codebook _44c9_s_p6_1 = new static_codebook(
    2, 25,
    _vq_lengthlist__44c9_s_p6_1,
    1, -533725184, 1611661312, 3, 0,
    _vq_quantlist__44c9_s_p6_1,
    null,
    _vq_auxt__44c9_s_p6_1,
    null,
    0
  );

  static int[] _vq_quantlist__44c9_s_p7_0 = {
    6,
    5,
    7,
    4,
    8,
    3,
    9,
    2,
    10,
    1,
    11,
    0,
    12,
  };

  static int[] _vq_lengthlist__44c9_s_p7_0 = {
    2, 4, 4, 6, 6, 7, 7, 8, 8, 10, 10, 11, 11, 6, 4, 4,
    6, 6, 8, 8, 9, 9, 10, 10, 12, 12, 6, 4, 5, 6, 6, 8,
    8, 9, 9, 10, 10, 12, 12, 20, 6, 6, 6, 6, 8, 8, 9, 10,
    11, 11, 12, 12, 20, 6, 6, 6, 6, 8, 8, 10, 10, 11, 11, 12,
    12, 20, 10, 10, 7, 7, 9, 9, 10, 10, 11, 11, 12, 12, 20, 11,
    11, 7, 7, 9, 9, 10, 10, 11, 11, 12, 12, 20, 20, 20, 9, 9,
    9, 9, 11, 11, 12, 12, 13, 13, 20, 20, 20, 9, 9, 9, 9, 11,
    11, 12, 12, 13, 13, 20, 20, 20, 13, 13, 10, 10, 11, 11, 12, 13,
    13, 13, 20, 20, 20, 13, 13, 10, 10, 11, 11, 12, 13, 13, 13, 20,
    20, 20, 20, 19, 12, 12, 12, 12, 13, 13, 14, 15, 19, 19, 19, 19,
    19, 12, 12, 12, 12, 13, 13, 14, 14,
  };

  static float[] _vq_quantthresh__44c9_s_p7_0 = {
    -60.5f, -49.5f, -38.5f, -27.5f, -16.5f, -5.5f, 5.5f, 16.5f,
    27.5f, 38.5f, 49.5f, 60.5f,
  };

  static int[] _vq_quantmap__44c9_s_p7_0 = {
    11, 9, 7, 5, 3, 1, 0, 2,
    4, 6, 8, 10, 12,
  };

  static encode_aux_threshmatch _vq_auxt__44c9_s_p7_0 = new encode_aux_threshmatch(
    _vq_quantthresh__44c9_s_p7_0,
    _vq_quantmap__44c9_s_p7_0,
    13,
    13
  );

  static static_codebook _44c9_s_p7_0 = new static_codebook(
    2, 169,
    _vq_lengthlist__44c9_s_p7_0,
    1, -523206656, 1618345984, 4, 0,
    _vq_quantlist__44c9_s_p7_0,
    null,
    _vq_auxt__44c9_s_p7_0,
    null,
    0
  );

  static int[] _vq_quantlist__44c9_s_p7_1 = {
    5,
    4,
    6,
    3,
    7,
    2,
    8,
    1,
    9,
    0,
    10,
  };

  static int[] _vq_lengthlist__44c9_s_p7_1 = {
    5, 6, 6, 6, 6, 7, 7, 7, 7, 7, 7, 7, 6, 6, 6, 6,
    7, 7, 7, 7, 7, 7, 7, 6, 6, 6, 6, 7, 7, 7, 7, 7,
    7, 8, 6, 6, 6, 6, 7, 7, 7, 7, 7, 7, 8, 8, 8, 6,
    6, 7, 7, 7, 7, 7, 7, 8, 8, 8, 7, 7, 7, 7, 7, 7,
    7, 7, 8, 8, 8, 7, 7, 7, 7, 7, 7, 7, 7, 8, 8, 8,
    7, 7, 7, 7, 7, 7, 7, 7, 8, 8, 8, 8, 8, 7, 7, 7,
    7, 7, 7, 8, 8, 8, 8, 8, 7, 7, 7, 7, 7, 7, 8, 8,
    8, 8, 8, 7, 7, 7, 7, 7, 7,
  };

  static float[] _vq_quantthresh__44c9_s_p7_1 = {
    -4.5f, -3.5f, -2.5f, -1.5f, -0.5f, 0.5f, 1.5f, 2.5f,
    3.5f, 4.5f,
  };

  static int[] _vq_quantmap__44c9_s_p7_1 = {
    9, 7, 5, 3, 1, 0, 2, 4,
    6, 8, 10,
  };

  static encode_aux_threshmatch _vq_auxt__44c9_s_p7_1 = new encode_aux_threshmatch(
    _vq_quantthresh__44c9_s_p7_1,
    _vq_quantmap__44c9_s_p7_1,
    11,
    11
  );

  static static_codebook _44c9_s_p7_1 = new static_codebook(
    2, 121,
    _vq_lengthlist__44c9_s_p7_1,
    1, -531365888, 1611661312, 4, 0,
    _vq_quantlist__44c9_s_p7_1,
    null,
    _vq_auxt__44c9_s_p7_1,
    null,
    0
  );

  static int[] _vq_quantlist__44c9_s_p8_0 = {
    7,
    6,
    8,
    5,
    9,
    4,
    10,
    3,
    11,
    2,
    12,
    1,
    13,
    0,
    14,
  };

  static int[] _vq_lengthlist__44c9_s_p8_0 = {
    1, 4, 4, 7, 6, 8, 8, 8, 8, 9, 9, 10, 10, 11, 10, 6,
    5, 5, 7, 7, 9, 9, 8, 9, 10, 10, 11, 11, 12, 12, 6, 5,
    5, 7, 7, 9, 9, 9, 9, 10, 10, 11, 11, 12, 12, 21, 7, 8,
    8, 8, 9, 9, 9, 9, 10, 10, 11, 11, 12, 12, 21, 8, 8, 8,
    8, 9, 9, 9, 9, 10, 10, 11, 11, 12, 12, 21, 11, 12, 9, 9,
    10, 10, 10, 10, 10, 11, 11, 12, 12, 12, 21, 12, 12, 9, 8, 10,
    10, 10, 10, 11, 11, 12, 12, 13, 13, 21, 21, 21, 9, 9, 9, 9,
    11, 11, 11, 11, 12, 12, 12, 13, 21, 20, 20, 9, 9, 9, 9, 10,
    11, 11, 11, 12, 12, 13, 13, 20, 20, 20, 13, 13, 10, 10, 11, 11,
    12, 12, 13, 13, 13, 13, 20, 20, 20, 13, 13, 10, 10, 11, 11, 12,
    12, 13, 13, 13, 13, 20, 20, 20, 20, 20, 12, 12, 12, 12, 12, 12,
    13, 13, 14, 14, 20, 20, 20, 20, 20, 12, 12, 12, 11, 13, 12, 13,
    13, 14, 14, 20, 20, 20, 20, 20, 15, 16, 13, 12, 13, 13, 14, 13,
    14, 14, 20, 20, 20, 20, 20, 16, 15, 12, 12, 13, 12, 14, 13, 14,
    14,
  };

  static float[] _vq_quantthresh__44c9_s_p8_0 = {
    -136.5f, -115.5f, -94.5f, -73.5f, -52.5f, -31.5f, -10.5f, 10.5f,
    31.5f, 52.5f, 73.5f, 94.5f, 115.5f, 136.5f,
  };

  static int[] _vq_quantmap__44c9_s_p8_0 = {
    13, 11, 9, 7, 5, 3, 1, 0,
    2, 4, 6, 8, 10, 12, 14,
  };

  static encode_aux_threshmatch _vq_auxt__44c9_s_p8_0 = new encode_aux_threshmatch(
    _vq_quantthresh__44c9_s_p8_0,
    _vq_quantmap__44c9_s_p8_0,
    15,
    15
  );

  static static_codebook _44c9_s_p8_0 = new static_codebook(
    2, 225,
    _vq_lengthlist__44c9_s_p8_0,
    1, -520986624, 1620377600, 4, 0,
    _vq_quantlist__44c9_s_p8_0,
    null,
    _vq_auxt__44c9_s_p8_0,
    null,
    0
  );

  static int[] _vq_quantlist__44c9_s_p8_1 = {
    10,
    9,
    11,
    8,
    12,
    7,
    13,
    6,
    14,
    5,
    15,
    4,
    16,
    3,
    17,
    2,
    18,
    1,
    19,
    0,
    20,
  };

  static int[] _vq_lengthlist__44c9_s_p8_1 = {
    4, 6, 6, 7, 7, 7, 7, 8, 8, 8, 8, 8, 8, 8, 8, 8,
    8, 8, 8, 8, 8, 10, 6, 6, 7, 7, 8, 8, 8, 8, 9, 9,
    9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 10, 6, 6, 7, 7, 8,
    8, 8, 8, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 10,
    7, 7, 8, 8, 8, 8, 8, 9, 9, 9, 9, 9, 9, 9, 9, 9,
    9, 9, 9, 9, 10, 10, 10, 8, 8, 8, 8, 9, 9, 9, 9, 9,
    9, 9, 9, 9, 9, 9, 9, 9, 9, 10, 10, 10, 8, 8, 8, 8,
    9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 10, 10,
    10, 8, 8, 8, 8, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9,
    9, 9, 9, 10, 10, 10, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9,
    9, 9, 9, 9, 9, 9, 9, 9, 10, 10, 10, 10, 10, 9, 9, 9,
    9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 10, 10, 10,
    10, 10, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9, 9,
    9, 9, 10, 10, 10, 10, 10, 9, 9, 9, 9, 9, 9, 9, 9, 9,
    9, 9, 9, 9, 9, 9, 9, 10, 10, 10, 10, 10, 9, 9, 9, 9,
    9, 9, 9, 9, 9, 9, 9, 9, 10, 9, 9, 9, 10, 10, 10, 10,
    10, 10, 10, 9, 9, 9, 9, 9, 9, 10, 9, 9, 9, 9, 9, 9,
    9, 10, 10, 10, 10, 10, 10, 10, 9, 9, 9, 10, 10, 10, 10, 10,
    9, 9, 9, 9, 9, 9, 10, 10, 10, 10, 10, 10, 10, 9, 9, 10,
    9, 10, 9, 9, 9, 9, 9, 9, 9, 9, 10, 10, 10, 10, 10, 10,
    10, 10, 10, 10, 9, 9, 10, 10, 9, 9, 9, 9, 9, 9, 9, 9,
    10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 9, 9, 9,
    9, 9, 9, 9, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10,
    10, 10, 9, 9, 10, 9, 9, 9, 9, 9, 10, 10, 10, 10, 10, 10,
    10, 10, 10, 10, 10, 9, 9, 10, 10, 9, 9, 10, 9, 9, 9, 10,
    10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 9, 9, 10, 9, 9, 9,
    9, 9, 9, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 9,
    9, 9, 9, 10, 9, 9, 9, 9, 9,
  };

  static float[] _vq_quantthresh__44c9_s_p8_1 = {
    -9.5f, -8.5f, -7.5f, -6.5f, -5.5f, -4.5f, -3.5f, -2.5f,
    -1.5f, -0.5f, 0.5f, 1.5f, 2.5f, 3.5f, 4.5f, 5.5f,
    6.5f, 7.5f, 8.5f, 9.5f,
  };

  static int[] _vq_quantmap__44c9_s_p8_1 = {
    19, 17, 15, 13, 11, 9, 7, 5,
    3, 1, 0, 2, 4, 6, 8, 10,
    12, 14, 16, 18, 20,
  };

  static encode_aux_threshmatch _vq_auxt__44c9_s_p8_1 = new encode_aux_threshmatch(
    _vq_quantthresh__44c9_s_p8_1,
    _vq_quantmap__44c9_s_p8_1,
    21,
    21
  );

  static static_codebook _44c9_s_p8_1 = new static_codebook(
    2, 441,
    _vq_lengthlist__44c9_s_p8_1,
    1, -529268736, 1611661312, 5, 0,
    _vq_quantlist__44c9_s_p8_1,
    null,
    _vq_auxt__44c9_s_p8_1,
    null,
    0
  );

  static int[] _vq_quantlist__44c9_s_p9_0 = {
    9,
    8,
    10,
    7,
    11,
    6,
    12,
    5,
    13,
    4,
    14,
    3,
    15,
    2,
    16,
    1,
    17,
    0,
    18,
  };

  static int[] _vq_lengthlist__44c9_s_p9_0 = {
    1, 4, 3, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12,
    12, 12, 12, 4, 5, 6, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12,
    12, 12, 12, 12, 12, 12, 4, 6, 6, 12, 12, 12, 12, 12, 12, 12,
    12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 11, 12, 12, 12, 12,
    12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12,
    12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12,
    12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12,
    12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12,
    12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12,
    12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12,
    12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12,
    12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12,
    12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12,
    12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12,
    12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12,
    12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12,
    12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 11, 11, 11, 11, 11, 11,
    11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11,
    11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11,
    11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11,
    11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11,
    11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11,
    11, 11, 11, 11, 11, 11, 11, 11, 11,
  };

  static float[] _vq_quantthresh__44c9_s_p9_0 = {
    -7913.5f, -6982.5f, -6051.5f, -5120.5f, -4189.5f, -3258.5f, -2327.5f, -1396.5f,
    -465.5f, 465.5f, 1396.5f, 2327.5f, 3258.5f, 4189.5f, 5120.5f, 6051.5f,
    6982.5f, 7913.5f,
  };

  static int[] _vq_quantmap__44c9_s_p9_0 = {
    17, 15, 13, 11, 9, 7, 5, 3,
    1, 0, 2, 4, 6, 8, 10, 12,
    14, 16, 18,
  };

  static encode_aux_threshmatch _vq_auxt__44c9_s_p9_0 = new encode_aux_threshmatch(
    _vq_quantthresh__44c9_s_p9_0,
    _vq_quantmap__44c9_s_p9_0,
    19,
    19
  );

  static static_codebook _44c9_s_p9_0 = new static_codebook(
    2, 361,
    _vq_lengthlist__44c9_s_p9_0,
    1, -508535424, 1631393792, 5, 0,
    _vq_quantlist__44c9_s_p9_0,
    null,
    _vq_auxt__44c9_s_p9_0,
    null,
    0
  );

  static int[] _vq_quantlist__44c9_s_p9_1 = {
    9,
    8,
    10,
    7,
    11,
    6,
    12,
    5,
    13,
    4,
    14,
    3,
    15,
    2,
    16,
    1,
    17,
    0,
    18,
  };

  static int[] _vq_lengthlist__44c9_s_p9_1 = {
    1, 4, 4, 7, 7, 7, 7, 8, 7, 9, 8, 9, 9, 10, 10, 11,
    11, 11, 11, 6, 5, 5, 8, 8, 9, 9, 9, 8, 10, 9, 11, 10,
    12, 12, 13, 12, 13, 13, 5, 5, 5, 8, 8, 9, 9, 9, 9, 10,
    10, 11, 11, 12, 12, 13, 12, 13, 13, 17, 8, 8, 9, 9, 9, 9,
    9, 9, 10, 10, 12, 11, 13, 12, 13, 13, 13, 13, 18, 8, 8, 9,
    9, 9, 9, 9, 9, 11, 11, 12, 12, 13, 13, 13, 13, 13, 13, 17,
    13, 12, 9, 9, 10, 10, 10, 10, 11, 11, 12, 12, 12, 13, 13, 13,
    14, 14, 18, 13, 12, 9, 9, 10, 10, 10, 10, 11, 11, 12, 12, 13,
    13, 13, 14, 14, 14, 17, 18, 18, 10, 10, 10, 10, 11, 11, 11, 12,
    12, 12, 14, 13, 14, 13, 13, 14, 18, 18, 18, 10, 9, 10, 9, 11,
    11, 12, 12, 12, 12, 13, 13, 15, 14, 14, 14, 18, 18, 16, 13, 14,
    10, 11, 11, 11, 12, 13, 13, 13, 13, 14, 13, 13, 14, 14, 18, 18,
    18, 14, 12, 11, 9, 11, 10, 13, 12, 13, 13, 13, 14, 14, 14, 13,
    14, 18, 18, 17, 18, 18, 11, 12, 12, 12, 13, 13, 14, 13, 14, 14,
    13, 14, 14, 14, 18, 18, 18, 18, 17, 12, 10, 12, 9, 13, 11, 13,
    14, 14, 14, 14, 14, 15, 14, 18, 18, 17, 17, 18, 14, 15, 12, 13,
    13, 13, 14, 13, 14, 14, 15, 14, 15, 14, 18, 17, 18, 18, 18, 15,
    15, 12, 10, 14, 10, 14, 14, 13, 13, 14, 14, 14, 14, 18, 16, 18,
    18, 18, 18, 17, 14, 14, 13, 14, 14, 13, 13, 14, 14, 14, 15, 15,
    18, 18, 18, 18, 17, 17, 17, 14, 14, 14, 12, 14, 13, 14, 14, 15,
    14, 15, 14, 18, 18, 18, 18, 18, 18, 18, 17, 16, 13, 13, 13, 14,
    14, 14, 14, 15, 16, 15, 18, 18, 18, 18, 18, 18, 18, 17, 17, 13,
    13, 13, 13, 14, 13, 14, 15, 15, 15,
  };

  static float[] _vq_quantthresh__44c9_s_p9_1 = {
    -416.5f, -367.5f, -318.5f, -269.5f, -220.5f, -171.5f, -122.5f, -73.5f,
    -24.5f, 24.5f, 73.5f, 122.5f, 171.5f, 220.5f, 269.5f, 318.5f,
    367.5f, 416.5f,
  };

  static int[] _vq_quantmap__44c9_s_p9_1 = {
    17, 15, 13, 11, 9, 7, 5, 3,
    1, 0, 2, 4, 6, 8, 10, 12,
    14, 16, 18,
  };

  static encode_aux_threshmatch _vq_auxt__44c9_s_p9_1 = new encode_aux_threshmatch(
    _vq_quantthresh__44c9_s_p9_1,
    _vq_quantmap__44c9_s_p9_1,
    19,
    19
  );

  static static_codebook _44c9_s_p9_1 = new static_codebook(
    2, 361,
    _vq_lengthlist__44c9_s_p9_1,
    1, -518287360, 1622704128, 5, 0,
    _vq_quantlist__44c9_s_p9_1,
    null,
    _vq_auxt__44c9_s_p9_1,
    null,
    0
  );

  static int[] _vq_quantlist__44c9_s_p9_2 = {
    24,
    23,
    25,
    22,
    26,
    21,
    27,
    20,
    28,
    19,
    29,
    18,
    30,
    17,
    31,
    16,
    32,
    15,
    33,
    14,
    34,
    13,
    35,
    12,
    36,
    11,
    37,
    10,
    38,
    9,
    39,
    8,
    40,
    7,
    41,
    6,
    42,
    5,
    43,
    4,
    44,
    3,
    45,
    2,
    46,
    1,
    47,
    0,
    48,
  };

  static int[] _vq_lengthlist__44c9_s_p9_2 = {
    2, 4, 4, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6, 6, 6, 6,
    6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 7, 7, 7, 7, 7,
    7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7,
    7,
  };

  static float[] _vq_quantthresh__44c9_s_p9_2 = {
    -23.5f, -22.5f, -21.5f, -20.5f, -19.5f, -18.5f, -17.5f, -16.5f,
    -15.5f, -14.5f, -13.5f, -12.5f, -11.5f, -10.5f, -9.5f, -8.5f,
    -7.5f, -6.5f, -5.5f, -4.5f, -3.5f, -2.5f, -1.5f, -0.5f,
    0.5f, 1.5f, 2.5f, 3.5f, 4.5f, 5.5f, 6.5f, 7.5f,
    8.5f, 9.5f, 10.5f, 11.5f, 12.5f, 13.5f, 14.5f, 15.5f,
    16.5f, 17.5f, 18.5f, 19.5f, 20.5f, 21.5f, 22.5f, 23.5f,
  };

  static int[] _vq_quantmap__44c9_s_p9_2 = {
    47, 45, 43, 41, 39, 37, 35, 33,
    31, 29, 27, 25, 23, 21, 19, 17,
    15, 13, 11, 9, 7, 5, 3, 1,
    0, 2, 4, 6, 8, 10, 12, 14,
    16, 18, 20, 22, 24, 26, 28, 30,
    32, 34, 36, 38, 40, 42, 44, 46,
    48,
  };

  static encode_aux_threshmatch _vq_auxt__44c9_s_p9_2 = new encode_aux_threshmatch(
    _vq_quantthresh__44c9_s_p9_2,
    _vq_quantmap__44c9_s_p9_2,
    49,
    49
  );

  static static_codebook _44c9_s_p9_2 = new static_codebook(
    1, 49,
    _vq_lengthlist__44c9_s_p9_2,
    1, -526909440, 1611661312, 6, 0,
    _vq_quantlist__44c9_s_p9_2,
    null,
    _vq_auxt__44c9_s_p9_2,
    null,
    0
  );


  static int[] _huff_lengthlist__44c9_s_short = {
    5, 13, 18, 16, 17, 17, 19, 18, 19, 19, 5, 7, 10, 11, 12, 12,
    13, 16, 17, 18, 6, 6, 7, 7, 9, 9, 10, 14, 17, 19, 8, 7,
    6, 5, 6, 7, 9, 12, 19, 17, 8, 7, 7, 6, 5, 6, 8, 11,
    15, 19, 9, 8, 7, 6, 5, 5, 6, 8, 13, 15, 11, 10, 8, 8,
    7, 5, 4, 4, 10, 14, 12, 13, 11, 9, 7, 6, 4, 2, 6, 12,
    18, 16, 16, 13, 8, 7, 7, 5, 8, 13, 16, 17, 18, 15, 11, 9,
    9, 8, 10, 13,
  };

  static int[] _huff_lengthlist__44c9_s_long = {
    3, 8, 12, 14, 15, 15, 15, 13, 15, 15, 6, 5, 8, 10, 12, 12,
    13, 12, 14, 13, 10, 6, 5, 6, 8, 9, 11, 11, 13, 13, 13, 8,
    5, 4, 5, 6, 8, 10, 11, 13, 14, 10, 7, 5, 4, 5, 7, 9,
    11, 12, 13, 11, 8, 6, 5, 4, 5, 7, 9, 11, 12, 11, 10, 8,
    7, 5, 4, 5, 9, 10, 13, 13, 11, 10, 8, 6, 5, 4, 7, 9,
    15, 14, 13, 12, 10, 9, 8, 7, 8, 9, 12, 12, 14, 13, 12, 11,
    10, 9, 8, 9,
  };
  public static_bookblock books;
  public static_codebook _huff_book__44c9_s_short;
  public static_codebook _huff_book__44c9_s_long;
  static_codebook zero = null;


  public resbook_44s_9() {

    _huff_book__44c9_s_short = new static_codebook(
      2, 100,
      _huff_lengthlist__44c9_s_short,
      0, 0, 0, 0, 0,
      null,
      null,
      null,
      null,
      0
    );

    _huff_book__44c9_s_long = new static_codebook(
      2, 100,
      _huff_lengthlist__44c9_s_long,
      0, 0, 0, 0, 0,
      null,
      null,
      null,
      null,
      0
    );

    books = new static_bookblock(new static_codebook[][]{

      {zero},
      {zero, zero, _44c9_s_p1_0},
      {zero, zero, _44c9_s_p2_0},
      {zero, zero, _44c9_s_p3_0},
      {zero, zero, _44c9_s_p4_0},
      {_44c9_s_p5_0, _44c9_s_p5_1},
      {_44c9_s_p6_0, _44c9_s_p6_1},
      {_44c9_s_p7_0, _44c9_s_p7_1},
      {_44c9_s_p8_0, _44c9_s_p8_1},
      {_44c9_s_p9_0, _44c9_s_p9_1, _44c9_s_p9_2},
    });
  }
}