// Copyright (c) 2017, Outright Mental Inc. (http://outright.io) All Rights Reserved.
package io.outright.xj.core;

import io.outright.xj.core.app.App;
import io.outright.xj.core.app.AppImpl;
import io.outright.xj.core.app.access.AccessControlProvider;
import io.outright.xj.core.app.access.AccessControlProviderImpl;
import io.outright.xj.core.app.access.AccessLogFilterProvider;
import io.outright.xj.core.app.access.AccessLogFilterProviderImpl;
import io.outright.xj.core.app.access.AccessTokenAuthFilter;
import io.outright.xj.core.app.access.AccessTokenAuthFilterImpl;
import io.outright.xj.core.app.db.RedisDatabaseProvider;
import io.outright.xj.core.app.db.RedisDatabaseProviderImpl;
import io.outright.xj.core.app.db.SQLDatabaseProvider;
import io.outright.xj.core.app.db.SQLDatabaseProviderImpl;
import io.outright.xj.core.app.server.HttpResponseProvider;
import io.outright.xj.core.app.server.HttpResponseProviderImpl;
import io.outright.xj.core.app.server.HttpServerProvider;
import io.outright.xj.core.app.server.HttpServerProviderImpl;
import io.outright.xj.core.app.server.ResourceConfigProvider;
import io.outright.xj.core.app.server.ResourceConfigProviderImpl;
import io.outright.xj.core.dao.AccountDAO;
import io.outright.xj.core.dao.AccountUserDAO;
import io.outright.xj.core.dao.AuthDAO;
import io.outright.xj.core.dao.UserDAO;
import io.outright.xj.core.dao.jooq.AccountDAOImpl;
import io.outright.xj.core.dao.jooq.AccountUserDAOImpl;
import io.outright.xj.core.dao.jooq.AuthDAOImpl;
import io.outright.xj.core.dao.jooq.UserDAOImpl;
import io.outright.xj.core.external.google.GoogleHttpProvider;
import io.outright.xj.core.external.google.GoogleHttpProviderImpl;
import io.outright.xj.core.external.google.GoogleProvider;
import io.outright.xj.core.external.google.GoogleProviderImpl;
import io.outright.xj.core.util.token.TokenGenerator;
import io.outright.xj.core.util.token.TokenGeneratorImpl;

import com.google.api.client.http.HttpTransport;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.jackson2.JacksonFactory;
import com.google.api.client.util.store.DataStoreFactory;
import com.google.api.client.util.store.MemoryDataStoreFactory;
import com.google.inject.AbstractModule;

public class CoreModule extends AbstractModule {
  protected void configure() {
    bind(AccessControlProvider.class).to(AccessControlProviderImpl.class);
    bind(AccessLogFilterProvider.class).to(AccessLogFilterProviderImpl.class);
    bind(AccessTokenAuthFilter.class).to(AccessTokenAuthFilterImpl.class);
    bind(AccountDAO.class).to(AccountDAOImpl.class);
    bind(AccountUserDAO.class).to(AccountUserDAOImpl.class);
    bind(App.class).to(AppImpl.class);
    bind(AuthDAO.class).to(AuthDAOImpl.class);
    bind(DataStoreFactory.class).to(MemoryDataStoreFactory.class);
    bind(GoogleHttpProvider.class).to(GoogleHttpProviderImpl.class);
    bind(GoogleProvider.class).to(GoogleProviderImpl.class);
    bind(HttpResponseProvider.class).to(HttpResponseProviderImpl.class);
    bind(HttpServerProvider.class).to(HttpServerProviderImpl.class);
    bind(HttpTransport.class).to(NetHttpTransport.class);
    bind(JsonFactory.class).to(JacksonFactory.class);
    bind(JsonFactory.class).to(JacksonFactory.class);
    bind(RedisDatabaseProvider.class).to(RedisDatabaseProviderImpl.class);
    bind(ResourceConfigProvider.class).to(ResourceConfigProviderImpl.class);
    bind(SQLDatabaseProvider.class).to(SQLDatabaseProviderImpl.class);
    bind(TokenGenerator.class).to(TokenGeneratorImpl.class);
    bind(UserDAO.class).to(UserDAOImpl.class);
  }
}