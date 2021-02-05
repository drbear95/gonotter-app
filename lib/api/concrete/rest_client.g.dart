// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rest_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _RestClient implements RestClient {
  _RestClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'http://10.0.2.2:8080/api/v1';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<AuthDetails> login(query) async {
    ArgumentError.checkNotNull(query, 'query');
    const _extra = <String, dynamic>{'NoAuth': true};
    final queryParameters = <String, dynamic>{};
    final _data = query;
    final _result = await _dio.request<Map<String, dynamic>>('/signIn',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = AuthDetails.fromJson(_result.data);
    return value;
  }

  @override
  Future<String> register(query) async {
    ArgumentError.checkNotNull(query, 'query');
    const _extra = <String, dynamic>{'NoAuth': true};
    final queryParameters = <String, dynamic>{};
    final _data = query;
    final _result = await _dio.request<String>('/signUp',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = _result.data;
    return value;
  }

  @override
  Future<List<Note>> getNotes(query, variables) async {
    ArgumentError.checkNotNull(query, 'query');
    ArgumentError.checkNotNull(variables, 'variables');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'query': query,
      r'variables': variables
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<List<dynamic>>('/',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{r'Content-Type': 'application/graphql'},
            extra: _extra,
            contentType: 'application/graphql',
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => Note.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }
}
