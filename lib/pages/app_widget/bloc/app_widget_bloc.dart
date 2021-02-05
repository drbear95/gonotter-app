import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:gonotter_app/api/concrete/session_service.dart';
import 'package:gonotter_app/pages/app_widget/bloc/app_widget_event.dart';
import 'package:gonotter_app/pages/app_widget/bloc/app_widget_state.dart';

class AppWidgetBloc extends Bloc<AppWidgetEvent, AppWidgetState> {
  AppWidgetBloc() : super(const AuthenticationState.unknown());

  final sessionService = GetIt.I<SessionService>();

  @override
  Stream<AppWidgetState> mapEventToState(AppWidgetEvent event) async* {
    if (event is AppLoaded) {
      yield await _mapAuthenticationStatusChangedToState();
    }
  }

  Future<AuthenticationState> _mapAuthenticationStatusChangedToState() async {
    final user = await sessionService.isSessionExists();

    return user != null
        ? AuthenticationState.authenticated()
        : const AuthenticationState.unauthenticated();
  }
}
