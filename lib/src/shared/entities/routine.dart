import 'package:flutter/material.dart';
import 'package:prev_ler/src/shared/entities/day_of_week.dart';
import 'package:prev_ler/src/shared/entities/exercise.dart';
import 'package:prev_ler/src/shared/entities/notification.dart';
import 'package:prev_ler/src/shared/entities/week_days.dart';
import 'package:prev_ler/src/shared/utils/my_converter.dart';

class Routine {
  final int idRoutine;
  final int idPatient;
  final String title;
  final String description;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final Duration duration;
  late final bool active;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<Exercise>? exercises;
  final List<DayOfWeek?>? weekdays;
  final List<NotificationData>? notifications;

  Routine({
    this.idRoutine = 0,
    required this.idPatient,
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.active,
    required this.duration,
    this.createdAt,
    this.weekdays,
    this.updatedAt,
    this.exercises,
    this.notifications,
  });

  Routine copyWith({
    int? idRoutine,
    int? idPatient,
    String? title,
    String? description,
    TimeOfDay? startTime,
    TimeOfDay? endTime,
    bool? active,
    Duration? duration,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<Exercise>? exercises,
    List<DayOfWeek?>? weekdays,
    List<NotificationData>? notifications,
  }) {
    return Routine(
      idRoutine: idRoutine ?? this.idRoutine,
      idPatient: idPatient ?? this.idPatient,
      title: title ?? this.title,
      description: description ?? this.description,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      active: active ?? this.active,
      duration: duration ?? this.duration,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      exercises: exercises ?? this.exercises,
      weekdays: weekdays ?? this.weekdays,
      notifications: notifications ?? this.notifications,
    );
  }

  factory Routine.fromMap(Map<String, dynamic> map) {
    final intervals = map['intervalo'].split(':');
    final duration = Duration(
      hours: int.parse(intervals[0]),
      minutes: int.parse(intervals[1]),
      seconds: int.parse(intervals[2]),
    );

    final exercisesMap = map['exercicios'] as List<dynamic>?;
    final List<Exercise> exercises = [];
    if (exercisesMap != null && exercisesMap.isNotEmpty) {
      for (var element in exercisesMap) {
        exercises.add(Exercise.fromMap(element));
      }
    }

    final weekdaysMap = map['rotinaDiaSemanas'] as List<dynamic>?;
    final List<DayOfWeek> weekdays = [];
    if (weekdaysMap != null && weekdaysMap.isNotEmpty) {
      for (var day in weekdaysMap) {
        final dayOfWeek =
            daysOfWeek.firstWhere((dw) => dw.idWeekday == day['idDiaSemana']);
        weekdays.add(dayOfWeek);
      }
    }

    final notificationsMap = map['notificacoes'] as List<dynamic>?;
    final List<NotificationData> notifications = [];
    if (notificationsMap != null && notificationsMap.isNotEmpty) {
      for (var notification in notificationsMap) {
        notifications.add(NotificationData.fromMap(notification));
      }
    }

    return Routine(
      idRoutine: map['idRotina'],
      idPatient: map['idPaciente'],
      title: map['titulo'],
      description: map['descricao'],
      startTime: MyConverter.toTimeOfDay(DateTime.parse(map['horarioInicio'])),
      endTime: MyConverter.toTimeOfDay(DateTime.parse(map['horarioFim'])),
      active: map['ativa'],
      duration: duration,
      exercises: exercises,
      weekdays: weekdays,
      notifications: notifications,
    );
  }

  Map<String, dynamic> toMap() {
    final exercisesMap = exercises?.map((e) {
      final Map<String, dynamic> map = {
        'idRotina': idRoutine,
        'idExercicio': e.idExercise,
      };
      return map;
    }).toList();

    final weekdaysMap = weekdays?.map(
      (e) {
        final Map<String, dynamic> map = {
          'idRotina': idRoutine,
          'idDiaSemana': e?.idWeekday,
        };
        return map;
      },
    ).toList();

    return {
      'idRotina': idRoutine,
      'idPaciente': idPatient,
      'titulo': title,
      'descricao': description,
      'horarioInicio': MyConverter.toDateTime(startTime).toIso8601String(),
      'horarioFim': MyConverter.toDateTime(endTime).toIso8601String(),
      'intervalo': duration.toString(),
      'ativa': active,
      'rotinaExercicios': exercisesMap,
      'rotinaDiaSemanas': weekdaysMap,
      'notificacoes': notifications?.map((e) => e.toMap()).toList(),
    };
  }
}
