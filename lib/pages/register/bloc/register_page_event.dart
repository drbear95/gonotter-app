import 'package:equatable/equatable.dart';
import 'package:gonotter_app/core/request_status.dart';

class RegisterPageEvent extends Equatable {
  const RegisterPageEvent();

  @override
  List<Object> get props =>[];
}

class RequestStatusChanged extends RegisterPageEvent {
  final RequestStatus<String> status;

  const RequestStatusChanged(this.status): super();

  @override
  List<Object> get props => [status];
}

class UsernameChanged extends RegisterPageEvent {
  const UsernameChanged(this.username);

  final String username;

  @override
  List<Object> get props => [username];
}

class EmailChanged extends RegisterPageEvent {
  const EmailChanged(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

class PasswordChanged extends RegisterPageEvent {
  const PasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

class RegisterSubmitted extends RegisterPageEvent {
  const RegisterSubmitted();
}

class Finish extends RegisterPageEvent {
  const Finish();
}