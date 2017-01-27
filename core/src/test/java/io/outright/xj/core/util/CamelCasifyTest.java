package io.outright.xj.core.util;

import org.junit.Test;

import static org.junit.Assert.assertEquals;

public class CamelCasifyTest {
  @Test
  public void ifNeeded() throws Exception {
    assertEquals("manuts", CamelCasify.ifNeeded("manuts"));
    assertEquals("maNuts", CamelCasify.ifNeeded("maNuts"));
    assertEquals("maNuts", CamelCasify.ifNeeded("ma_nuts"));
  }

}