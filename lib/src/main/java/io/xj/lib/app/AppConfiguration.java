package io.xj.lib.app;

public class AppConfiguration {
  private String name;

  public AppConfiguration(String name) {
    this.name = name;
  }

  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }
}
