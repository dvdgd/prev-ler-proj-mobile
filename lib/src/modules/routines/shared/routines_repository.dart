import 'package:prev_ler/src/shared/entities/exercise.dart';
import 'package:prev_ler/src/shared/entities/notification.dart';
import 'package:prev_ler/src/shared/entities/routine.dart';

class RoutineRespository {
  List<Routine> routines = [];

  Future<Routine> create(Routine routine) {
    routines.add(routine);
    return Future.value(routine);
  }

  Future<void> delete(Routine routine) {
    routines.removeWhere((element) => element.idRoutine == routine.idRoutine);
    return Future.value();
  }

  Future<Routine> update(Routine newRoutine) {
    final index = routines
        .indexWhere((element) => element.idRoutine == newRoutine.idRoutine);

    routines[index] = newRoutine;
    return Future.value(newRoutine);
  }

  Future<List<Routine>> getAllRoutinesByPatientId(int patientId) {
    final patientRoutines =
        routines.where((element) => element.idPatient == patientId);

    return Future.value(patientRoutines.toList());
  }

  Future<List<NotificationData>> getAllNotificationsByPatientId(
    int patientId,
  ) async {
    final routines = await getAllRoutinesByPatientId(patientId);
    final notifications = routines
        .map((e) => e.notifications)
        .expand((e) => e ?? [] as List<NotificationData>)
        .toList();

    return Future.value(notifications);
  }

  Future<List<Exercise>> getActiveExercisesByPatientId(int patientId) async {
    final routines = await getAllRoutinesByPatientId(patientId);

    final activeRoutines = routines.where((e) => e.active);
    final exercises = activeRoutines
        .map((e) => e.exercises)
        .expand((e) => e ?? [] as List<Exercise>)
        .toList();

    return Future.value(exercises);
  }
}
