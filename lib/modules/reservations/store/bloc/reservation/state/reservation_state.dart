

import 'package:igrejoteca_admin/modules/reservations/data/models/reservation_model.dart';

abstract class ReservationState {}

class LoadingReservationState extends ReservationState{}

class LoadedReservationState extends ReservationState{
  List<ReservationModel> reserves;

  LoadedReservationState({required this.reserves});
}

class ErrorLoadReservationState extends ReservationState{}

class EmptyReservationState extends ReservationState{}

class CreatedLoanState extends ReservationState{
  final ReservationModel reservation;

  CreatedLoanState(this.reservation);
}