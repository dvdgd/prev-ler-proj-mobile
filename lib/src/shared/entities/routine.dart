import 'package:flutter/material.dart';
import 'package:prev_ler/src/shared/entities/day_of_week.dart';
import 'package:prev_ler/src/shared/entities/exercise.dart';
import 'package:prev_ler/src/shared/entities/notification.dart';

class Routine {
  final int routineId;
  final String userId;
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
    this.routineId = 0,
    required this.userId,
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
    String? idPatient,
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
      routineId: idRoutine ?? routineId,
      userId: idPatient ?? userId,
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
