import 'package:equatable/equatable.dart';
import 'package:gonotter_app/api/model/auth_details.dart';
import 'package:gonotter_app/core/request_status.dart';

class LoginPageState extends Equatable {
  final RequestStatus<AuthDetails> status;
  final String username;
  final String password;

  const LoginPageState({
    this.status = const RequestStatus.notStarted(),
    this.username = "",
    this.password = "",
  });

  LoginPageState copyWith({
    RequestStatus<AuthDetails> status,
    String username,
    String password,
  }) {
    return LoginPageState(
      status: status ?? this.status,
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  @override
  List<Object> get props => [status, username, password];
}