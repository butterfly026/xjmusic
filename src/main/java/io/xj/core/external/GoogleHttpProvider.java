// Copyright (c) XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.core.external;

import com.google.api.client.http.HttpTransport;

public interface GoogleHttpProvider {
  HttpTransport getTransport();
}