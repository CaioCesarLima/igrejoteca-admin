import 'package:igrejoteca_admin/modules/reservations/data/models/reservation_model.dart';

abstract class ReservationEvent{}

class LoadReservationEvent extends ReservationEvent{}

class CreateLoan extends ReservationEvent{
  final ReservationModel reservation;

  CreateLoan({required this.reservation});


}