
import 'package:result_dart/result_dart.dart';

abstract class NotificationRepository {
  Future<Result<bool, Exception>> sendNotifcation({required String message, required String title});
}