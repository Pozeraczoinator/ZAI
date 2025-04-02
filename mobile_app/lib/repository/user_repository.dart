import 'package:logger/logger.dart';
import 'package:sport_plus/models/user/user_dto.dart';
import 'package:sport_plus/services/http/http_client.dart';
import 'package:sport_plus/services/locator.dart';

class UserRepository {
  final HttpClient _client = locator.get<HttpClient>();
  final Logger _logger = locator.get<Logger>();

  Future<UserDto?> getCurrentUser() async {
    const String url = "/api/user/";
    try {
      var response = await _client.dio.get(url);
      return UserDto.fromJson(response.data);
    } catch (e) {
      _logger.e("Błąd na endpoincie $url: $e");
      return null;
    }
  }

  Future<bool> updateUser(UserDto user) async {
    const String url = "/api/user/update";
    try {
      await _client.dio.put(url, data: user.toJson());
      return true;
    } catch (e) {
      _logger.e("Błąd na endpoincie $url: $e");
      return false;
    }
  }
}
