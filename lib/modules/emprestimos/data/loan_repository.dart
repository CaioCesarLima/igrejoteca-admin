
import 'package:igrejoteca_admin/modules/emprestimos/data/models/loan_model.dart';
import 'package:result_dart/result_dart.dart';

abstract class LoanRepository {
  Future<Result<List<LoanModel>, Exception>> getUserLoan();
}