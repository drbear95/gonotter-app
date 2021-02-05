import 'dart:async';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:gonotter_app/api/concrete/auth_interceptor.dart';
import 'package:gonotter_app/api/concrete/rest_client.dart';
import 'package:gonotter_app/api/concrete/session_service.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ApiClient {
  Future<RestClient> getClient() async {
    final dio = Dio();
    dio.interceptors.add(LogInterceptor(responseBody: false));
    dio.interceptors.add(AuthenticationInterceptor());
    return RestClient(dio);
  }

  Future<GraphQLClient> getGraphQLClient() async {
    final HttpLink _httpLink = HttpLink(uri: "http://10.0.2.2:8080/api/v1");

    final AuthLink _authLink = AuthLink(
      // ignore: undefined_identifier
      getToken: () async {
        final _sessionService = GetIt.I<SessionService>();
        final session = await _sessionService.getSession();
        return "Bearer ${session.accessToken}";
      }
    );

    final Link _link = _authLink.concat(_httpLink);

    return GraphQLClient(
      cache: InMemoryCache(),
      link: _link,
    );
  }
}
