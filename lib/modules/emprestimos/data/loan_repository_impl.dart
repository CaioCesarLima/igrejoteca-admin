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
      Uri url = getBackendURL(path: "/api/loans");
      Map<String, String> headers = await Consts.authHeader();

      http.Response resp = await http.get(url, headers: headers);

      if (resp.statusCode == 200) {
        dynamic body = jsonDecode(resp.body);
        List<dynamic> data = body['data'];
        List<LoanModel> loans = data.map((e) => LoanModel.fromjson(e)).toList();
        loans.sort((a, b) {
          if (a.returned && !b.returned) {
            return 1; // `a` vem depois de `b`
          } else if (!a.returned && b.returned) {
            return -1; // `a` vem antes de `b`
          } else {
            return 0; // mantém a ordem atual
          }
        });
        return Result.success(loans);
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
  
  @override
  Future<Result<bool, Exception>> returnLoan({required String loanId}) async {
    try {
      Uri url = getBackendURL(path: "/api/loans/$loanId");
      Map<String, String> headers = await Consts.authHeader();

      http.Response resp = await http.delete(url, headers: headers);

      if (resp.statusCode == 200) {
        
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
