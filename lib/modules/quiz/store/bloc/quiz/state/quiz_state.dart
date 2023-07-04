import 'package:igrejoteca_admin/modules/quiz/data/models/rank_model.dart';

import '../../../../data/models/question.dart';

abstract class QuizState{}

class LoadingQuizState extends QuizState{}

class LoadedQuizState extends QuizState{
  final QuestionModel question;

  LoadedQuizState(this.question);
}

class CorrectQuizState extends QuizState{}

class EmptyQuizState extends QuizState{}

class LoadedRankState extends QuizState{
  final List<RankModel> ranks;

  LoadedRankState(this.ranks);
}