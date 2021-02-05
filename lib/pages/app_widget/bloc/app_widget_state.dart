import 'package:equatable/equatable.dart';

abstract class AppWidgetState extends Equatable {
  const AppWidgetState();
}

class AuthenticationState extends AppWidgetState {
  final AuthenticationStatus status;

  const AuthenticationState._({
    this.status = AuthenticationStatus.unknown
  }): super();

  const AuthenticationState.authenticated()
      : this._(status: AuthenticationStatus.authenticated);

  const AuthenticationState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);

  const AuthenticationState.unknown()
      : this._(status: AuthenticationStatus.unknown);

  @override
  List<Object> get props => [status];
}

enum AuthenticationStatus { unknown, authenticated, unauthenticated }
