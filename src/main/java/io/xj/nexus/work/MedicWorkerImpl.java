package io.xj.nexus.work;

import com.google.common.collect.Maps;
import com.google.inject.Inject;
import com.typesafe.config.Config;
import datadog.trace.api.Trace;
import io.xj.Chain;
import io.xj.lib.notification.NotificationProvider;
import io.xj.lib.telemetry.TelemetryProvider;
import io.xj.nexus.hub_client.client.HubClientAccess;
import io.xj.nexus.dao.ChainDAO;
import io.xj.nexus.dao.exception.DAOExistenceException;
import io.xj.nexus.dao.exception.DAOFatalException;
import io.xj.nexus.dao.exception.DAOPrivilegeException;
import io.xj.nexus.dao.exception.DAOValidationException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.time.Instant;
import java.util.Map;

/**
 Medic Worker implementation
 */
public class MedicWorkerImpl extends WorkerImpl implements MedicWorker {
  private static final String NAME = "Medic";
  private final Logger log = LoggerFactory.getLogger(MedicWorker.class);
  private final HubClientAccess access = HubClientAccess.internal();
  private final ChainDAO chainDAO;
  private final int reviveChainProductionGraceSeconds;
  private final TelemetryProvider telemetryProvider;
  private final int reviveChainFabricatedBehindSeconds;
  private final boolean medicEnabled;

  @Inject
  public MedicWorkerImpl(
    Config config,
    ChainDAO chainDAO,
    NotificationProvider notification,
    TelemetryProvider telemetryProvider
  ) {
    super(notification);
    this.chainDAO = chainDAO;
    this.telemetryProvider = telemetryProvider;

    medicEnabled = config.getBoolean("fabrication.medicEnabled");
    reviveChainFabricatedBehindSeconds = config.getInt("fabrication.reviveChainFabricatedBehindSeconds");
    reviveChainProductionGraceSeconds = config.getInt("fabrication.reviveChainProductionGraceSeconds");

    log.debug("Instantiated OK");
  }

  @Override
  protected String getName() {
    return NAME;
  }

  /**
   Do the work-- this is called by the underlying WorkerImpl run() hook

   @throws DAOFatalException      on failure
   @throws DAOPrivilegeException  on failure
   @throws DAOValidationException on failure
   @throws DAOExistenceException  on failure
   */
  @Trace(resourceName = "nexus/medic", operationName = "doWork")
  protected void doWork() throws DAOFatalException, DAOPrivilegeException, DAOValidationException, DAOExistenceException {
    if (medicEnabled) {
      long t = Instant.now().toEpochMilli();
      checkAndReviveAll();
      log.debug("Did run in {}ms OK", Instant.now().toEpochMilli() - t);
    }
  }

  /**
   [#158897383] Engineer wants platform heartbeat to check for any stale production chains in fabricate state,
   and if found, *revive* it in order to ensure the Chain remains in an operable state.
   <p>
   [#177021797] Medic relies on precomputed  telemetry of fabrication latency

   @throws DAOFatalException      on failure
   @throws DAOPrivilegeException  on failure
   @throws DAOValidationException on failure
   @throws DAOExistenceException  on failure
   */
  @Trace(resourceName = "nexus/medic", operationName = "checkAndReviveAll")
  public void checkAndReviveAll() throws DAOFatalException, DAOPrivilegeException, DAOValidationException, DAOExistenceException {
    Instant thresholdChainProductionStartedBefore = Instant.now().minusSeconds(reviveChainProductionGraceSeconds);

    Map<String, String> stalledChainIds = Maps.newHashMap();
    chainDAO.readManyInState(access, Chain.State.Fabricate)
      .stream()
      .filter((chain) ->
        Chain.Type.Production.equals(chain.getType()) &&
          Instant.parse(chain.getStartAt()).isBefore(thresholdChainProductionStartedBefore))
      .forEach(chain -> {
        if (chain.getFabricatedAheadSeconds() < -reviveChainFabricatedBehindSeconds) {
          log.warn("Chain {} is stalled, fabricatedAheadSeconds={}",
            chain.getId(), chain.getFabricatedAheadSeconds());
          stalledChainIds.put(chain.getId(),
            String.format("fabricatedAheadSeconds=%s", chain.getFabricatedAheadSeconds()));
        }
      });

    // revive all stalled chains
    for (String stalledChainId : stalledChainIds.keySet()) {
      chainDAO.revive(access, stalledChainId, stalledChainIds.get(stalledChainId));
      // [#173968355] Nexus deletes entire chain when no current segments are left.
      chainDAO.destroy(access, stalledChainId);
    }

    telemetryProvider.getStatsDClient().incrementCounter("chain.revived", stalledChainIds.size());
  }
}