import 'package:dio/dio.dart';
import 'package:gonotter_app/api/concrete/auth_interceptor.dart';
import 'package:gonotter_app/api/concrete/rest_client.dart';

class ApiClient {
  Future<RestClient> getClient() async {
    final dio = Dio();
    dio.interceptors.add(LogInterceptor(responseBody: false));
    dio.interceptors.add(AuthenticationInterceptor());
    return RestClient(dio);
  }
}
