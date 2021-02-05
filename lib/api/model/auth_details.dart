import 'package:json_annotation/json_annotation.dart';
part 'auth_details.g.dart';

@JsonSerializable()
class AuthDetails {
  @JsonKey(name:"access_token")
  String accessToken;
  @JsonKey(name:"refresh_token")
  String refreshToken;

  AuthDetails({this.accessToken, this.refreshToken});

  factory AuthDetails.fromJson(Map<String, dynamic> json) => _$AuthDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$AuthDetailsToJson(this);
}