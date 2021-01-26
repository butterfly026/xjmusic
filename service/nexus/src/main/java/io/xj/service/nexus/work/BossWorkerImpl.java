package io.xj.service.nexus.work;

import com.google.inject.Inject;
import com.newrelic.api.agent.NewRelic;
import com.newrelic.api.agent.Trace;
import io.xj.Chain;
import io.xj.lib.entity.Entities;
import io.xj.service.hub.client.HubClientAccess;
import io.xj.service.nexus.dao.ChainDAO;
import io.xj.service.nexus.dao.exception.DAOFatalException;
import io.xj.service.nexus.dao.exception.DAOPrivilegeException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.Collection;
import java.util.stream.Collectors;

/**
 Boss Worker implementation
 */
public class BossWorkerImpl extends WorkerImpl implements BossWorker {
  private static final String NAME = "Boss";
  private static final String CHAIN_STARTED = "ChainStarted";
  private static final String CHAIN_CANCELLED = "ChainCancelled";
  private final Logger log = LoggerFactory.getLogger(BossWorkerImpl.class);
  private final HubClientAccess access = HubClientAccess.internal();
  private final NexusWork work;
  private final ChainDAO chainDAO;

  @Inject
  public BossWorkerImpl(
    NexusWork work,
    ChainDAO chainDAO
  ) {
    this.work = work;
    this.chainDAO = chainDAO;

    log.info("Instantiated OK");
  }

  /**
   Do the work-- this is called by the underlying WorkerImpl run() hook

   @throws DAOPrivilegeException on access failure
   @throws DAOFatalException     on internal failure
   */
  @Trace(metricName = "Work/Boss", dispatcher = true)
  protected void doWork() throws DAOPrivilegeException, DAOFatalException {
    Collection<String> activeIds = getActiveChainIds();
    startActiveChains(activeIds);
    cancelInactiveChains(activeIds);
  }

  @Override
  protected String getName() {
    return NAME;
  }

  /**
   Get the IDs of all Chains in the store whose state is currently in Fabricate

   @return active Chain IDS
   @throws DAOPrivilegeException on access control failure
   @throws DAOFatalException     on internal failure
   */
  private Collection<String> getActiveChainIds() throws DAOPrivilegeException, DAOFatalException {
    return chainDAO.readManyInState(access, Chain.State.Fabricate)
      .stream()
      .flatMap(Entities::flatMapIds)
      .collect(Collectors.toList());
  }

  /**
   Cancel all Chains that are not in the list of active Chain IDs

   @param activeIds to avoid cancellation
   */
  private void cancelInactiveChains(Collection<String> activeIds) {
    int chainsCanceled = 0;
    for (String id : work.getChainWorkingIds())
      if (!activeIds.contains(id)) {
        work.cancelChainWork(id);
        log.info("Did cancel work on Chain[{}]", id);
        chainsCanceled++;
      }
    NewRelic.incrementCounter(CHAIN_CANCELLED, chainsCanceled);
  }

  /**
   Start work on all chains from this list of active Chain IDs

   @param activeIds to start if not already active
   */
  private void startActiveChains(Collection<String> activeIds) {
    int chainsStarted = 0;
    for (String id : activeIds)
      if (!work.isWorkingOnChain(id)) {
        work.beginChainWork(id);
        log.info("Did start work on Chain[{}]", id);
        chainsStarted++;
      }
    NewRelic.incrementCounter(CHAIN_STARTED, chainsStarted);
  }
}
