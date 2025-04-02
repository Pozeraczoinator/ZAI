import 'dart:async';

import 'package:logger/logger.dart';
import 'package:sport_plus/models/auth/login_user_dto.dart';
import 'package:sport_plus/models/auth/register_user_dto.dart';
import 'package:sport_plus/services/http/http_client.dart';
import 'package:sport_plus/services/locator.dart';
import 'package:sport_plus/services/storage_service.dart';

enum AuthenticationStatus { authenticated, unauthenticated, unknown }

class AuthRepository {
  final HttpClient _client = locator.get<HttpClient>();
  final Logger _logger = locator.get<Logger>();
  final StorageService storageService = locator.get<StorageService>();

  final StreamController<AuthenticationStatus>? controller =
      StreamController<AuthenticationStatus>.broadcast();

  Stream<AuthenticationStatus> get status async* {
    var contr = controller;
    if (contr != null) {
      yield* contr.stream;
    }
  }

  Future<String?> registerUser(RegisterUserDto user) async {
    const String url = "/auth/signup";
    try {
      var response = await _client.dio.post(url, data: user.toJson());
      return response.data["token"];
    } catch (e) {
      _logger.e("Błąd na endpoincie $url: $e");
      return null;
    }
  }

  Future<String?> logIn(LoginUserDto user) async {
    const String url = "auth/login";
    try {
      var response = await _client.dio.post(url, data: user.toJson());
      return response.data["token"];
    } catch (e) {
      _logger.e("Błąd na endpoincie $url: $e");
      return null;
    }
  }

  Future<void> logOut() async {
    await storageService.removeToken();
    controller?.add(AuthenticationStatus.unauthenticated);
  }
}
