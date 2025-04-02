import 'package:logger/logger.dart';
import 'package:sport_plus/models/details/facility_details.dart';
import 'package:sport_plus/services/http/http_client.dart';
import 'package:sport_plus/services/locator.dart';

class FacilityDetailsRepository {
  final HttpClient _client = locator.get<HttpClient>();
  final Logger _logger = locator.get<Logger>();

  Future<SportFacilityDetails?> getDetails(int id) async {
    String url = "/api/details/${id.toString()}";
    try {
      var response = await _client.dio.get(url);
      return SportFacilityDetails.fromJson(response.data);
    } catch (e) {
      _logger.e("Błąd na endpoincie $url: $e");
      return null;
    }
  }
}
