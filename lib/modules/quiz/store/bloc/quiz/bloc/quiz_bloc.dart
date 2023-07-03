
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../data/models/question.dart';
import '../../../../data/repository/quiz_repository.dart';
import '../../../../data/repository/quiz_repository_impl.dart';
import '../event/quiz_event.dart';
import '../state/quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final QuizRepository _quizRepository = QuizRepositoryImpl();
  QuizBloc(): super(EmptyQuizState()){
    on<GetQuestionEvent>(_getQuestion);
  }
  
  Future<void> _getQuestion(GetQuestionEvent event, Emitter emit) async{
    emit(LoadingQuizState());
    Result<QuestionModel, Exception> result = await _quizRepository.getQuestion();
    result.fold((success) => emit(LoadedQuizState(success)), (failure) => emit(EmptyQuizState()));
  }
}