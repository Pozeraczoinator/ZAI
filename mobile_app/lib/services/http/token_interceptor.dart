import 'package:dio/dio.dart';
import 'package:sport_plus/services/locator.dart';
import 'package:sport_plus/services/storage_service.dart';

class TokenInterceptor extends Interceptor {
  final StorageService storage = locator.get<StorageService>();

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    String jwt = await storage.getToken() ?? "";
    options.headers.addAll({"Authorization": "Bearer $jwt"});
    return super.onRequest(options, handler);
  }
}
