import 'package:flutter/material.dart';
import 'package:prev_ler/src/modules/exercises/shared/exercises_service.dart';
import 'package:prev_ler/src/shared/entities/exercise.dart';
import 'package:prev_ler/src/shared/errors/base_error.dart';
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
    } on BaseError catch (e) {
      errorMessage = e.message;
      state = StateEnum.error;
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
      final newExercise = await service.create(exercise);
      exercises.add(newExercise);
      state = StateEnum.success;
    } on BaseError catch (e) {
      errorMessage = e.message;
      state = StateEnum.error;
    } catch (e) {
      errorMessage = e.toString();
      state = StateEnum.error;
    } finally {
      notifyListeners();
    }
  }

  Future<void> update(Exercise newExercise) async {
    state = StateEnum.loading;
    notifyListeners();

    try {
      await service.update(newExercise);

      final contentIndex = exercises.indexWhere(
        (exerc) => exerc.exerciseId == newExercise.exerciseId,
      );

      if (contentIndex != -1) {
        exercises[contentIndex] = newExercise;
        notifyListeners();
      }

      state = StateEnum.success;
    } on BaseError catch (e) {
      errorMessage = e.message;
      state = StateEnum.error;
    } catch (e) {
      errorMessage = e.toString();
      state = StateEnum.error;
    } finally {
      notifyListeners();
    }
  }

  Future<void> delete(Exercise exercise) async {
    state = StateEnum.loading;
    notifyListeners();

    try {
      await service.delete(exercise);

      exercises.removeWhere((exerc) => exerc.exerciseId == exercise.exerciseId);
      state = StateEnum.success;
    } on BaseError catch (e) {
      errorMessage = e.message;
      state = StateEnum.error;
    } catch (e) {
      errorMessage = e.toString();
      state = StateEnum.error;
    } finally {
      notifyListeners();
    }
  }
}
