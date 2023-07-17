import 'dart:math';

import 'package:flutter/material.dart';
import 'package:prev_ler/src/modules/routines/shared/repositories/routine_repository.dart';
import 'package:prev_ler/src/modules/routines/shared/routine_create_model.dart';
import 'package:prev_ler/src/shared/entities/day_of_week.dart';
import 'package:prev_ler/src/shared/entities/notification.dart';
import 'package:prev_ler/src/shared/entities/routine.dart';
import 'package:prev_ler/src/shared/entities/week_days.dart';
import 'package:prev_ler/src/shared/http/client_http.dart';
import 'package:prev_ler/src/shared/services/notification_service.dart';
import 'package:prev_ler/src/shared/utils/my_converter.dart';

abstract class RoutinesService {
  Future<List<Routine>> getAll(int patientId);
  Future<Routine> create(RoutineCreateModel newRoutine);
  Future<void> update(Routine newRoutine);
  Future<void> delete(Routine routine);
}

class RoutinesServiceImpl extends RoutinesService {
  final ClientHttp clientHttp;
  final IRoutineRepository repository;
  final NotificationService notificationService;

  RoutinesServiceImpl(
      this.clientHttp, this.repository, this.notificationService);

  @override
  Future<List<Routine>> getAll(int patientId) async {
    final routines = await repository.getAllRoutinesByPatientId(patientId);
    return routines;
  }

  List<DayOfWeek?> _generateWeekDays(List<bool> selectedDays) {
    final List<DayOfWeek?> routineWeekDays =
        List.generate(selectedDays.length, (index) {
      final isIndexSelected = selectedDays[index];
      if (isIndexSelected) {
        return weekDays[index];
      }
      return null;
    }).where((element) => element != null).toList();

    return routineWeekDays;
  }

  List<DateTime> _getNotificationsHours(
    TimeOfDay startTime,
    TimeOfDay endTime,
    Duration intervalDuration,
  ) {
    DateTime timeIncrementor = MyConverter.toDateTime(startTime);
    final finishTime = MyConverter.toDateTime(endTime);

    final List<DateTime> notificationsHours = [];

    while (timeIncrementor.add(intervalDuration).isBefore(finishTime)) {
      notificationsHours.add(timeIncrementor);
      timeIncrementor = timeIncrementor.add(intervalDuration);
    }

    return notificationsHours;
  }

  @override
  Future<Routine> create(RoutineCreateModel newRoutine) async {
    final selectedDays = newRoutine.selectedDays;

    final routineWeekDays = _generateWeekDays(selectedDays);
    final scheduleHours = _getNotificationsHours(
      newRoutine.startTime,
      newRoutine.endTime,
      newRoutine.duration,
    );

    final tzDates = scheduleHours.map(
      (e) => notificationService.nextInstanceOfWeekdayHour(
        e.weekday,
        e.hour,
        e.minute,
      ),
    );

    final notifications = tzDates.map((e) {
      final exercises = newRoutine.exercises;
      int randomIndex = Random().nextInt(exercises.length);
      final exercise = newRoutine.exercises[randomIndex];

      return NotificationData(
        idNotification: 0,
        idRoutine: newRoutine.routineId,
        idExercise: exercise.idExercise,
        title: 'Está na hora de realizar seu exercício!',
        message:
            'O seu exercício ${exercise.name} da sua rotina ${newRoutine.title} está te esperando!',
        time: e.toUtc(),
        sent: false,
      );
    });

    final model = Routine(
      idRoutine: 0,
      idPatient: newRoutine.patientId,
      title: newRoutine.title,
      description: newRoutine.description,
      startTime: newRoutine.startTime,
      endTime: newRoutine.endTime,
      active: newRoutine.active,
      duration: newRoutine.duration,
      exercises: newRoutine.exercises,
      weekdays: routineWeekDays,
      createdAt: DateTime.now(),
      notifications: notifications.toList(),
    );

    final routine = await repository.create(model);

    final notificationsForSchedule = routine.notifications;
    if (notificationsForSchedule != null) {
      await Future.wait(
        notificationsForSchedule.map(
          (e) => notificationService.scheduleNextWeekDayNotification(e),
        ),
      );
    }

    return routine;
  }

  @override
  Future<void> delete(Routine routine) async {
    await repository.delete(routine);
  }

  @override
  Future<void> update(Routine newRoutine) async {}
}
