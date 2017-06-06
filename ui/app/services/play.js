// Copyright (c) 2017, Outright Mental Inc. (http://outright.io) All Rights Reserved.
import Ember from "ember";
import LinkAudio from "./play/link-audio";
import Moment from "moment";
import RSVP from "rsvp";

const STANDBY = 'Standby';
const PLAYING = 'Playing';

const STOP_DELAY_SECONDS = 0.5;
const CYCLE_MAIN_INTERVAL_SECONDS = 10;
const CYCLE_SUB_INTERVAL_SECONDS = 1;

/**
 Player service
 */
export default Ember.Service.extend({

  // Player
  player: null,

  // State, Chain Link
  state: STANDBY,

  // Inject: Configuration
  config: Ember.inject.service(),

  // Inject: Ember Data Store
  store: Ember.inject.service(),

  // Inject: flash message service
  display: Ember.inject.service(),

  // Inject: binary resource service
  binaryResource: Ember.inject.service(),

  // Base URL of link waveforms
  linkBaseUrl: '',

  // to store WebAudio context, which is never closed
  audioContext: newAudioContext(),

  // now-playing chain
  chain: null,

  // now-playing link
  link: null,

  // all active links
  activeLinks: [],

  // # seconds UTC, from which to play
  playFromSecondsUTC: 0,

  // time (in the WebAudio context), from which to play
  playFromContextTime: 0,

  // map of link id to LinkAudio
  linkAudios: Ember.Map.create(),

  // interval to store Main cycle
  cycleMainInterval: null,

  // interval to store Sub Cycle
  cycleSubInterval: null,

  /**
   New Player
   Load configuration
   */
  init() {
    let self = this;
    Ember.get(self, 'config').promises.config.then(
      (config) => {
        self.set('linkBaseUrl', config.linkBaseUrl);
        self.startMainCycle();
        self.startSubCycle();
      },
      (error) => {
        console.error('Failed to load config', error);
      }
    );
  },

  /**
   play a chain beginning at a certain link
   start the interval cycles

   @param chain to play
   @param link to play chain from
   */
  play(chain, link) {
    let self = this;

    // stop playback (which also incurs a delay)
    self.stop().then(() => {

        // set the new play-from data
        self.set('playFromContextTime', self.get('audioContext').currentTime);
        self.set('playFromSecondsUTC', self.computePlayFromSecondsUTC());

        // set the chain+link play request
        self.set('chain', chain);
        self.set('link', link);

        // now playing
        self.set('state', PLAYING);

        // do the cycles now
        self.doMainCycle();
        self.doSubCycle();
      },

      (error) => {
        console.error('failed to stop & start playback', error);
      });
  },

  /**
   Stop playback
   @returns {RSVP.Promise}
   */
  stop() {
    let self = this;
    return new RSVP.Promise((resolve, reject) => {
      this.close().then(() => {
        self.set('chain', null);
        self.set('link', null);
        self.set('state', STANDBY);
        Ember.run.later(resolve, STOP_DELAY_SECONDS * MILLISECONDS_PER_SECOND);
      }, reject);
    });
  },

  /**
   close player
   clear the cycle from happening any more
   teardown all link audio
   @returns {RSVP.Promise}
   */
  close() {
    return new RSVP.Promise((resolve, reject) => {
      try {
        this.teardownLinkAudioExcept([]);
        resolve();
      } catch (e) {
        reject(e);
      }
    });
  },

  /**
   Do Main Cycle every N seconds
   */
  doMainCycle() {
    if (this.get('chain') !== null) {
      this.refreshDataThenUpdate();
    }
  },

  /**
   do Sub Cycle every N seconds
   */
  doSubCycle() {
    if (this.get('chain') !== null) {
      this.update();
    }
  },

  /**
   Load Chain Links Data from seconds UTC, then update all link audios
   */
  refreshDataThenUpdate() {
    let self = this;
    let fromSecondsUTC = Math.floor(this.get('playFromSecondsUTC') + this.currentTime()); // must be integer for xj API here
    this.get('store').query('link', {
      chainId: self.get('chain').get('id'),
      fromSecondsUTC: fromSecondsUTC
    }).then(
      (links) => {
        this.set('activeLinks', links);
        this.update();
      },
      (error) => {
        console.error('Error loading Chain and Links', error);
      }
    );
  },

  /**
   Update all link audios
   */
  update() {
    let self = this;
    let links = this.get('activeLinks');
    let activeLinkIds = [];
    links.forEach(link => {
      self.updateLinkAudio(link);
      activeLinkIds.push(link.get('id'));
    });
    self.teardownLinkAudioExcept(activeLinkIds);
  },

  /**
   Update a link audio

   @param link
   */
  updateLinkAudio(link) {
    let linkId = link.get('id');
    let linkAudio = this.get('linkAudios').get(linkId);
    if (!linkAudio) {
      linkAudio = LinkAudio.create({
        audioContext: this.get('audioContext'),
        binaryResource: this.get('binaryResource'),
        linkId: link.get('id'),
        waveformUrl: this.get('linkBaseUrl') + link.get('waveformKey'),
        beginTime: this.computeBeginTime(link),
        timeOffset: this.computeTimeOffset(link),
        endTime: this.computeEndTime(link)
      });

      this.get('linkAudios').set(linkId, linkAudio);
    }
    if (linkAudio.isPlaying()) {
      this.set('link', link);
    }
  },

  /**
   garbage collection routine deletes any buffer source that is not in the current set of link ids
   Stop all LinkAudio buffer source playback via WebAudio API

   * @param activeLinkIds
   */
  teardownLinkAudioExcept(activeLinkIds) {
    this.get('linkAudios').forEach((linkAudio, linkId) => {
      if (!stringInArray(linkId.toString(), activeLinkIds)) {
        linkAudio.stopWebAudio();
        this.get('linkAudios').delete(linkId);
        console.log("[play] tore down de-referenced link id:" + linkId);
      }
    });
  },

  /**
   start the main cycle interval, and sub cycle interval
   */
  startMainCycle() {
    let self = this;

    self.doMainCycle();

    self.set('cycleMainInterval', setInterval(function () {
      self.doMainCycle();
    }, CYCLE_MAIN_INTERVAL_SECONDS * MILLISECONDS_PER_SECOND));

  },

  /**
   start the sub cycle interval, and sub cycle interval
   */
  startSubCycle() {
    let self = this;

    self.doSubCycle();

    self.set('cycleSubInterval', setInterval(function () {
      self.doSubCycle();
    }, CYCLE_SUB_INTERVAL_SECONDS * MILLISECONDS_PER_SECOND));
  },

  /**
   Seconds from UTC to the given date string
   * @param {String} fromTimeUTC
   */
  secondsUTC(fromTimeUTC) {
    return Moment.utc(fromTimeUTC).valueOf() / MILLISECONDS_PER_SECOND;
  },

  /**
   Seconds from UTC to now
   */
  nowSecondsUTC() {
    return Moment.utc().valueOf() / MILLISECONDS_PER_SECOND;
  },

  /**
   The player's current time, in seconds (float precision) since context start
   */
  currentTime() {
    return this.get('audioContext').currentTime - this.get('playFromContextTime');
  },

  /**
   compute begin time of link waveform in WebAudio context
   * @param link
   * @returns {*}
   */
  computeBeginTime(link) {
    let beginTimeRelative = this.computeBeginTimeRelative(link);
    if (beginTimeRelative > 0) {
      return this.get('playFromContextTime') + beginTimeRelative;
    } else {
      console.warn("beginTime 0 to compensate for beginTimeRelative", beginTimeRelative);
      return this.get('playFromContextTime');
    }
  },

  /**
   compute offset time of link in WebAudio context
   * @param link
   * @returns {*}
   */
  computeTimeOffset(link) {
    let beginTimeRelative = this.computeBeginTimeRelative(link);
    if (beginTimeRelative > 0) {
      return 0;
    } else {
      console.warn("timeOffset to compensate for beginTimeRelative", beginTimeRelative);
      return -beginTimeRelative;
    }
  },

  /**
   compute end time of link in WebAudio context
   * @param link
   * @returns {*}
   */
  computeEndTime(link) {
    return this.get('playFromContextTime') +
      Moment.utc(link.get('endAt')).valueOf() / MILLISECONDS_PER_SECOND - this.get('playFromSecondsUTC');
  },

  /**
   compute begin time of link waveform in WebAudio context, relative to playFromTime
   * @param link
   * @returns {*}
   */
  computeBeginTimeRelative(link) {
    return Moment.utc(link.get('beginAt')).valueOf() / MILLISECONDS_PER_SECOND - this.get('playFromSecondsUTC');
  },

  /**
   Compute play-from-seconds UTC depending on the request to play
   */
  computePlayFromSecondsUTC() {
    let chain = this.get('chain');
    let link = this.get('link');

    if (link !== undefined && link !== null) {
      return this.secondsUTC(link.get('beginAt'));
    }

    if (chain !== undefined && chain !== null && chain.get('stopAt') !== null) {
      let stopAt = this.secondsUTC(chain.get('stopAt'));
      if (stopAt > 0 && stopAt < this.nowSecondsUTC()) {
        // When playing a Chain that has an end time in the past, play it from its beginning.
        return this.secondsUTC(chain.get('startAt'));
      } else {
        // When playing a Chain that has no end time or an and time in the future, play it from now
        return this.nowSecondsUTC();
      }
    }

    return this.nowSecondsUTC();
  },

});

/**
 Assume array of strings, find needle in haystack
 * @param {String} needle
 * @param {Array} haystack
 * @return boolean
 */
function stringInArray(needle, haystack) {
  for (let i = 0; i < haystack.length; i++) {
    if (haystack[i] === needle) {
      return true;
    }
  }
  return false;
}


/**
 Initialize WebAudio context
 <p>
 See API: https://developer.mozilla.org/en-US/docs/Web/API/AudioContext
 <p>
 Also see tutorial which includes reasoning for using the more complex constructor of the window.* context below: https://developer.mozilla.org/en-US/docs/Web/API/Web_Audio_API/Using_Web_Audio_API
 */
function newAudioContext() {
  return new (window.AudioContext || window.webkitAudioContext)(); // jshint ignore:line
}

const MILLISECONDS_PER_SECOND = 1000;
