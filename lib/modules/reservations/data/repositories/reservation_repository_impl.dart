
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:igrejoteca_admin/core/enviroments/enviroment.dart';
import 'package:igrejoteca_admin/core/utils/consts.dart';
import 'package:igrejoteca_admin/modules/reservations/data/models/reservation_model.dart';
import 'package:igrejoteca_admin/modules/reservations/data/repositories/reservation_repository.dart';
import 'package:logger/logger.dart';
import 'package:result_dart/result_dart.dart';

class ReservationRepositoryImpl implements ReservationRepository{
  @override
  Future<Result<List<ReservationModel>, Exception>> loadReservations() async {
    try {
      Uri url = getBackendURL(path: "/api/reserves");
      Map<String, String> headers = await Consts.authHeader();

      http.Response resp = await http.get(url, headers: headers);

      if (resp.statusCode == 200) {
        dynamic body = jsonDecode(resp.body);
        List<dynamic> data = body['data'];
        List<ReservationModel>reserves = data.map((e) => ReservationModel.fromjson(e)).toList();
        return Result.success(reserves);
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
  Future<Result<bool, Exception>> createLoan({required String userId, required String bookId}) async {
   try {
      Uri url = getBackendURL(path: "/api/loans");
      Map<String, String> headers = await Consts.authHeader();

      String body = json.encode({
        "book_id": bookId,
        "user_id": userId
      });

      http.Response resp = await http.post(url, headers: headers, body: body);

      if (resp.statusCode == 200) {
        return Result.success(true);
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
  
}