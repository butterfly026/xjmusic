// Copyright (c) 2018, XJ Music Inc. (https://xj.io) All Rights Reserved.
package io.xj.hub.resource.auth.google;

import io.xj.core.exception.CoreException;
import io.xj.core.external.google.GoogleProvider;
import io.xj.hub.HubResource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.annotation.security.PermitAll;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.core.Response;
import java.net.URI;

/**
 Authenticate via Google OAuth2
 */
@Path("auth/google")
public class AuthGoogleResource extends HubResource {
  private static Logger log = LoggerFactory.getLogger(AuthGoogleResource.class);

  /**
   Begin user OAuth2 authentication via Google.

   @return Response redirection to auth code request URL
   */
  @GET
  @PermitAll
  public Response redirectToAuthCodeRequestUrl() {
    GoogleProvider authGoogleProvider = injector.getInstance(GoogleProvider.class);
    String url;
    try {
      url = authGoogleProvider.getAuthCodeRequestUrl();
    } catch (CoreException e) {
      log.error("Google Auth Provider Failed!", e);
      return Response.serverError().build();
    }

    return Response.temporaryRedirect(URI.create(url)).build();
  }
}
