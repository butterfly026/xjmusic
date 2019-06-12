// Copyright (c) 2018, XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.worker;

import com.google.inject.Inject;
import io.xj.core.exception.CoreException;
import io.xj.core.model.work.Work;
import io.xj.core.model.work.WorkType;
import net.greghaines.jesque.Job;
import net.greghaines.jesque.worker.JobFactory;

import java.math.BigInteger;
import java.util.Map;
import java.util.Objects;

/**
 Factory to instantiate workers for jobs,
 pluggable to Jesque job macro API.
 */
public class JobSourceFactory implements JobFactory {
  //  private static final Logger log = LoggerFactory.getLogger(JobSourceFactory.class);
  private final JobTargetFactory jobTargetFactory;

  @Inject
  JobSourceFactory(
    JobTargetFactory jobTargetFactory
  ) {
    this.jobTargetFactory = jobTargetFactory;
  }

  /**
   Get entity id value from argument

   @param arg to parse
   @return id value
   @throws CoreException on failure
   */
  private static BigInteger entityId(Object arg) throws CoreException {
    BigInteger entityId = new BigInteger(String.valueOf(arg));
    if (0 == entityId.compareTo(BigInteger.valueOf(0))) {
      throw new CoreException("Job requires non-zero entity id");
    }
    return entityId;
  }

  /**
   Materializes a job.

   @param job the job to materialize
   @return the materialized job
   @throws Exception if there was an exception creating the object
   */
  @Override
  public Runnable materializeJob(Job job) throws Exception {
    WorkType workType = WorkType.validate(job.getClassName());
    Map<String, Object> vars = job.getVars();
    if (Objects.isNull(vars) || 1 > vars.size()) {
      throw new CoreException("Job ought to have been created with at least 1 named variable");
    }

    return makeTarget(workType, vars);
  }

  /**
   target is switched on job type

   @param workType type of job
   @param vars     target arguments (the first one needs to be a BigInteger target entity id)
   @return job runnable
   */
  private Runnable makeTarget(WorkType workType, Map<String, Object> vars) throws CoreException {
    switch (workType) {

      case ChainErase:
        return jobTargetFactory.makeChainEraseJob(entityId(vars.get(Work.KEY_TARGET_ID)));

      case ChainFabricate:
        return jobTargetFactory.makeChainFabricateJob(entityId(vars.get(Work.KEY_TARGET_ID)));

      case SegmentFabricate:
        return jobTargetFactory.makeSegmentFabricateJob(entityId(vars.get(Work.KEY_TARGET_ID)));

      default:
        throw new CoreException("Invalid Job Type");
    }
  }


}
