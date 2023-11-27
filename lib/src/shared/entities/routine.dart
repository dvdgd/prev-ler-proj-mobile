import 'package:flutter/material.dart';
import 'package:prev_ler/src/shared/entities/day_of_week.dart';
import 'package:prev_ler/src/shared/entities/exercise.dart';
import 'package:prev_ler/src/shared/entities/notification.dart';

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
}
