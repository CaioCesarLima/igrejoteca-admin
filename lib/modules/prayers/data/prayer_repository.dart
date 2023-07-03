
import 'package:result_dart/result_dart.dart';

import 'models/prayer_model.dart';

abstract class PrayerRepository {
  Future<Result<List<PrayerModel>, Exception>> getUserPrayers();
  Future<Result<List<PrayerModel>, Exception>> getAllPrayers();
  Future<bool> createPrayers({required String description,required bool isAnonymous});
}