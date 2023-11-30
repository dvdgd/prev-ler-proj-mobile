import 'package:prev_ler/main.dart';
import 'package:prev_ler/src/shared/entities/exercise.dart';
import 'package:prev_ler/src/shared/errors/base_error.dart';
import 'package:prev_ler/src/shared/mappers/exercise_mapper.dart';
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
    try {
      final exerciseMap = exerciseToSupabase(newExercise);
      final newExerciseMap = await supabaseClient
          .from('exercicio')
          .insert(exerciseMap)
          .select('*, enfermidade(*)')
          .single();

      return exerciseFromSupabase(newExerciseMap);
    } catch (e) {
      throw UnknowError(
        description: 'Ops... Ocorreu um erro ao criar exercício',
      );
    }
  }

  @override
  Future<List<Exercise>> fetchAll() async {
    try {
      final supExercises = await supabaseClient
          .from('exercicio')
          .select('*, enfermidade(*)') as List<dynamic>;
      final exercises =
          supExercises.map((e) => exerciseFromSupabase(e)).toList();
      return exercises;
    } catch (e) {
      throw UnknowError(
        description: 'Ops... Ocorreu um erro ao buscar os exercícios',
      );
    }
  }

  @override
  Future<void> delete(Exercise exercise) async {
    try {
      await supabaseClient
          .from('exercicio')
          .delete()
          .eq('id_exercicio', exercise.exerciseId);
    } catch (e) {
      throw UnknowError(
        description: 'Ops... Ocorreu um erro ao deletar o exercício',
      );
    }
  }

  @override
  Future<void> update(Exercise newExercise) async {
    try {
      final exerciseMap = exerciseToSupabase(newExercise);
      await supabaseClient
          .from('exercicio')
          .update(exerciseMap)
          .eq('id_exercicio', newExercise.exerciseId);
    } catch (e) {
      throw UnknowError(
        description: 'Ops... Ocorreu um erro ao criar exercício',
      );
    }

    return Future.delayed(const Duration(seconds: 1));
  }
}
