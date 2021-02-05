import 'package:get_it/get_it.dart';
import 'package:gonotter_app/api/concrete/api_client.dart';
import 'package:gonotter_app/api/concrete/session_service.dart';
import 'package:gonotter_app/core/routing.dart';
import 'package:logger/logger.dart';

class ApplicationBootstrapper {
  void run() {
    _initLogger();
    _initRouting();
    _initDI();

    GetIt.I.registerFactory(() => ApiClient());
  }

  void _initDI(){
    GetIt.I.registerLazySingleton(() => SessionService());
  }

  void _initRouting() {
    GetIt.I.registerLazySingleton(() => Routing().getRouter());
  }

  void _initLogger() {
    GetIt.I.registerLazySingleton(() => Logger(printer: PrettyPrinter()));
  }
}
