// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthDetails _$AuthDetailsFromJson(Map<String, dynamic> json) {
  return AuthDetails(
    accessToken: json['access_token'] as String,
    refreshToken: json['refresh_token'] as String,
  );
}

Map<String, dynamic> _$AuthDetailsToJson(AuthDetails instance) =>
    <String, dynamic>{
      'access_token': instance.accessToken,
      'refresh_token': instance.refreshToken,
    };
