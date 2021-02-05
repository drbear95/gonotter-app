import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:gonotter_app/api/concrete/api_client.dart';
import 'package:gonotter_app/core/request_status.dart';
import 'package:gonotter_app/pages/register/bloc/register_page_event.dart';
import 'package:gonotter_app/pages/register/bloc/register_page_state.dart';

class RegisterPageBloc extends Bloc<RegisterPageEvent, RegisterPageState> {
  RegisterPageBloc() : super(const RegisterPageState());

  @override
  Stream<RegisterPageState> mapEventToState(RegisterPageEvent event) async* {
    if (event is UsernameChanged) {
      yield _mapUsernameChangedToState(event, state);
    } else if (event is PasswordChanged) {
      yield _mapPasswordChangedToState(event, state);
    } else if (event is EmailChanged) {
      yield _mapEmailChangedToState(event, state);
    } else if (event is RegisterSubmitted) {
      yield* _mapRegisterSubmittedToState(event, state);
    } else if (event is Finish) {
      yield _mapFinishToState(event, state);
    }
  }

  RegisterPageState _mapFinishToState(
    Finish event,
    RegisterPageState state,
  ) {
    return state.copyWith(status: RequestStatus.notStarted());
  }

  RegisterPageState _mapUsernameChangedToState(
    UsernameChanged event,
    RegisterPageState state,
  ) {
    return state.copyWith(username: event.username);
  }

  RegisterPageState _mapPasswordChangedToState(
    PasswordChanged event,
    RegisterPageState state,
  ) {
    return state.copyWith(
      password: event.password,
    );
  }

  RegisterPageState _mapEmailChangedToState(
    EmailChanged event,
    RegisterPageState state,
  ) {
    return state.copyWith(
      email: event.email,
    );
  }

  Stream<RegisterPageState> _mapRegisterSubmittedToState(
    RegisterSubmitted event,
    RegisterPageState state,
  ) async* {
    yield state.copyWith(status: RequestStatus.loading());
    var client = await GetIt.I<ApiClient>().getClient();

    try {
      var result = await client.register({
        "name": state.username,
        "password": state.password,
        "email": state.email
      });

      yield state.copyWith(status: RequestStatus.ok(result));
    } on DioError catch (e) {
      yield state.copyWith(status: RequestStatus.error(e));
    }
  }
}
