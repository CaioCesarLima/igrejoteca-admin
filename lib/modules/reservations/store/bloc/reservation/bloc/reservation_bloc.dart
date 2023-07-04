import 'package:bloc/bloc.dart';
import 'package:igrejoteca_admin/modules/reservations/data/models/reservation_model.dart';
import 'package:igrejoteca_admin/modules/reservations/data/repositories/reservation_repository.dart';
import 'package:igrejoteca_admin/modules/reservations/data/repositories/reservation_repository_impl.dart';
import 'package:igrejoteca_admin/modules/reservations/store/bloc/reservation/event/reservation_event.dart';
import 'package:igrejoteca_admin/modules/reservations/store/bloc/reservation/state/reservation_state.dart';
import 'package:result_dart/result_dart.dart';

class ReservationBloc extends Bloc<ReservationEvent, ReservationState> {
  final ReservationRepository _reservationRepository =
      ReservationRepositoryImpl();
  ReservationBloc() : super(EmptyReservationState()) {
    on<LoadReservationEvent>(_loadReservation);
    on<CreateLoan>(_createLoan);
  }

  Future<void> _loadReservation(
      LoadReservationEvent event, Emitter<ReservationState> emit) async {
    emit(LoadingReservationState());
    Result<List<ReservationModel>, Exception> response =
        await _reservationRepository.loadReservations();

    response.fold((success) {
      success.isEmpty
          ? emit(EmptyReservationState())
          : emit(LoadedReservationState(reserves: success));
    }, (failure) => emit(ErrorLoadReservationState()));
  }

  Future<void> _createLoan(
      CreateLoan event, Emitter<ReservationState> emit) async {
    ReservationState currentState = state;
    emit(LoadingReservationState());
    Result<bool, Exception> response = await _reservationRepository.createLoan(
        bookId: event.reservation.book.id, userId: event.reservation.user.id);
    (currentState as LoadedReservationState).reserves.remove(event.reservation);
    
    response.fold((success) {
      success
          ? emit(LoadedReservationState(reserves: currentState.reserves))
          : emit(ErrorLoadReservationState());
    }, (failure) => emit(ErrorLoadReservationState()));
  }
}
