import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:sport_plus/models/sport_facility_news.dart';
import 'package:sport_plus/services/http/http_client.dart';
import 'package:sport_plus/services/locator.dart';

class NewsRepository {
  final HttpClient _client = locator.get<HttpClient>();
  final Logger _logger = locator.get<Logger>();

  Future<List<SportFacilityNews>?> getAllNews() async {
    String url = "/api/SportFacilityNews/";
    try {
      Response response = await _client.dio.get(url);
      List<SportFacilityNews> news = [];
      for (var element in response.data) {
        news.add(SportFacilityNews.fromJson(element));
      }
      return news;
    } catch (e) {
      _logger.e("Błąd na endpoincie $url: $e");
      return null;
    }
  }
}
