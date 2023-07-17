import 'package:flutter/material.dart';
import 'package:prev_ler/src/shared/entities/day_of_week.dart';
import 'package:prev_ler/src/shared/entities/exercise.dart';
import 'package:prev_ler/src/shared/entities/notification.dart';
import 'package:prev_ler/src/shared/utils/my_converter.dart';

class Routine {
  final int idRoutine;
  final int idPatient;
  final String title;
  final String description;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final Duration duration;
  final bool active;
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

  factory Routine.fromMap(Map<String, dynamic> map) {
    final intervals = map['intervalo'].split(':');
    final duration = Duration(
      hours: int.parse(intervals[0]),
      minutes: int.parse(intervals[1]),
      seconds: int.parse(intervals[2]),
    );

    final exercises = map['exercicios']
        ?.map((e) => Exercise.fromMap(e))
        .toList() as List<Exercise>;
    final weekdays = map['rotinaDiaSemanas']
        ?.map((e) => DayOfWeek.fromMap(e))
        .toList() as List<DayOfWeek>;
    final notifications = map['notificacoes']
        ?.map((e) => NotificationData.fromMap(e))
        .toList() as List<NotificationData>;

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
        'idRotina': 0,
        'idExercicio': e.idExercise,
        'exercicio': e.toMap(),
      };
      return map;
    }).toList();

    final weekdaysMap = weekdays?.map(
      (e) {
        final Map<String, dynamic> map = {
          'idRotina': 0,
          'idDiaSemana': e?.idWeekday,
          'diaSemana': e?.toMap(),
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
