import 'package:gonotter_app/api/model/auth_details.dart';
import 'package:gonotter_app/api/model/note.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;

part 'rest_client.g.dart';

const url = "http://10.0.2.2:8080";
const apiVersion = "1";
const Map<String, dynamic> _headers = {"Content-Type": "application/graphql"};
const Map<String, dynamic> _noAuth = {"NoAuth": true};

@RestApi(baseUrl: "$url/api/v$apiVersion")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @POST("/signIn")
  @Extra(_noAuth)
  Future<AuthDetails> login(@Body() Map<String, dynamic> map);

  @POST("/signUp")
  @Extra(_noAuth)
  Future<String> register(@Body() Map<String, dynamic> map);

  @POST("/")
  @Headers(_headers)
  Future<List<Note>> getNotes(
      @Query("query") String query, @Query("variables") String variables);
}
