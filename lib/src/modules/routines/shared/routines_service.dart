import 'dart:math';

import 'package:flutter/material.dart';
import 'package:prev_ler/src/modules/routines/shared/repositories/routine_repository.dart';
import 'package:prev_ler/src/shared/entities/day_of_week.dart';
import 'package:prev_ler/src/shared/entities/notification.dart';
import 'package:prev_ler/src/shared/entities/routine.dart';
import 'package:prev_ler/src/shared/entities/routine_create_model.dart';
import 'package:prev_ler/src/shared/entities/week_days.dart';
import 'package:prev_ler/src/shared/services/notification_service.dart';
import 'package:prev_ler/src/shared/utils/my_converter.dart';

abstract class RoutinesService {
  Future<List<Routine>> getAll(String patientId);
  Future<Routine> create(RoutineCreateModel model);
  Future<Routine> update(RoutineCreateModel newModel);
  Future<void> delete(Routine routine);
  Future<void> toggleRoutine(Routine routine);
}

class RoutinesServiceImpl extends RoutinesService {
  final IRoutineRepository _repository;
  final FlutterNotificationService _notificationService;

  RoutinesServiceImpl(this._repository, this._notificationService);

  @override
  Future<List<Routine>> getAll(String patientId) async {
    final routines = await _repository.getAllRoutinesByUserId(patientId);
    return routines;
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
  Future<Routine> create(RoutineCreateModel model) async {
    final routine = _routineFromCreateModel(model);
    final newRoutine = await _repository.create(routine);

    final notificationsForSchedule = newRoutine.notifications;
    if (notificationsForSchedule != null) {
      await _scheduleNotifications(notificationsForSchedule);
    }

    return newRoutine;
  }

  @override
  Future<Routine> update(RoutineCreateModel newModel) async {
    final routine = _routineFromCreateModel(newModel);
    final updatedRoutine = await _repository.update(routine);
    return updatedRoutine;
  }

  @override
  Future<void> toggleRoutine(Routine routine) async {
    final notifications = routine.notifications;

    if (routine.active && notifications != null && notifications.isNotEmpty) {
      debugPrint('Scheduling notifications from routine ${routine.routineId}');
      await _scheduleNotifications(notifications);
    }

    if (!routine.active && notifications != null && notifications.isNotEmpty) {
      debugPrint('Turning off notifications from routine ${routine.routineId}');
      await _cancelNotifications(notifications);
    }

    await _repository.update(routine);
  }

  Routine _routineFromCreateModel(RoutineCreateModel model) {
    final selectedDays = model.selectedDays;
    final routineWeekDays = _generateWeekDays(selectedDays);
    final notifications = _generateRoutineCreateModelNotitications(model);

    return Routine(
      routineId: model.routineId,
      userId: model.userId,
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
  }

  List<DayOfWeek?> _generateWeekDays(List<bool> selectedDays) {
    final generatedList = List.generate(selectedDays.length, (index) {
      final isIndexSelected = selectedDays[index];
      return isIndexSelected ? daysOfWeek[index] : null;
    });

    final routineWeekDays = generatedList.where((dw) => dw != null).toList();
    return routineWeekDays;
  }

  List<NotificationData> _generateRoutineCreateModelNotitications(
    RoutineCreateModel model,
  ) {
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
        notificationId: 0,
        routineId: model.routineId,
        exerciseId: exercise.exerciseId,
        title: 'Está na hora de realizar seu exercício!',
        message:
            'O seu exercício ${exercise.name} da sua rotina ${model.title} está te esperando!',
        time: e.toUtc(),
        sent: false,
      );
    });

    return notifications.toList();
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
