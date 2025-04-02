import 'dart:convert';
import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {
  var storage = const FlutterSecureStorage();

  Future<String?> getToken() async {
    var result = await storage.read(key: "token");
    return result;
  }

  Future<void> addToken(String token) async {
    await storage.write(key: "token", value: token);
    log(token);
  }

  Future<void> removeToken() async {
    await storage.delete(key: "token");
  }

  Map<String, dynamic> _parseToken(String? token) {
    if (token != null) {
      String normalizedSource = base64Url.normalize(token.split(".")[1]);
      return jsonDecode(utf8.decode(base64Url.decode(normalizedSource)));
    }
    return {};
  }

  Future<dynamic> getValueFromToken(String key) async {
    var token = await getToken();
    if (token == null) return null;
    Map<String, dynamic> tokenData = _parseToken(token);
    return tokenData[key];
  }

  Future<bool> isTokenValid() async {
    var exp = await getValueFromToken("exp");
    if (exp is int) {
      if (exp * 1000 - DateTime.now().millisecondsSinceEpoch > 0) {
        return true;
      }
    }
    removeToken();
    return false;
  }
}
