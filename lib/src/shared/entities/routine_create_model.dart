import 'package:flutter/material.dart';
import 'package:prev_ler/src/shared/entities/day_of_week.dart';
import 'package:prev_ler/src/shared/entities/exercise.dart';
import 'package:prev_ler/src/shared/entities/routine.dart';
import 'package:prev_ler/src/shared/entities/week_days.dart';

class RoutineCreateModel {
  int routineId;
  String userId;
  String title;
  String description;
  TimeOfDay startTime;
  TimeOfDay endTime;
  Duration duration;
  bool active;
  List<Exercise> exercises;
  List<bool> selectedDays;

  RoutineCreateModel({
    this.routineId = 0,
    required this.userId,
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.duration,
    required this.active,
    required this.exercises,
    required this.selectedDays,
  });

  Routine toRoutine() {
    final List<DayOfWeek?> routineWeekDays =
        List.generate(selectedDays.length, (index) {
      final isIndexSelected = selectedDays[index];
      if (isIndexSelected) {
        return daysOfWeek[index];
      }
      return null;
    }).where((element) => element != null).toList();

    return Routine(
      routineId: routineId,
      userId: userId,
      title: title,
      description: description,
      startTime: startTime,
      endTime: endTime,
      active: active,
      duration: duration,
      exercises: exercises,
      weekdays: routineWeekDays,
    );
  }

  factory RoutineCreateModel.fromRoutine(Routine routine) {
    final selectedDays = daysOfWeek.map((e) {
      try {
        final foundDayOfWeek = routine.weekdays?.firstWhere(
          (wd) => wd?.enumName == e.enumName,
        );
        return foundDayOfWeek == null ? false : true;
      } catch (e) {
        return false;
      }
    }).toList();

    return RoutineCreateModel(
      routineId: routine.routineId,
      userId: routine.userId,
      title: routine.title,
      description: routine.description,
      startTime: routine.startTime,
      endTime: routine.endTime,
      duration: routine.duration,
      active: routine.active,
      exercises: routine.exercises ?? [],
      selectedDays: selectedDays,
    );
  }
}
