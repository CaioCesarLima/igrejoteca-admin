
import 'package:result_dart/result_dart.dart';

import 'models/testemonie_model.dart';

abstract class TestemoniesRepository {
  Future<Result<List<TestemonieModel>, Exception>> getTestimonies();
  Future<bool> createTestimony({required String description});
}