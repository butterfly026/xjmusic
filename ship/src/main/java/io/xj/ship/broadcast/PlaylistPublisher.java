// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.ship.broadcast;

import io.xj.ship.ShipException;

/**
 This process is run directly in the hard loop (not in a Fork/Join pool)
 <p>
 Ship broadcast via HTTP Live Streaming #179453189
 <p>
 MPEG-DASH Media Presentation Description
 <p>
 References
 <p>
 ISO/IEC 23009-1:2019: Information technology — Dynamic adaptive streaming over HTTP (DASH) — Part 1: Media presentation description and segment formats, 2019-12,
 International Organization for Standardization, Geneva, Switzerland.
 - https://www.iso.org/standard/79329.html
 - https://bitmovin.com/dynamic-adaptive-streaming-http-mpeg-dash/
 - https://en.wikipedia.org/wiki/Dynamic_Adaptive_Streaming_over_HTTP
 - https://mpeg.chiariglione.org/standards/mpeg-dash/media-presentation-description-and-segment-formats
 - http://rdmedia.bbc.co.uk/dash/ondemand/bbb/
 */
public interface PlaylistPublisher {

  /**
   Attempt to rehydrate ship from the last .m3u8 playlist that was uploaded for this ship key
   <p>
   Ship rehydrates from last shipped .m3u8 playlist file #180723357
   */
  void rehydratePlaylist();

  /**
   Publish the custom .m3u8 file

   @param atMillis at which to publish (now, unless we're testing)
   */
  void publish(long atMillis) throws ShipException;

}