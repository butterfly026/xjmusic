package io.outright.xj.core.external.amazon;

import io.outright.xj.core.CoreModule;
import io.outright.xj.core.app.exception.ConfigException;
import io.outright.xj.core.util.token.TokenGenerator;

import com.google.inject.AbstractModule;
import com.google.inject.Guice;
import com.google.inject.Injector;
import com.google.inject.util.Modules;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.Mock;
import org.mockito.runners.MockitoJUnitRunner;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.mockito.Mockito.when;

@RunWith(MockitoJUnitRunner.class)
public class AmazonProviderImplTest {
  @Mock private TokenGenerator tokenGenerator;
  private Injector injector;
  private AmazonProvider amazonProvider;

  @Before
  public void setUp() throws Exception {
    System.setProperty("audio.url.upload", "https://s3.amazonaws.com/test-bucket/");
    System.setProperty("aws.accessKeyId", "AKIALKSFDJKGIOURTJ7H");
    System.setProperty("aws.secretKey", "jhfd897+jkhjHJJDKJF/908090JHKJJHhjhfg78h");
    System.setProperty("audio.file.upload.acl", "bucket-owner-full-control");
    System.setProperty("audio.file.upload.expire.minutes", "60");
    System.setProperty("audio.file.bucket", "xj-audio-dev");

    createInjector();
    amazonProvider = injector.getInstance(AmazonProvider.class);
  }

  @After
  public void tearDown() throws Exception {
    amazonProvider = null;
    System.clearProperty("audio.url.upload");
    System.clearProperty("aws.accessKeyId");
    System.clearProperty("aws.secretKey");
    System.clearProperty("audio.file.upload.acl");
    System.clearProperty("audio.file.upload.expire.minutes");
    System.clearProperty("audio.file.bucket");
  }

  @Test
  public void generateUploadPolicy() throws Exception {
    S3UploadPolicy policy = amazonProvider.generateAudioUploadPolicy();

    assertNotNull(policy);
  }

  @Test(expected=ConfigException.class)
  public void generateUploadPolicy_failsWithoutConfigs() throws Exception {
    System.clearProperty("audio.file.upload.expire.minutes");

    amazonProvider.generateAudioUploadPolicy();
  }

  @Test
  public void generateKey() throws Exception {
    when(tokenGenerator.generateShort())
      .thenReturn("token123");

    String url = amazonProvider.generateKey("file-name", "wav");

    assertEquals("file-name-token123.wav", url);
  }

  @Test
  public void getUploadUrl() throws Exception {
    when(tokenGenerator.generateShort())
      .thenReturn("token123");

    String url = amazonProvider.getUploadURL();

    assertEquals("https://s3.amazonaws.com/test-bucket/", url);
  }

  private void createInjector() {
    injector = Guice.createInjector(Modules.override(new CoreModule()).with(
      new AbstractModule() {
        @Override
        public void configure() {
          bind(TokenGenerator.class).toInstance(tokenGenerator);
        }
      }));
  }

}
