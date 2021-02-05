import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

class RequestStatus<TResult> extends Equatable {
  final TResult result;
  final Exception error;
  final RequestState state;

  const RequestStatus._({
    this.result,
    this.error,
    this.state,
  });

  const RequestStatus.notStarted()
      : this._(state: RequestState.notStarted);

  const RequestStatus.loading()
      : this._(state: RequestState.loading);

  const RequestStatus.error(Exception error)
      : this._(state: RequestState.error, error: error);

  const RequestStatus.ok(TResult result)
      : this._(state: RequestState.ok, result: result);

  @override
  List<Object> get props => [result, error, state];
}

enum RequestState{
  notStarted, loading, error, ok
}