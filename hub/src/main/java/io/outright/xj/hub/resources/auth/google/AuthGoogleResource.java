package io.outright.xj.hub.resources.auth.google;

import io.outright.xj.core.application.auth.google.GoogleAuthModule;
import io.outright.xj.core.application.auth.google.GoogleAuthProvider;
import io.outright.xj.core.application.exception.ConfigException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.google.inject.Guice;
import com.google.inject.Injector;

import javax.jws.WebResult;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.core.Response;
import java.net.URI;

/**
 * Root resource (exposed at "o2" path)
 */
@Path("auth/google")
public class AuthGoogleResource {
  private Injector injector = Guice.createInjector(new GoogleAuthModule());
  private Logger log = LoggerFactory.getLogger(AuthGoogleResource.class);

  /**
   * Begin user OAuth2 authentication via Google.
   *
   * @return Response temporary redirection to auth URL
   */
  @GET
  @WebResult
  public Response authGoogleBegin() {
    GoogleAuthProvider googleAuthProvider = injector.getInstance(GoogleAuthProvider.class);
    String url;
    try {
      url = googleAuthProvider.getAuthCodeRequestUrl();
    } catch (ConfigException e) {
      log.error("Google Auth Provider Failed!", e);
      return Response.serverError().build();
    }

    return Response.temporaryRedirect(URI.create(url)).build();
  }
}
