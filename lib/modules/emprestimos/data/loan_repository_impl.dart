
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:igrejoteca_admin/core/enviroments/enviroment.dart';
import 'package:igrejoteca_admin/core/utils/consts.dart';
import 'package:igrejoteca_admin/modules/emprestimos/data/loan_repository.dart';
import 'package:igrejoteca_admin/modules/emprestimos/data/models/loan_model.dart';
import 'package:logger/logger.dart';
import 'package:result_dart/result_dart.dart';

class LoanRepositoryImpl implements LoanRepository {
  @override
  Future<Result<List<LoanModel>, Exception>> getUserLoan() async {
     try {
      Uri url = getBackendURL(path: "/api/loan-user");
      Map<String, String> headers = await Consts.authHeader();

      http.Response resp = await http.get(url, headers: headers);

      if (resp.statusCode == 200) {
        dynamic body = jsonDecode(resp.body);
        List<dynamic> data = body['data'];
        List<LoanModel>loans = data.map((e) => LoanModel.fromjson(e)).toList();
        return Result.success(loans);
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