// Copyright Outright Mental, Inc. All Rights Reserved.
package io.outright.xj.hub.service;

public class ServiceImpl implements Service {

  @Override
  public String get(String path) {
    if (path.startsWith("/engines")) {
      return "{engines:true}";
    } else {
      return "{}";
    }
  }
}
