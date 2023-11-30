import 'package:flutter/material.dart';
import 'package:prev_ler/src/modules/routines/shared/repositories/routine_repository.dart';
import 'package:prev_ler/src/shared/entities/notification.dart';
import 'package:prev_ler/src/shared/entities/routine.dart';

class RoutineHttpRepository implements IRoutineRepository {
  RoutineHttpRepository();

  @override
  Future<Routine> create(Routine routine) async {
    return routine;
  }

  @override
  Future<void> delete(Routine routine) async {
    Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<void> update(Routine newRoutine) async {
    Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<List<Routine>> getAllRoutinesByPatientId(String patientId) async {
    return [
      Routine(
        idPatient: patientId,
        title: "title",
        description: "description",
        startTime: const TimeOfDay(hour: 1, minute: 10),
        endTime: const TimeOfDay(hour: 3, minute: 10),
        duration: const Duration(minutes: 15),
        active: true,
      ),
    ];
  }

  @override
  Future<List<NotificationData>> getAllNotificationsByPatientId(
    int patientId,
  ) async {
    return [
      NotificationData(
        idNotification: 1,
        idRoutine: 1,
        idExercise: 1,
        title: "title",
        message: "teste",
        time: DateTime.now(),
        sent: true,
      )
    ];
  }
}
