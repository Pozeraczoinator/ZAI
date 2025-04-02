import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:sport_plus/models/sport_facility.dart';
import 'package:sport_plus/services/http/http_client.dart';
import 'package:sport_plus/services/locator.dart';

class SportFacilityRepository {
  final HttpClient _client = locator.get<HttpClient>();
  final Logger _logger = locator.get<Logger>();

  Future<List<SportFacility>?> getAllFacilities() async {
    const String url = "/api/sportFacility/all";
    try {
      Response response = await _client.dio.get(url);
      List<SportFacility> facilities = [];
      for (var element in response.data ?? []) {
        facilities.add(SportFacility.fromJson(element));
      }
      return facilities;
    } catch (e) {
      _logger.e("Błąd na endpoincie $url: $e");
      return null;
    }
  }

  Future<List<SportFacility>?> getUserFacilities() async {
    const String url = "/api/participant/facilities";
    try {
      Response response = await _client.dio.get(url);
      List<SportFacility> facilities = [];
      for (var element in response.data ?? []) {
        facilities.add(SportFacility.fromJson(element));
      }
      return facilities;
    } catch (e) {
      _logger.e("Błąd na endpoincie $url: $e");
      return null;
    }
  }
}
