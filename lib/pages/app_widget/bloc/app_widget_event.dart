import 'package:equatable/equatable.dart';
import 'package:gonotter_app/pages/app_widget/bloc/app_widget_state.dart';


class AppWidgetEvent extends Equatable {

  const AppWidgetEvent();

  @override
  List<Object> get props =>[];
}

class AppLoaded extends AppWidgetEvent{}

class AuthenticationStatusChanged extends AppWidgetEvent {
  final AuthenticationStatus status;

  const AuthenticationStatusChanged(this.status): super();

  @override
  List<Object> get props => [status];
}

class AuthenticationLogoutRequested extends AppWidgetEvent {}