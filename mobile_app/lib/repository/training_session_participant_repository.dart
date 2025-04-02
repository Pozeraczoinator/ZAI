import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:sport_plus/models/training_session/training_session.dart';
import 'package:sport_plus/services/http/http_client.dart';
import 'package:sport_plus/services/locator.dart';

class TrainingSessionParticipantRepository {
  final HttpClient _client = locator.get<HttpClient>();
  final Logger _logger = locator.get<Logger>();

  Future<List<TrainingSession>?> getUserTrainings() async {
    const String url = "api/training/participant/user/training";
    try {
      Response response = await _client.dio.get(url);
      List<TrainingSession> trainings = [];
      for (var element in response.data ?? []) {
        trainings.add(TrainingSession.fromJson(element));
      }
      return trainings;
    } catch (e) {
      _logger.e("Błąd na endpoincie $url: $e");
      return null;
    }
  }

  Future<bool> joinTraining(int trainingId) async {
    const String url = "api/training/participant/join/";
    try {
      await _client.dio.post("$url$trainingId");
      return true;
    } catch (e) {
      _logger.e("Błąd na endpoincie $url: $e");
      return false;
    }
  }

  Future<bool> leaveTraining(int trainingId) async {
    const String url = "api/training/participant/delete/";
    try {
      await _client.dio.delete("$url$trainingId");
      return true;
    } catch (e) {
      _logger.e("Błąd na endpoincie $url: $e");
      return false;
    }
  }
}
