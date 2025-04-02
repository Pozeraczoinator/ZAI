import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sport_plus/services/storage_service.dart';

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  late StorageService storageService;
  late MockFlutterSecureStorage mockStorage;

  const String token = "mockToken";
  const String tokenKey = "token";

  setUp(() {
    mockStorage = MockFlutterSecureStorage();
    storageService = StorageService();
    storageService.storage = mockStorage;
  });

  group('StorageService', () {
    test('getToken zwraca token, jeśli istnieje', () async {
      when(() => mockStorage.read(key: tokenKey))
          .thenAnswer((_) async => token);

      final result = await storageService.getToken();

      expect(result, token);
      verify(() => mockStorage.read(key: tokenKey)).called(1);
    });

    test('addToken zapisuje token w pamięci', () async {
      when(() => mockStorage.write(key: tokenKey, value: token))
          .thenAnswer((_) async => {});
      await storageService.addToken(token);

      verify(() => mockStorage.write(key: tokenKey, value: token)).called(1);
    });

    test('removeToken usuwa token z pamięci', () async {
      when(() => mockStorage.delete(key: tokenKey)).thenAnswer((_) async => {});
      await storageService.removeToken();
      verify(() => mockStorage.delete(key: tokenKey)).called(1);
    });

    test('getValueFromToken zwraca poprawną wartość z tokena', () async {
      const payload = '{"key":"value"}';
      final tokenWithPayload =
          'header.${base64Url.encode(utf8.encode(payload))}.signature';
      when(() => mockStorage.read(key: tokenKey))
          .thenAnswer((_) async => tokenWithPayload);

      final result = await storageService.getValueFromToken("key");

      expect(result, 'value');
      verify(() => mockStorage.read(key: tokenKey)).called(1);
    });

    test('getValueFromToken zwraca null, gdy token jest null', () async {
      when(() => mockStorage.read(key: tokenKey)).thenAnswer((_) async => null);

      final result = await storageService.getValueFromToken("key");

      expect(result, null);
    });

    test('isTokenValid zwraca true dla ważnego tokena', () async {
      final exp = DateTime.now().millisecondsSinceEpoch ~/ 1000 + 3600;
      final payload = '{"exp":$exp}';
      final validToken =
          'header.${base64Url.encode(utf8.encode(payload))}.signature';
      when(() => mockStorage.read(key: tokenKey))
          .thenAnswer((_) async => validToken);

      final result = await storageService.isTokenValid();

      expect(result, true);
    });

    test('isTokenValid usuwa token i zwraca false dla nieważnego tokena',
        () async {
      final exp = DateTime.now().millisecondsSinceEpoch ~/ 1000 - 3600;
      final payload = '{"exp":$exp}';
      final invalidToken =
          'header.${base64Url.encode(utf8.encode(payload))}.signature';
      when(() => mockStorage.read(key: tokenKey))
          .thenAnswer((_) async => invalidToken);
      when(() => mockStorage.delete(key: tokenKey)).thenAnswer((_) async => {});

      final result = await storageService.isTokenValid();

      expect(result, false);
      verify(() => mockStorage.delete(key: tokenKey)).called(1);
    });
  });
}
