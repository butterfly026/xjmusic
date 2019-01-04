// Copyright (c) 2018, XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.worker.job.impl;

import com.google.inject.Inject;
import com.google.inject.assistedinject.Assisted;
import io.xj.core.access.impl.Access;
import io.xj.core.config.Config;
import io.xj.core.dao.SegmentDAO;
import io.xj.core.dao.SegmentMessageDAO;
import io.xj.core.exception.BusinessException;
import io.xj.core.exception.ConfigException;
import io.xj.core.model.message.MessageType;
import io.xj.core.model.segment.Segment;
import io.xj.core.model.segment.SegmentState;
import io.xj.core.model.segment_message.SegmentMessage;
import io.xj.core.work.WorkManager;
import io.xj.craft.CraftFactory;
import io.xj.craft.basis.Basis;
import io.xj.craft.basis.BasisFactory;
import io.xj.dub.DubFactory;
import io.xj.worker.job.SegmentFabricateJob;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.math.BigInteger;
import java.util.Objects;

public class SegmentFabricateJobImpl implements SegmentFabricateJob {
  private static final Logger log = LoggerFactory.getLogger(SegmentFabricateJobImpl.class);

  private final SegmentDAO segmentDAO;
  private final SegmentMessageDAO segmentMessageDAO;
  private final BigInteger entityId;
  private final BasisFactory basisFactory;
  private final CraftFactory craftFactory;
  private final DubFactory dubFactory;
  private final WorkManager workManager;
  private Basis basis;
  private Segment segment;

  @Inject
  public SegmentFabricateJobImpl(
    @Assisted("entityId") BigInteger entityId,
    CraftFactory craftFactory,
    BasisFactory basisFactory,
    SegmentDAO segmentDAO,
    SegmentMessageDAO segmentMessageDAO,
    DubFactory dubFactory,
    WorkManager workManager
  ) {
    this.entityId = entityId;
    this.craftFactory = craftFactory;
    this.basisFactory = basisFactory;
    this.segmentDAO = segmentDAO;
    this.segmentMessageDAO = segmentMessageDAO;
    this.dubFactory = dubFactory;
    this.workManager = workManager;
  }

  /**
   Do the segment Job
   */
  @Override
  public void run() {
    try {
      log.info("[segId={}] will read Segment for fabrication", entityId);
      segment = segmentDAO.readOne(Access.internal(), entityId);
    } catch (Exception e) {
      didFailWhile("retrieving", e);
      return;
    }

    if (Objects.isNull(segment)) {
      didFailWhile("retrieving null");
      return;
    }

    try {
      log.info("[segId={}] will prepare basis", entityId);
      basis = basisFactory.createBasis(segment);
    } catch (ConfigException e) {
      didFailWhile("creating basis", e);
      return;
    }

    try {
      log.info("[segId={}] will do craft work", entityId);
      doCraftWork();
    } catch (Exception e) {
      didFailWhile("doing Craft work", e);
      revertAndRequeue();
      return;
    }

    try {
      doDubWork();
    } catch (Exception e) {
      didFailWhile("doing Dub work", e);
      return;
    }

    try {
      finishWork();
    } catch (Exception e) {
      didFailWhile("finishing work", e);
    }
  }

  /**
   [#158610991] Engineer wants a Segment to be reverted, and re-queued for Craft, in the event that such a Segment has just failed its Craft process, in order to ensure Chain fabrication fault tolerance
   */
  private void revertAndRequeue() {
    try {
      updateSegmentState(basis.segment().getState(), SegmentState.Planned);
      segmentDAO.revert(Access.internal(), basis.segment().getId());
      workManager.scheduleSegmentFabricate(Config.segmentRequeueSeconds(), basis.segment().getId());
    } catch (Exception e) {
      didFailWhile("reverting and re-queueing segment", e);
    }
  }

  /**
   Finish work on Segment
   */
  private void finishWork() throws Exception {
    updateSegmentState(SegmentState.Dubbing, SegmentState.Dubbed);
    log.info("[segId={}] Worked for {} seconds", entityId, basis.elapsedSeconds());
  }

  /**
   Craft a Segment, or fail

   @throws ConfigException   on configuration failure
   @throws BusinessException on failure
   */
  private void doCraftWork() throws Exception {
    updateSegmentState(SegmentState.Planned, SegmentState.Crafting);
    craftFactory.macroMain(basis).doWork();
    craftFactory.rhythm(basis).doWork();
    craftFactory.harmonicDetail(basis).doWork();
  }

  /**
   Dub a Segment, or fail

   @throws ConfigException   if mis-configured
   @throws BusinessException on failure
   */
  protected void doDubWork() throws Exception {
    updateSegmentState(SegmentState.Crafting, SegmentState.Dubbing);
    dubFactory.master(basis).doWork();
    dubFactory.ship(basis).doWork();
  }

  /**
   Log and create segment message of error that job failed while (message)

   @param message phrased like "Doing work"
   @param e       exception (optional)
   */
  private void didFailWhile(String message, Exception e) {
    createSegmentMessage(MessageType.Error, String.format("Failed while %s for Segment #%s:\n\n%s", message, entityId, e.getMessage()));
    log.error("[segId={}] Failed while {}", entityId, message, e);
  }

  /**
   Log and create segment message of error that job failed while (message)

   @param message phrased like "Doing work"
   */
  private void didFailWhile(String message) {
    createSegmentMessage(MessageType.Error, String.format("Failed while %s for Segment #%s", message, entityId));
    log.error("[segId={}] Failed while {}", entityId, message);
  }

  /**
   Create a segment message

   @param type of message
   @param body of message
   */
  protected void createSegmentMessage(MessageType type, String body) {
    try {
      segmentMessageDAO.create(Access.internal(),
        new SegmentMessage()
          .setSegmentId(entityId)
          .setBody(body)
          .setType(type.toString()));
    } catch (Exception e) {
      log.error("[segId={}] Could not create Segment Message", entityId, e);
    }
  }

  /**
   Update Segment to Working state

   @throws Exception on failure
   */
  private void updateSegmentState(SegmentState fromState, SegmentState toState) throws Exception {
    if (fromState != segment.getState()) {
      log.error("[segId={}] {} requires Segment must be in {} state.", entityId, toState, fromState);
      return;
    }
    segmentDAO.updateState(Access.internal(), segment.getId(), toState);
    segment.setStateEnum(toState);
    log.info("[segId={}] Segment transitioned to state {} OK", entityId, toState);
  }

}
