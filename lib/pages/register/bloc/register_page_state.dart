import 'package:equatable/equatable.dart';
import 'package:gonotter_app/core/request_status.dart';

class RegisterPageState extends Equatable {
  final RequestStatus<String> status;
  final String username;
  final String password;
  final String email;

  const RegisterPageState({
    this.status = const RequestStatus.notStarted(),
    this.username = "",
    this.password = "",
    this.email = ""
  });

  RegisterPageState copyWith({
    RequestStatus<String> status,
    String username,
    String password,
    String email,
  }) {
    return RegisterPageState(
      status: status ?? this.status,
      username: username ?? this.username,
      password: password ?? this.password,
      email: email ?? this.email,
    );
  }

  @override
  List<Object> get props => [status, username, password, email];
}