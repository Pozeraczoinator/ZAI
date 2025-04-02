import 'package:logger/logger.dart';
import 'package:sport_plus/models/rating/rating_dto.dart';
import 'package:sport_plus/services/http/http_client.dart';
import 'package:sport_plus/services/locator.dart';

class RatingRepository {
  final HttpClient _client = locator.get<HttpClient>();
  final Logger _logger = locator.get<Logger>();

  Future<bool> addRating(RatingDto rating) async {
    const String url = "/api/rating/add";
    try {
      await _client.dio.post(url, data: rating.toJson());
      return true;
    } catch (e) {
      _logger.e("Błąd na endpoincie $url: $e");
      return false;
    }
  }
}
