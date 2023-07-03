import 'package:bloc/bloc.dart';
import 'package:igrejoteca_admin/modules/emprestimos/data/loan_repository.dart';
import 'package:igrejoteca_admin/modules/emprestimos/data/loan_repository_impl.dart';
import 'package:igrejoteca_admin/modules/emprestimos/data/models/loan_model.dart';
import 'package:igrejoteca_admin/modules/emprestimos/store/bloc/loan/event/loan_event.dart';
import 'package:igrejoteca_admin/modules/emprestimos/store/bloc/loan/state/loan_state.dart';
import 'package:result_dart/result_dart.dart';

class LoanBloc extends Bloc<LoanEvent, LoanState> {
  LoanRepository loanRepository = LoanRepositoryImpl();
  LoanBloc() : super(EmptyLoanState()) {
    on<GetLoanEvent>(_getLoan);
    on<ReturnLoanEvent>(_returnLoanevent);
  }

  Future<void> _getLoan(GetLoanEvent event, Emitter emit) async {
    emit(LoadingLoanState());
    Result<List<LoanModel>, Exception> result =
        await loanRepository.getUserLoan();
    result.fold((success) => emit(LoadedLoanState(success)),
        (failure) => emit(ErrorLoanState()));
  }

  Future<void> _returnLoanevent(ReturnLoanEvent event, Emitter emit) async {
    LoadedLoanState currentState = state as LoadedLoanState;
    Result<bool, Exception> result =
        await loanRepository.returnLoan(loanId: event.loan.id);
    for (int i = 0; i < currentState.loans.length; i++) {
      if (currentState.loans[i].id == event.loan.id) {
        currentState.loans[i]
            .setReturned(); // Altere a condição conforme necessário
        break; // Encerra o loop após encontrar o empréstimo específico
      }
    }
    currentState.loans.sort((a, b) {
      if (a.returned && !b.returned) {
        return 1; // `a` vem depois de `b`
      } else if (!a.returned && b.returned) {
        return -1; // `a` vem antes de `b`
      } else {
        return 0; // mantém a ordem atual
      }
    });
    result.fold((success) => emit(LoadedLoanState(currentState.loans)),
        (failure) => emit(ErrorLoanState()));
  }
}
