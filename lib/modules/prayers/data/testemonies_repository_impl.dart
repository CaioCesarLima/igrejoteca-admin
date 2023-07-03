
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:result_dart/result_dart.dart';

import '../../../core/enviroments/enviroment.dart';
import '../../../core/utils/consts.dart';
import 'models/testemonie_model.dart';
import 'tetemonies_repository.dart';

class TestemoniesRepositoryImpl implements TestemoniesRepository {
  @override
  Future<Result<List<TestemonieModel>, Exception>> getTestimonies() async {
     try {
      Uri url = getBackendURL(path: "/api/testimonials");
      Map<String, String> headers = await Consts.authHeader();

      http.Response resp = await http.get(url, headers: headers);

      if (resp.statusCode == 200) {
        dynamic body = jsonDecode(resp.body);
        List<dynamic> data = body['data'];
        List<TestemonieModel>testemonies = data.map((e) => TestemonieModel.fromjson(e)).toList().reversed.toList();
        return Result.success(testemonies);
      }else {
        Logger().i(resp.statusCode);
        Result.failure(Exception("Erro na comunicação"));
      }
    } catch (e) {
      Logger().d(e.toString());
      return Result.failure(Exception(e.toString()));
    }

    return Result.failure(Exception('Ocorreu algum erro!'));
  }
  
  @override
  Future<bool> createTestimony({required String description}) async {
    try {
      Uri url = getBackendURL(path: "/api/testimonials");

      Map<String, String> headers = await Consts.authHeader();
      Map<String, dynamic> body = {
        "description": description,
      };
      http.Response resp = await http.post(url, body: jsonEncode(body), headers: headers);

      if (resp.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (_) {
    }

    return false;
  }
}