//  Copyright (c) 2018, XJ Music Inc. (https://xj.io) All Rights Reserved.
import Component from '@ember/component';
import {set} from '@ember/object';
import {inject as service} from '@ember/service';

// Must correspond to backend in [core/model/Chord]
const SEPARATOR_PRIMARY = ":";
const SEPARATOR_SECONDARY = "|";

/**
 * Displays the digest-performing and result-viewing U.I.
 */
const ChordProgressionComponent = Component.extend({

  // Inject: flash message service
  display: service(),

  /**
   Component will render
   */
  willRender() {
    if (typeof this.descriptor === "string") {
      let segmentsArr = [];
      this.descriptor.split(SEPARATOR_PRIMARY).forEach((segmentString) => {
        let segmentArr = segmentString.split(SEPARATOR_SECONDARY);
        let segmentObj = {};
        if (1 === segmentArr.length) {
          segmentObj['form'] = segmentArr[0];
        } else if (2 === segmentArr.length) {
          segmentObj['deltaRootPitchClass'] = segmentArr[0];
          segmentObj['form'] = segmentArr[1];
        }
        segmentsArr.push(segmentObj);
      });
      set(this, "segments", segmentsArr);
    }
  },


});

/**
 * Example Usage (e.g, in Handlebars):
 *
 *   {{chord-progression chordProgressionGroup.descriptor}}
 */
ChordProgressionComponent.reopenClass({
  positionalParams: ['descriptor']
});

export default ChordProgressionComponent;
