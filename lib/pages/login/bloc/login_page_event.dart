import 'package:equatable/equatable.dart';
import 'package:gonotter_app/core/request_status.dart';

class LoginPageEvent extends Equatable {
  const LoginPageEvent();

  @override
  List<Object> get props =>[];
}

class RequestStatusChanged extends LoginPageEvent {
  final RequestStatus<String> status;

  const RequestStatusChanged(this.status): super();

  @override
  List<Object> get props => [status];
}

class UsernameChanged extends LoginPageEvent {
  const UsernameChanged(this.username);

  final String username;

  @override
  List<Object> get props => [username];
}

class PasswordChanged extends LoginPageEvent {
  const PasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

class LoginSubmitted extends LoginPageEvent {
  const LoginSubmitted();
}

class Finish extends LoginPageEvent {
  const Finish();
}