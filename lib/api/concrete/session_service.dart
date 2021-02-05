import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gonotter_app/api/model/auth_details.dart';

class SessionService {
  static const _sessionKey = "GONOTTER_SESSION";
  var _storage = FlutterSecureStorage();

  Future<bool> isSessionExists() async =>
    await getSession() != null ? true : false;


  Future<AuthDetails> getSession() async {
    try {
      var detailsJson = await _storage.read(key: _sessionKey);
      var detailsMap = jsonDecode(detailsJson);
      return AuthDetails.fromJson(detailsMap);
    } catch (error) {
      return null;
    }
  }

  setSession(AuthDetails details) async{
    var detailsMap = details.toJson();
    var detailsJson = jsonEncode(detailsMap);
    await _storage.write(key: _sessionKey, value: detailsJson);
  }

  logOut() async{
    await _storage.delete(key: _sessionKey);
  }
}