// Copyright (c) 2018, XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.worker.job.impl;

import io.xj.core.access.impl.Access;
import io.xj.core.dao.PhaseChordDAO;
import io.xj.core.dao.PhaseDAO;
import io.xj.core.dao.PhaseMemeDAO;
import io.xj.core.dao.VoiceDAO;
import io.xj.core.dao.PhaseEventDAO;
import io.xj.core.exception.BusinessException;
import io.xj.craft.isometry.VoiceIsometry;
import io.xj.core.model.phase.Phase;
import io.xj.core.model.phase_chord.PhaseChord;
import io.xj.core.model.phase_meme.PhaseMeme;
import io.xj.core.model.voice.Voice;
import io.xj.core.model.phase_event.PhaseEvent;
import io.xj.core.transport.JSON;
import io.xj.worker.job.PhaseCloneJob;

import com.google.common.collect.ImmutableList;
import com.google.common.collect.Maps;
import com.google.inject.Inject;
import com.google.inject.assistedinject.Assisted;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.math.BigInteger;
import java.util.Collection;
import java.util.Map;
import java.util.Objects;

public class PhaseCloneJobImpl implements PhaseCloneJob {
  static final Logger log = LoggerFactory.getLogger(PhaseCloneJobImpl.class);
  private final BigInteger toId;
  private final PhaseDAO phaseDAO;
  private final BigInteger fromId;
  private final PhaseMemeDAO phaseMemeDAO;
  private final PhaseChordDAO phaseChordDAO;
  private final PhaseEventDAO phaseEventDAO;
  private final VoiceDAO voiceDAO;

  @Inject
  public PhaseCloneJobImpl(
    @Assisted("fromId") BigInteger fromId,
    @Assisted("toId") BigInteger toId,
    PhaseDAO phaseDAO,
    PhaseMemeDAO phaseMemeDAO,
    PhaseChordDAO phaseChordDAO,
    PhaseEventDAO phaseEventDAO,
    VoiceDAO voiceDAO
  ) {
    this.fromId = fromId;
    this.toId = toId;
    this.phaseDAO = phaseDAO;
    this.phaseMemeDAO = phaseMemeDAO;
    this.phaseChordDAO = phaseChordDAO;
    this.phaseEventDAO = phaseEventDAO;
    this.voiceDAO = voiceDAO;
  }

  @Override
  public void run() {
    try {
      if (Objects.nonNull(fromId) && Objects.nonNull(toId)) {
        doWork();
      }

    } catch (Exception e) {
      log.error("{}:{} failed ({})",
        getClass().getSimpleName(), Thread.currentThread().getName(), e);
    }
  }

  /**
   Do Phase Clone ExpectationOfWork
   Worker removes all child entities for the Phase
   Worker deletes all S3 objects for the Phase
   Worker deletes the Phase
   */
  private void doWork() throws Exception {
    Phase from = phaseDAO.readOne(Access.internal(), fromId);
    if (Objects.isNull(from))
      throw new BusinessException("Could not fetch clone source Phase");

    Phase to = phaseDAO.readOne(Access.internal(), toId);
    if (Objects.isNull(to))
      throw new BusinessException("Could not fetch clone target Phase");

    // Clone PhaseMeme
    phaseMemeDAO.readAll(Access.internal(), ImmutableList.of(fromId)).forEach(phaseMeme -> {
      phaseMeme.setPhaseId(toId);

      try {
        PhaseMeme toPhaseMeme = phaseMemeDAO.create(Access.internal(), phaseMeme);
        log.info("Cloned PhaseMeme from #{} to {}", phaseMeme.getId(), JSON.objectFrom(toPhaseMeme));

      } catch (Exception e) {
        log.error("Failed to clone PhaseMeme {}", JSON.objectFrom(phaseMeme), e);
      }
    });

    // Clone PhaseChord
    phaseChordDAO.readAll(Access.internal(), ImmutableList.of(fromId)).forEach(phaseChord -> {
      phaseChord.setPhaseId(toId);

      try {
        PhaseChord toPhaseChord = phaseChordDAO.create(Access.internal(), phaseChord);
        log.info("Cloned PhaseChord from #{} to {}", phaseChord.getId(), JSON.objectFrom(toPhaseChord));

      } catch (Exception e) {
        log.error("Failed to clone PhaseChord {}", JSON.objectFrom(phaseChord), e);
      }
    });

    // In order to assign cloned voice events to their new voice
    // Get all voices from source and (optionally, if different) target patterns;
    // map source to target voice ids
    Map<BigInteger, BigInteger> voiceCloneIds = Maps.newConcurrentMap();
    Collection<Voice> sourceVoices = voiceDAO.readAll(Access.internal(), ImmutableList.of(from.getPatternId()));
    if (Objects.equals(from.getPatternId(), to.getPatternId()))
      sourceVoices.forEach((voice) -> voiceCloneIds.put(voice.getId(), voice.getId()));
    else {
      VoiceIsometry targetVoices = VoiceIsometry.of(voiceDAO.readAll(Access.internal(), ImmutableList.of(to.getPatternId())));
      sourceVoices.forEach((sourceVoice) -> {
        Voice targetVoice = targetVoices.find(sourceVoice);
        if (Objects.nonNull(targetVoice))
          voiceCloneIds.put(sourceVoice.getId(), targetVoice.getId());
      });
    }

    //  Clone each PhaseEvent
    phaseEventDAO.readAll(Access.internal(), ImmutableList.of(fromId)).forEach(fromPhaseEvent -> {
      fromPhaseEvent.setPhaseId(toId);
      BigInteger toVoiceId = voiceCloneIds.getOrDefault(fromPhaseEvent.getVoiceId(), null);
      if (Objects.isNull(toVoiceId)) return;
      fromPhaseEvent.setVoiceId(toVoiceId);

      try {
        PhaseEvent toPhaseEvent = phaseEventDAO.create(Access.internal(), fromPhaseEvent);
        log.info("Cloned PhaseEvent from #{} to {}", fromPhaseEvent.getId(), JSON.objectFrom(toPhaseEvent));

      } catch (Exception e) {
        log.error("Failed to clone PhaseEvent from {}", JSON.objectFrom(fromPhaseEvent), e);
      }
    });

    log.info("Cloned Phase #{} and child entities to new Phase {}", fromId, JSON.objectFrom(to));
  }


}
