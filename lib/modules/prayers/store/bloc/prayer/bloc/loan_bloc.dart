import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../data/models/prayer_model.dart';
import '../../../../data/prayer_repository.dart';
import '../../../../data/prayer_repository_impl.dart';
import '../event/prayer_event.dart';
import '../state/prayer_state.dart';

class PrayerBloc extends Bloc<PrayerEvent, PrayerState>{
  PrayerRepository loanRepository = PrayerRepositoryImpl();
  PrayerBloc(): super(EmptyPrayerState()){
    on<GetUserPrayersEvent>(_getUserPrayer);
    on<GetAllPrayersEvent>(_getAllPrayer);
  }


  Future<void> _getUserPrayer(GetUserPrayersEvent event, Emitter emit) async{
    emit(LoadingPrayerState());
    Result<List<PrayerModel>, Exception> result = await loanRepository.getUserPrayers();
    result.fold((success) => emit(LoadedPrayerState(success)), (failure) => emit(ErrorPrayerState()));
  }

  Future<FutureOr<void>> _getAllPrayer(GetAllPrayersEvent event, Emitter<PrayerState> emit) async {
    emit(LoadingPrayerState());
    Result<List<PrayerModel>, Exception> result = await loanRepository.getAllPrayers();
    result.fold((success) => emit(LoadedPrayerState(success)), (failure) => emit(ErrorPrayerState()));
  }
}