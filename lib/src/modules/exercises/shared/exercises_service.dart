import 'package:prev_ler/src/shared/entities/exercise.dart';
import 'package:prev_ler/src/shared/utils/my_converter.dart';

abstract class ExerciseService {
  Future<List<Exercise>> fetchAll();
  Future<Exercise> create(Exercise newExercise);
  Future<void> update(Exercise newExercise);
  Future<void> delete(Exercise exercise);
}

class ExercisesServiceImpl extends ExerciseService {
  final MyConverter fileConverter;

  ExercisesServiceImpl(
    this.fileConverter,
  );

  @override
  Future<Exercise> create(Exercise newExercise) async {
    return newExercise;
  }

  @override
  Future<List<Exercise>> fetchAll() async {
    return [
      Exercise(
        idMedic: 1,
        idInjuryType: 1,
        name: "name",
        description: "description",
        instructions: "instructions",
        image: "teste",
        precautions: "precautions",
        observations: "observations",
      ),
    ];
  }

  @override
  Future<void> delete(Exercise exercise) async {
    return Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<void> update(Exercise newExercise) async {
    return Future.delayed(const Duration(seconds: 1));
  }
}
