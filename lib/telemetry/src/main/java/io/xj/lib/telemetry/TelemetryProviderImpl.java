// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.lib.telemetry;

import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.services.cloudwatch.AmazonCloudWatch;
import com.amazonaws.services.cloudwatch.AmazonCloudWatchClientBuilder;
import com.amazonaws.services.cloudwatch.model.MetricDatum;
import com.amazonaws.services.cloudwatch.model.PutMetricDataRequest;
import com.amazonaws.services.cloudwatch.model.StandardUnit;
import com.google.inject.Inject;
import com.typesafe.config.Config;

/**
 Base telemetry implementation
 <p>
 Requires these typesafe configurations to be set:
 - aws.defaultRegion
 - aws.accessKeyID
 - aws.secretKey
 <p>
 [#171919183] Prometheus metrics reported by Java apps and consumed by CloudWatch
 <p>
 */
class TelemetryProviderImpl implements TelemetryProvider {
  private final AmazonCloudWatch telemetry;
  private final String awsAccessKeyId;
  private final String awsSecretKey;
  private final String awsDefaultRegion;

  @Override
  public MetricDatum datum(String name, StandardUnit unit, Double value) {
    return new MetricDatum()
      .withMetricName(name)
      .withUnit(unit)
      .withValue(value);
  }

  @Override
  public void send(String namespace, MetricDatum datum) {
    telemetry.putMetricData(
      new PutMetricDataRequest()
        .withNamespace(namespace)
        .withMetricData(datum));
  }

  @Override
  public void send(String namespace, String name, StandardUnit unit, Double value) {
    send(namespace, datum(name, unit, value));
  }

  @Inject
  public TelemetryProviderImpl(
    Config config
  ) {
    awsDefaultRegion = config.getString("aws.defaultRegion");
    awsAccessKeyId = config.getString("aws.accessKeyID");
    awsSecretKey = config.getString("aws.secretKey");
    telemetry = buildCloudWatchClient();
  }

  /**
   Get an Amazon S3 client

   @return S3 client
   */
  private AmazonCloudWatch buildCloudWatchClient() {
    BasicAWSCredentials credentials = new BasicAWSCredentials(awsAccessKeyId, awsSecretKey);
    return AmazonCloudWatchClientBuilder.standard()
      .withRegion(awsDefaultRegion)
      .withCredentials(new AWSStaticCredentialsProvider(credentials))
      .build();
  }
}