import 'package:hive_flutter/adapters.dart';
import 'package:prev_ler/src/modules/routines/shared/repositories/routine_repository.dart';
import 'package:prev_ler/src/shared/database/hive/routine_model_database.dart';
import 'package:prev_ler/src/shared/entities/exercise.dart';
import 'package:prev_ler/src/shared/entities/notification.dart';
import 'package:prev_ler/src/shared/entities/routine.dart';
import 'package:uuid/uuid.dart';

class RoutineHiveRepository implements IRoutineRepository {
  final Box<RoutineModelDatabase> box;
  final uuid = const Uuid();

  RoutineHiveRepository(this.box);

  @override
  Future<Routine> create(Routine routine) async {
    final data = RoutineModelDatabase(routine.title, routine.toMap());
    await box.put(routine.title, data);

    return routine;
  }

  @override
  Future<Routine> update(Routine newRoutine) async {
    await create(newRoutine);
    return newRoutine;
  }

  @override
  Future<void> delete(Routine routine) async {
    await box.delete(routine.title);
  }

  @override
  Future<List<Routine>> getAllRoutinesByPatientId(int patientId) {
    final list = box.values.cast().toList();

    final routines = list
        .map((e) => Routine.fromMap(e.routine))
        .where((element) => element.idPatient == patientId)
        .toList();

    return Future.value(routines);
  }

  @override
  Future<List<Exercise?>> getActiveExercisesByPatientId(int patientId) async {
    final routines = await getAllRoutinesByPatientId(patientId);

    final activeExercises = routines
        .where((e) => e.active)
        .map((e) => e.exercises)
        .expand((e) => e ?? [] as List<Exercise>)
        .toList();

    return activeExercises;
  }

  @override
  Future<List<NotificationData>> getAllNotificationsByPatientId(
      int patientId) async {
    final routines = await getAllRoutinesByPatientId(patientId);

    final notifications = routines
        .map((e) => e.notifications)
        .expand((e) => e ?? [] as List<NotificationData>)
        .toList();

    return notifications;
  }
}
