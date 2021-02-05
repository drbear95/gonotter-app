import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:gonotter_app/pages/home/home_page.dart';
import 'package:gonotter_app/pages/login/login_page.dart';
import 'package:gonotter_app/pages/notes/notes_page.dart';
import 'package:gonotter_app/pages/register/register_page.dart';

class Routing {
  static final destinations = {
    Destination.home: "/",
    Destination.login: "/login",
    Destination.register: "/register",
    Destination.notes: "/notes"
  };

  Handler _getHandler(Destination destination){
    switch(destination) {
      case Destination.home:
        return Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) => HomePage());
        break;
      case Destination.login:
        return Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) => LoginPage());
        break;
      case Destination.register:
        return Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) => RegisterPage());
        break;
      case Destination.notes:
        return Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) => NotesPage());
        break;
    }
    throw Exception("Handler not found");
  }

  FluroRouter getRouter() {
    var router = FluroRouter();

    destinations.forEach((destination, path) {
      router.define(path, handler: _getHandler(destination), transitionType: TransitionType.fadeIn);
    });

    return router;
  }
}

enum Destination {
  home, login, register, notes
}