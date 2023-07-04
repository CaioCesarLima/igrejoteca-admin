import 'package:igrejoteca_admin/modules/reservations/store/bloc/reservation/atoms/reservation_atoms.dart';
import 'package:rx_notifier/rx_notifier.dart';

class ReservationReducer extends RxReducer {

    ReservationReducer(){
        on(() => [incrementCounter], _increment);
    }

    void _increment(){
        counterState.setValue(counterState.value + 1);
    }
}