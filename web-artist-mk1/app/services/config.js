/*
 * Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.
 */

import fetch from 'fetch';
import Service, {inject as service} from '@ember/service';
import RSVP from "rsvp";

export default Service.extend({

  // empty properties
  apiBaseUrl: "/api/1/",
  instrumentStates: [],
  programStates: [],
  segmentBaseUrl: "/",
  playerBaseUrl: "/",
  choiceTypes: [],
  baseUrl: "/",
  defaultChainConfig: "",
  defaultProgramConfig: "",
  defaultInstrumentConfig: "",
  instrumentTypes: [],
  chainStates: [],
  segmentStates: [],
  audioBaseUrl: "/",
  chainTypes: [],
  patternDetailTypes: [],
  voiceTypes: [],
  patternTypes: [],
  programTypes: [],

  /**
   Get the platform configuration from the backend
   as a promise, such that any subsequent getters are blocked by the API call
   and any subsequent implementors of those getters are blocked
   and their subsequent actions are blocked
   until everything is ready
   */
  getConfig() {
    let self = this;

    return RSVP.Promise.all([
      self.fetchConfig('/config'),
    ], "Fetch all configurations");
  },

  /**
   Fetch one configuration path and set all the retrieved values

   @param path to fetch
   @return {RSVP.Promise}
   */
  fetchConfig(path) {
    let self = this;

    return new RSVP.Promise(
      function (resolve, reject) {
        fetch(path, {
          headers: {
            'Content-Type': 'application/json'
          },
        }).then(function (response) {
          return response.json();
        }).then(
          (payload) => {
            if (payload.hasOwnProperty('data') && payload['data'].hasOwnProperty('attributes')) {
              let configData = payload['data']['attributes'];
              for (let key in configData) if (configData.hasOwnProperty(key)) {
                self.set(key, configData[key]);
                console.debug(`[config] ${key}=${configData[key]}`);
              }
              resolve();

            } else {
              self.sendRejection(reject, 'Platform configuration is invalid.');
            }
          },
          (error) => {
            self.sendRejection(reject, 'Failed to get platform configuration: ' + error);
          });
      });
  },

  /**
   * Display a flash message and reject with the same message
   * @param reject
   * @param message
   */
  sendRejection(reject, message) {
    this.display.error(message);
    reject(message);
  },

  // Inject: Flash messages
  display: service()

});