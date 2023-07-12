import 'package:flutter/material.dart';
import 'package:prev_ler/src/shared/entities/exercise.dart';

class ExerciseCartController extends ChangeNotifier {
  List<Exercise> value = [];

  void add(Exercise exercise) {
    value.add(exercise);
    notifyListeners();
  }

  void remove(Exercise exercise) {
    value.removeWhere((e) => e.idExercise == exercise.idExercise);
    notifyListeners();
  }

  void clearAll() {
    value = [];
    notifyListeners();
  }
}
