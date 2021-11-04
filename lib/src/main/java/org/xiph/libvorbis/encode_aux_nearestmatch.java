// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.

package org.xiph.libvorbis;

public class encode_aux_nearestmatch {

  // pre-calculated partitioning tree

  int[] ptr0;    // long *ptr0
  int[] ptr1;    // long *ptr1

  int[] p;    // long *p // decision points (each is an entry)
  int[] q;    // long *q // decision points (each is an entry)
  int aux;    // long aux // number of tree entries
  int alloc;    // long alloc


  public encode_aux_nearestmatch(int[] _ptr0, int[] _ptr1, int[] _p, int[] _q, int _aux, int _alloc) {

    if (_ptr0 == null)
      ptr0 = null;
    else
      ptr0 = _ptr0.clone();

    if (_ptr1 == null)
      ptr1 = null;
    else
      ptr1 = _ptr1.clone();

    if (_p == null)
      p = null;
    else
      p = _p.clone();

    if (_q == null)
      q = null;
    else
      q = _q.clone();

    aux = _aux;
    alloc = _alloc;
  }

  public encode_aux_nearestmatch(encode_aux_nearestmatch src) {

    this(src.ptr0, src.ptr1, src.p, src.q, src.aux, src.alloc);
  }
}