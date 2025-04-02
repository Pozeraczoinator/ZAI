import 'dart:async';

import 'package:dio/dio.dart';
import 'package:sport_plus/repository/auth_repository.dart';
import 'package:sport_plus/services/locator.dart';

class StatusInterceptor extends Interceptor {
  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    var response = await checkStatusAndHandle(err.response);
    if (response != null) handler.resolve(response);
    return response ?? handler.next(err);
  }

  Future<Response<dynamic>?> checkStatusAndHandle(
      Response<dynamic>? response) async {
    if (response == null) return null;

    if (response.statusCode != null) {
      if (response.statusCode == 401) {
        await locator.get<AuthRepository>().logOut();
      }
    }
    return null;
  }
}
