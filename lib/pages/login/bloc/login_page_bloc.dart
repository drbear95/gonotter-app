import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:gonotter_app/api/concrete/api_client.dart';
import 'package:gonotter_app/api/concrete/session_service.dart';
import 'package:gonotter_app/core/request_status.dart';

import 'login_page_event.dart';
import 'login_page_state.dart';

class LoginPageBloc extends Bloc<LoginPageEvent, LoginPageState> {
  LoginPageBloc() : super(const LoginPageState());

  @override
  Stream<LoginPageState> mapEventToState(LoginPageEvent event) async* {
    if (event is UsernameChanged) {
      yield _mapUsernameChangedToState(event, state);
    } else if (event is PasswordChanged) {
      yield _mapPasswordChangedToState(event, state);
    } else if (event is LoginSubmitted) {
      yield* _mapRegisterSubmittedToState(event, state);
    } else if (event is Finish) {
      yield _mapFinishToState(event, state);
    }
  }

  LoginPageState _mapFinishToState(
    Finish event,
    LoginPageState state,
  ) {
    return state.copyWith(status: RequestStatus.notStarted());
  }

  LoginPageState _mapUsernameChangedToState(
    UsernameChanged event,
    LoginPageState state,
  ) {
    return state.copyWith(username: event.username);
  }

  LoginPageState _mapPasswordChangedToState(
    PasswordChanged event,
    LoginPageState state,
  ) {
    return state.copyWith(
      password: event.password,
    );
  }

  Stream<LoginPageState> _mapRegisterSubmittedToState(
    LoginSubmitted event,
    LoginPageState state,
  ) async* {
    yield state.copyWith(status: RequestStatus.loading());
    var client = await GetIt.I<ApiClient>().getClient();

    try {
      var result = await client.login({
        "name": state.username,
        "password": state.password
      });

      var sessionService = GetIt.I<SessionService>();
      sessionService.setSession(result);

      yield state.copyWith(status: RequestStatus.ok(result));
    } on DioError catch (e) {
      yield state.copyWith(status: RequestStatus.error(e));
    }
  }
}
