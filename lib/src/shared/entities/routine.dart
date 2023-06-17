import 'package:prev_ler/src/shared/entities/day_of_week.dart';
import 'package:prev_ler/src/shared/entities/exercise.dart';
import 'package:prev_ler/src/shared/entities/notification.dart';

// TODO: Implement toMap and fromMap methods
class Routine {
  int idRoutine;
  int idPatient;
  String title;
  String description;
  String startTime;
  String endTime;
  bool active;
  DateTime createdAt;
  DateTime? updatedAt;
  List<Exercise>? exercises;
  List<DayOfWeek>? weekdays;
  List<NotificationData>? notifications;

  Routine({
    required this.idRoutine,
    required this.idPatient,
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.active,
    required this.weekdays,
    required this.createdAt,
    this.updatedAt,
    this.exercises,
    this.notifications,
  });
}
