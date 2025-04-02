import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:logger/logger.dart';
import 'package:sport_plus/config/app_consts.dart';
import 'package:sport_plus/services/locator.dart';
import 'package:sport_plus/services/storage_service.dart';

class FileRepository {
  final Logger _logger = locator.get<Logger>();
  final StorageService _storage = locator.get<StorageService>();

  Future<String?> uploadImage(File file) async {
    const String url = "${AppConsts.apiUrl}api/resource/picture";

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers['Authorization'] = 'Bearer ${await _storage.getToken()}';

    String mimeType = '';
    String fileExtension = extension(file.path).toLowerCase();
    if (fileExtension == '.jpeg' || fileExtension == '.jpg') {
      mimeType = 'image/jpeg';
    } else if (fileExtension == '.png') {
      mimeType = 'image/png';
    } else {
      _logger.e('Nieobsługiwany typ pliku: $fileExtension');
      return null;
    }

    request.files.add(await http.MultipartFile.fromPath(
      'file',
      file.path,
      contentType: MediaType('image', mimeType.split('/').last),
    ));

    try {
      var response = await request.send();

      var responseBody = await http.Response.fromStream(response);

      if (response.statusCode == 200) {
        return responseBody.body;
      } else {
        _logger
            .e('Błąd podczas wysyłania pliku. Status: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      _logger.e('Wystąpił błąd podczas uploadu pliku: $e');
      return null;
    }
  }
}
