import 'dart:convert';

import 'package:igrejoteca_admin/core/utils/consts.dart';
import 'package:igrejoteca_admin/modules/notifications/data/notification_repository.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:result_dart/result_dart.dart';

import '../../../core/enviroments/enviroment.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  @override
  Future<Result<bool, Exception>> sendNotifcation(
      {required String message, required String title}) async {
    try {
      Uri url = getBackendURL(path: "/api/send-notification");
      Map<String, String> headers = await Consts.authHeader();

      http.Response resp = await http.post(url,
          headers: headers,
          body: json.encode({"message": message, "title": title}));

      if (resp.statusCode == 201) {
        return Result.success(true);
      } else {
        Logger().i(resp.statusCode);
        Result.failure(Exception("Erro na comunicação"));
      }
    } catch (e) {
      Logger().d(e.toString());
      return Result.failure(Exception(e.toString()));
    }

    return Result.failure(Exception('Ocorreu algum erro!'));
  }
}
