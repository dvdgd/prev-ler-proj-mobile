import 'package:prev_ler/src/shared/entities/exercise.dart';

class NotificationData {
  int notificationId;
  int routineId;
  int exerciseId;
  String title;
  String message;
  DateTime time;
  bool sent;
  Exercise? exercise;

  NotificationData({
    required this.notificationId,
    required this.routineId,
    required this.exerciseId,
    required this.title,
    required this.message,
    required this.time,
    required this.sent,
    this.exercise,
  });
}
