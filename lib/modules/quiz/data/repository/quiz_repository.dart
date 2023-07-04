

import 'package:igrejoteca_admin/modules/quiz/data/models/rank_model.dart';
import 'package:result_dart/result_dart.dart';

import '../models/question.dart';

abstract class QuizRepository {
  Future<Result<QuestionModel, Exception>>getQuestion();
  Future<void>setScore();
  Future<Result<List<RankModel>, Exception>>getRank();
}