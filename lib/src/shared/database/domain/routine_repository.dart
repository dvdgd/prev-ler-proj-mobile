import 'package:prev_ler/src/shared/entities/exercise.dart';
import 'package:prev_ler/src/shared/entities/notification.dart';
import 'package:prev_ler/src/shared/entities/routine.dart';

abstract class IRoutineRepository {
  Future<Routine> create(Routine routine);
  Future<void> delete(Routine routine);
  Future<List<Exercise?>> getActiveExercisesByPatientId(int patientId);
  Future<List<NotificationData>> getAllNotificationsByPatientId(int patientId);
  Future<List<Routine>> getAllRoutinesByPatientId(int patientId);
  Future<Routine> update(Routine newRoutine);
}
