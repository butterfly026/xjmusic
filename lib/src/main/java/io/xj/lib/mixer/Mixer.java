// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.lib.mixer;

import java.io.BufferedInputStream;
import java.io.IOException;

/**
 a Mixer sums audio sources over a finite length of time into an output audio stream.
 <p>
 a Mix instance requires one output audio file format and output stream.
 (NOTE: the audio file format specifies the final output length)
 <p>
 ALL time in the `mix` module is measured in microseconds as `long` primitive.
 Sources are set, each with a time and velocity
 <p>
 A source is loaded then used many times with different velocity.
 Each usage of a source is known as a Put.
 <p>
 Finally, the output audio is pulled out of the mixer. The final number of output
 "frames" of audio is known ahead of time (frame rate X length) and the mixer
 knows to provide all of those output audio frames in sequence from first to last.
 <p>
 Before frame zero, then again every N number of frames (the "mix cycle")
 some more costly operations are performed. For example, there are multiple
 collections of Puts stored in the mixer: readyPuts, livePuts, and donePuts.
 Puts are staged in readyPuts, then moved into livePuts only when within a small
 range of their playback time. This greatly reduced overhead of checking all
 the puts for live-ness during the course of a single mix.
 */
public interface Mixer {

  /**
   Put a source audio into the mix at a specified time and velocity.
   <p>
   the Put only has a reference to the source--
   so the Mixer has to use that reference source id along with other variables from the Put,
   in order to arrive at the final source output value at any given microsecond@param sourceId      under which the audio is stored@param startAtMicros duration from beginning of mix@param busId@param stopAtMicros  duration from beginning of mix

   @param velocity 0 to 1
   */
  void put(String busId, String sourceId, long startAtMicros, long stopAtMicros, double velocity) throws PutException;

  /**
   Set the level for a given bus name

   @param busId to set level for
   @param level to set
   */
  void setBusLevel(String busId, double level);

  /**
   Load a source audio from input stream and cache it in memory under an alias.

   @param sourceId    under which to store this source
   @param inputStream of source audio
   */
  void loadSource(String sourceId, BufferedInputStream inputStream) throws FormatException, IOException, SourceException;

  /**
   THE BIG SHOW
   <p>
   Mix out to a file

   @param outputFilePath path
   @param quality        of output (if lossy encoding)
   @return total # of seconds mixed (double floating-point)
   @throws MixerException if something goes wrong
   */
  double mixToFile(OutputEncoder outputEncoder, String outputFilePath, Float quality) throws Exception;

  /**
   Get the current count of all sources.

   @return count
   */
  int getSourceCount();

  /**
   Get state

   @return state
   */
  MixerState getState();

  /**
   Whether the mixer has loaded a specified source

   @param sourceKey to check for
   @return true if source has been loaded
   */
  boolean hasLoadedSource(String sourceKey);

  /**
   Get a source by id

   @param sourceId to get
   @return source
   */
  Source getSource(String sourceId);
}