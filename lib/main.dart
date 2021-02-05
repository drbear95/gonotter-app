import 'package:flutter/material.dart';
import 'core/gonotter_app.dart';
import 'pages/app_widget/app_widget.dart';

void main() {
  var application = GoNotterApp();

  application.onCreate();

  runApp(AppWidget(application));
}
