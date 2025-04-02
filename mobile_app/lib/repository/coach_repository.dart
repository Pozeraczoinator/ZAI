import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:sport_plus/models/coach/coach.dart';
import 'package:sport_plus/services/http/http_client.dart';
import 'package:sport_plus/services/locator.dart';

class CoachRepository {
  final HttpClient _client = locator.get<HttpClient>();
  final Logger _logger = locator.get<Logger>();

  Future<List<Coach>?> getCoaches() async {
    String url = "/api/coach/all";
    try {
      Response response = await _client.dio.get(url);
      List<Coach> coaches = [];
      for (var element in response.data) {
        coaches.add(Coach.fromJson(element));
      }
      return coaches;
    } catch (e) {
      _logger.e("Błąd na endpoincie $url: $e");
      return null;
    }
  }
}
