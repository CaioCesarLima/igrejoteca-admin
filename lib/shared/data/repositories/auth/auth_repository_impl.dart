import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:igrejoteca_admin/core/enviroments/enviroment.dart';
import 'package:igrejoteca_admin/core/storage/storage.dart';
import 'package:igrejoteca_admin/core/utils/consts.dart';
import 'package:igrejoteca_admin/core/utils/firebase_notification/firebase_messaging_service.dart';
import 'package:igrejoteca_admin/shared/data/models/auth_payload.dart';
import 'package:igrejoteca_admin/shared/data/repositories/auth/auth_repository.dart';
import 'package:result_dart/result_dart.dart';

class AuthRepositoryImpl implements AuthRepository{
  @override
  Future<Result<AuthPayload, Exception>> login(String email, String password) async {
    try {
      Uri url = getBackendURL(path: "/auth/login");

      http.Response resp = await http
          .post(url, body: {"identifier": email, "password": password});

      if (resp.statusCode == 200) {
        Map<String, dynamic> body = jsonDecode(resp.body);
        AuthPayload payload = AuthPayload.fromJson(body);
        await writeAccessToken(body['token']);
        await saveFirebaseToken();
        return Result.success(payload);
      }
    } catch (e) {
      return Result.failure(Exception(e.toString()));
    }

    return Result.failure(Exception('Ocorreu algum erro!'));
  }

  @override
  Future<Result<AuthPayload, Exception>> signup(String name, String email, String password) async {
    try {
      Uri url = getBackendURL(path: "/auth/signup");

      http.Response resp = await http.post(url, body: {
        "name": name,
        "email": email,
        "password": password
      });

      if (resp.statusCode == 200) {
        Map<String, dynamic> body = jsonDecode(resp.body);
        AuthPayload payload = AuthPayload.fromJson(body);

        await writeAccessToken(body['token']);
        await saveFirebaseToken();
        return Result.success(payload);
      }
    } catch (_) {}

    return Result.failure(Exception('Erro ao realizar o cadastro'));
  }

  Future<void> saveFirebaseToken() async {
  FirebaseMessagingService firebaseMessagingService =
      FirebaseMessagingService();
  String? token = await firebaseMessagingService.getDeviceFirebaseToken();

  if (token != null) {
    try {
      Uri url = getBackendURL(path: "/api/notifications");
      Map<String, String> headers = await Consts.authHeader();

      http.Response resp = await http.post(
        url,
        headers: headers,
        body: jsonEncode({
          'token': token,
        }),
      );
      if (resp.statusCode == 201) {

      }
    } catch (_) {
    }
  }
}

Future<void> deleteFirebaseToken() async {
  FirebaseMessagingService firebaseMessagingService =
      FirebaseMessagingService();
  String? token = await firebaseMessagingService.getDeviceFirebaseToken();


  if (token != null) {
    try {
      Uri url = getBackendURL(path: "/api/notifications");
      Map<String, String> headers = await Consts.authHeader();

      http.Response resp = await http.delete(
        url,
        headers: headers,
      );

      if (resp.statusCode == 201) {

      }
    } catch (_) {}
  }
}
  
}