import 'package:igrejoteca_admin/modules/emprestimos/data/models/loan_model.dart';

abstract class LoanEvent{}


class GetLoanEvent extends LoanEvent{}

class ReturnLoanEvent extends LoanEvent{
  final LoanModel loan;

  ReturnLoanEvent({required this.loan});
}