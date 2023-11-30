import 'dart:math';

import 'package:flutter/material.dart';
import 'package:prev_ler/src/modules/routines/shared/repositories/routine_repository.dart';
import 'package:prev_ler/src/modules/routines/shared/routine_create_model.dart';
import 'package:prev_ler/src/shared/entities/day_of_week.dart';
import 'package:prev_ler/src/shared/entities/notification.dart';
import 'package:prev_ler/src/shared/entities/routine.dart';
import 'package:prev_ler/src/shared/entities/week_days.dart';
import 'package:prev_ler/src/shared/services/notification_service.dart';
import 'package:prev_ler/src/shared/utils/my_converter.dart';

abstract class RoutinesService {
  Future<List<Routine>> getAll(String patientId);
  Future<Routine> create(RoutineCreateModel model);
  Future<void> update(Routine newRoutine);
  Future<void> delete(Routine routine);
  Future<void> toggleRoutine(Routine routine);
}

class RoutinesServiceImpl extends RoutinesService {
  final IRoutineRepository _repository;
  final FlutterNotificationService _notificationService;

  RoutinesServiceImpl(this._repository, this._notificationService);

  @override
  Future<List<Routine>> getAll(String patientId) async {
    final routines = await _repository.getAllRoutinesByPatientId(patientId);
    return routines;
  }

  @override
  Future<Routine> create(RoutineCreateModel model) async {
    final selectedDays = model.selectedDays;
    final routineWeekDays = _generateWeekDays(selectedDays);
    final notifications = _generateRoutineCreateModelNotitications(model);

    final routine = Routine(
      idRoutine: 0,
      idPatient: model.patientId,
      title: model.title,
      description: model.description,
      startTime: model.startTime,
      endTime: model.endTime,
      active: model.active,
      duration: model.duration,
      exercises: model.exercises,
      weekdays: routineWeekDays,
      createdAt: DateTime.now(),
      notifications: notifications.toList(),
    );

    final newRoutine = await _repository.create(routine);

    final notificationsForSchedule = newRoutine.notifications;
    if (notificationsForSchedule != null) {
      await _scheduleNotifications(notificationsForSchedule);
    }

    newRoutine.exercises?.addAll(model.exercises);
    return newRoutine;
  }

  @override
  Future<void> delete(Routine routine) async {
    await _repository.delete(routine);

    final notifications = routine.notifications;
    if (notifications != null && notifications.isNotEmpty) {
      await _cancelNotifications(notifications);
    }
  }

  @override
  Future<void> update(Routine newRoutine) async {
    await _repository.update(newRoutine);
  }

  @override
  Future<void> toggleRoutine(Routine routine) async {
    final notifications = routine.notifications;

    if (routine.active && notifications != null && notifications.isNotEmpty) {
      debugPrint('Scheduling notifications from routine ${routine.idRoutine}');
      await _scheduleNotifications(notifications);
    }

    if (!routine.active && notifications != null && notifications.isNotEmpty) {
      debugPrint('Turning off notifications from routine ${routine.idRoutine}');
      await _cancelNotifications(notifications);
    }

    await _repository.update(routine);
  }

  List<DayOfWeek?> _generateWeekDays(List<bool> selectedDays) {
    final List<DayOfWeek?> routineWeekDays =
        List.generate(selectedDays.length, (index) {
      final isIndexSelected = selectedDays[index];
      if (isIndexSelected) {
        return daysOfWeek[index];
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

  List<NotificationData> _generateRoutineCreateModelNotitications(
      RoutineCreateModel model) {
    final scheduleHours = _getNotificationsHours(
      model.startTime,
      model.endTime,
      model.duration,
    );

    final tzDates = scheduleHours.map(
      (e) => _notificationService.nextInstanceOfWeekdayHour(
        e.weekday,
        e.hour,
        e.minute,
      ),
    );

    final notifications = tzDates.map((e) {
      final exercises = model.exercises;
      int randomIndex = Random().nextInt(exercises.length);
      final exercise = model.exercises[randomIndex];

      return NotificationData(
        idNotification: 0,
        idRoutine: model.routineId,
        idExercise: exercise.exerciseId,
        title: 'Está na hora de realizar seu exercício!',
        message:
            'O seu exercício ${exercise.name} da sua rotina ${model.title} está te esperando!',
        time: e.toUtc(),
        sent: false,
      );
    });

    return notifications.toList();
  }

  Future<void> _scheduleNotifications(
    List<NotificationData> notifications,
  ) async {
    await Future.wait(notifications.map(
      (e) => _notificationService.scheduleNextWeekDayNotification(e),
    ));
  }

  Future<void> _cancelNotifications(
    List<NotificationData> notifications,
  ) async {
    await Future.wait(
      notifications.map((e) => _notificationService.cancelNotification(e)),
    );
  }
}
