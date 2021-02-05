import 'package:gonotter_app/core/app_bootstrapper.dart';

import 'application.dart';

class GoNotterApp extends Application {

  @override
  void onCreate() {
    ApplicationBootstrapper().run();
  }

  @override
  void onTerminate() {}
}