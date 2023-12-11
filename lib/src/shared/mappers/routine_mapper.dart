import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prev_ler/src/shared/entities/day_of_week.dart';
import 'package:prev_ler/src/shared/entities/notification.dart';
import 'package:prev_ler/src/shared/entities/routine.dart';
import 'package:prev_ler/src/shared/entities/week_days.dart';
import 'package:prev_ler/src/shared/mappers/exercise_mapper.dart';
import 'package:prev_ler/src/shared/mappers/notification_mapper.dart';
import 'package:prev_ler/src/shared/utils/my_converter.dart';

Map<String, dynamic> routineToSupabase(Routine routine) {
  final routineMap = {
    'id_usuario': routine.userId,
    'titulo': routine.title,
    'descricao': routine.description,
    'hora_inicio': formatTimeOfDay(routine.startTime),
    'hora_fim': formatTimeOfDay(routine.endTime),
    'intervalo': routine.duration.toString(),
    'ativa': routine.active,
    'dias_semana': routine.weekdays?.map((e) => e?.enumName).toList(),
  };

  if (routine.routineId != 0) {
    routineMap['id_rotina'] = routine.routineId;
  }

  return routineMap;
}

Routine routineFromSupabase(Map<String, dynamic> routine) {
  final routineExercisesMap = routine['rotina_exercicio'] as List<dynamic>;
  final exercises = routineExercisesMap
      .map((e) => exerciseFromSupabase(e['exercicio']))
      .toList();

  final weekDaysMap = routine['dias_semana'] as List<dynamic>;
  final List<DayOfWeek> weekDays = weekDaysMap
      .map((dw) => daysOfWeek.firstWhere((dow) => dow.enumName == dw))
      .toList();

  final notificationsMap = routine['notificacao'] as List<dynamic>;
  final List<NotificationData> notifications = notificationsMap
      .map(
        (n) => notificationDataFromSupabase(n),
      )
      .toList();

  return Routine(
    routineId: routine['id_rotina'],
    userId: routine['id_usuario'],
    title: routine['titulo'],
    description: routine['descricao'],
    startTime: getTimeOfDayFromString(routine['hora_inicio']),
    endTime: getTimeOfDayFromString(routine['hora_fim']),
    duration: getDurationFromString(routine['intervalo']),
    active: routine['ativa'],
    exercises: exercises,
    weekdays: weekDays,
    notifications: notifications,
  );
}

TimeOfDay getTimeOfDayFromString(String timeOfDayStr) {
  final timeValues = timeOfDayStr.split(':');
  final hour = int.parse(timeValues.elementAt(0));
  final minutes = int.parse(timeValues.elementAt(1));

  return TimeOfDay(hour: hour, minute: minutes);
}

Duration getDurationFromString(String duration) {
  final timeValues = duration.split(':');
  final hour = int.parse(timeValues.elementAt(0));
  final minutes = int.parse(timeValues.elementAt(1));
  final seconds = int.parse(timeValues.elementAt(2));

  return Duration(hours: hour, minutes: minutes, seconds: seconds);
}

String formatTimeOfDay(TimeOfDay timeOfDay) {
  final date = MyConverter.toDateTime(timeOfDay);
  return DateFormat.Hms().format(date);
}
