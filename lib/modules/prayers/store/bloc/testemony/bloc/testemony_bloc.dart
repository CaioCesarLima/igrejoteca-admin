import 'package:bloc/bloc.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../data/models/testemonie_model.dart';
import '../../../../data/testemonies_repository_impl.dart';
import '../../../../data/tetemonies_repository.dart';
import '../event/testemony_event.dart';
import '../state/testemony_state.dart';

class TestemonyBloc extends Bloc<TestemonieEvent, TestemonyState>{
  TestemoniesRepository testemoniesRepository = TestemoniesRepositoryImpl();
  TestemonyBloc(): super(EmptyTestemonyState()){
    on<GetAllTestemonieEvent>(_getAllTestemonies);
  }


  Future<void> _getAllTestemonies(GetAllTestemonieEvent event, Emitter emit) async{
    emit(LoadingTestemonyState());
    Result<List<TestemonieModel>, Exception> result = await testemoniesRepository.getTestimonies();
    result.fold((success) => emit(LoadedTestemonyState(success)), (failure) => emit(ErrorTestemonyState()));
  }
}