import 'package:igrejoteca_admin/modules/emprestimos/data/models/loan_model.dart';

abstract class LoanState{}

class LoadingLoanState extends LoanState{}

class LoadedLoanState extends LoanState{
  final List<LoanModel> loans;

  LoadedLoanState(this.loans);
}

class ErrorLoanState extends LoanState{}

class EmptyLoanState extends LoanState{}

class ReturnedLoanState extends LoanState{}
