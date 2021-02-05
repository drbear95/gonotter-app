import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'session_service.dart';

class AuthenticationInterceptor extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options) async {
    final _sessionService = GetIt.I<SessionService>();
    final session = await _sessionService.getSession();
    final noAuthKey = "NoAuth";

    if(!options.extra.containsKey(noAuthKey)){
      options.headers["Authentication"] = "Bearer ${session.accessToken}";
    }

    return super.onRequest(options);
  }
}
