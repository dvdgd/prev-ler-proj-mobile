import 'package:flutter/material.dart';
import 'package:prev_ler/src/shared/entities/exercise.dart';
import 'package:prev_ler/src/shared/utils/enums.dart';

class ExerciseCartController extends ChangeNotifier {
  List<Exercise> exercises = [];
  StateEnum state = StateEnum.idle;

  void add(Exercise exercise) {
    exercises.add(exercise);
    notifyListeners();
  }

  void remove(Exercise exercise) {
    exercises.removeWhere((e) => e.exerciseId == exercise.exerciseId);
    notifyListeners();
  }

  void clearAll() {
    exercises = [];
  }
}
