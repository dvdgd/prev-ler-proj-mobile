import 'package:flutter/material.dart';
import 'package:prev_ler/src/modules/exercises/shared/exercises_service.dart';
import 'package:prev_ler/src/shared/entities/exercise.dart';
import 'package:prev_ler/src/shared/utils/enums.dart';

class LastsExercisesController extends ChangeNotifier {
  StateEnum state = StateEnum.idle;
  List<Exercise> exercises = [];
  String errorMessage = '';

  final ExerciseService _exerciseService;
  LastsExercisesController(this._exerciseService);

  Future<void> fetchLastsExercises() async {
    notifyListeners();

    try {
      exercises = await _exerciseService.fetchLastsExercises(3);
      state = StateEnum.success;
    } catch (e) {
      errorMessage =
          'Ocorreu um erro inesperado ao buscar os últimos exercicíos.';
      state = StateEnum.error;
    } finally {
      notifyListeners();
    }
  }
}
