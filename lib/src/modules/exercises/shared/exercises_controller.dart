import 'package:flutter/material.dart';
import 'package:prev_ler/src/modules/exercises/shared/exercises_service.dart';
import 'package:prev_ler/src/shared/entities/exercise.dart';
import 'package:prev_ler/src/shared/utils/enums.dart';

class ExercisesController extends ChangeNotifier {
  StateEnum state = StateEnum.idle;
  List<Exercise> exercises = [];
  String errorMessage = '';

  final ExerciseService service;

  ExercisesController(this.service);

  Future<void> fetchAll() async {
    state = StateEnum.loading;
    notifyListeners();

    try {
      exercises = await service.fetchAll();
      state = StateEnum.success;
    } catch (e) {
      errorMessage = e.toString();
      state = StateEnum.error;
    } finally {
      notifyListeners();
    }
  }

  Future<void> create(Exercise exercise) async {
    state = StateEnum.loading;
    notifyListeners();

    try {
      await service.create(exercise);
      state = StateEnum.success;
    } catch (e) {
      errorMessage = e.toString();
      state = StateEnum.error;
    } finally {
      notifyListeners();
    }
  }
}
