// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.

package org.xiph.libvorbis;

public class encode_aux_pigeonhole {

	float min;
	float del;

	int mapentries;
	int quantvals;
	int[] pigeonmap;	// long *pigeonmap

	int fittotal;		// long fittotal
	int[] fitlist;		// long *fitlist
	int[] fitmap;		// long *fitmap
	int[] fitlength;	// long *fitlength


	public encode_aux_pigeonhole( float _min, float _del, int _mapentries, int _quantvals, int[] _pigeonmap, int _fittotal, int[] _fitlist, int[] _fitmap, int[] _fitlength ) {

		min = _min;
		del = _del;

		mapentries = _mapentries;
		quantvals = _quantvals;

		if ( _pigeonmap == null )
			pigeonmap = null;
		else
			pigeonmap = (int[])_pigeonmap.clone();

		fittotal = _fittotal;

		if ( _fitlist == null )
			fitlist = null;
		else
			fitlist = (int[])_fitlist.clone();

		if ( _fitmap == null )
			fitmap = null;
		else
			fitmap = (int[])_fitmap.clone();

		if ( _fitlength == null )
			fitlength = null;
		else
			fitlength = (int[])_fitlength.clone();
	}

	public encode_aux_pigeonhole( encode_aux_pigeonhole src ) {

		this( src.min, src.del, src.mapentries, src.quantvals, src.pigeonmap, src.fittotal, src.fitlist, src.fitmap, src.fitlength );
	}
}
