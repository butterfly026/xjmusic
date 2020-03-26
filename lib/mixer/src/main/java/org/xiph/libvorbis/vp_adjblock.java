// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.

package org.xiph.libvorbis;

import static org.xiph.libvorbis.vorbis_constants.integer_constants.P_BANDS;

public class vp_adjblock {

	int[] block;	// block[P_BANDS]


	public vp_adjblock( int[] _block ) {

		block = new int[ P_BANDS ];
		System.arraycopy( _block, 0, block, 0, _block.length );
	}

	public vp_adjblock( vp_adjblock src ) {

		this( src.block );
	}
}
