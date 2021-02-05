import 'package:json_annotation/json_annotation.dart';
part 'credentials.g.dart';

@JsonSerializable()
class Credentials {
  String username;
  String password;

  Credentials({this.username, this.password});

  factory Credentials.fromJson(Map<String, dynamic> json) => _$CredentialsFromJson(json);
  Map<String, dynamic> toJson() => _$CredentialsToJson(this);
}