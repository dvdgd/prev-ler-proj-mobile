import 'package:prev_ler/src/shared/entities/exercise.dart';

class NotificationData {
  int idNotification;
  int idRoutine;
  int idExercise;
  String title;
  String message;
  DateTime time;
  bool sent;
  Exercise? exercise;

  NotificationData({
    required this.idNotification,
    required this.idRoutine,
    required this.idExercise,
    required this.title,
    required this.message,
    required this.time,
    required this.sent,
    this.exercise,
  });
}
