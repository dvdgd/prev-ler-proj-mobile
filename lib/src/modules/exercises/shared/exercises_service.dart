import 'package:prev_ler/main.dart';
import 'package:prev_ler/src/shared/entities/exercise.dart';
import 'package:prev_ler/src/shared/http/client_http.dart';
import 'package:prev_ler/src/shared/services/file_converter.dart';

abstract class ExerciseService {
  Future<List<Exercise>> fetchAll();
  Future<Exercise> create(Exercise newExercise);
  Future<void> update(Exercise newExercise);
  Future<void> delete(Exercise exercise);
}

class ExercisesServiceImpl extends ExerciseService {
  final ClientHttp clientHttp;
  final FileConverter fileConverter;
  final String baseUrl = '${Environment.apiBaseUrl}/exercicios';

  ExercisesServiceImpl(
    this.clientHttp,
    this.fileConverter,
  );

  @override
  Future<Exercise> create(Exercise newExercise) async {
    final responseBody = await clientHttp.post(
        uri: Uri.parse(baseUrl), data: newExercise.toMap());

    return Exercise.fromMap(responseBody);
  }

  @override
  Future<List<Exercise>> fetchAll() async {
    final responseBody = await clientHttp.fetch<List<dynamic>>(
      uri: Uri.parse(baseUrl),
    );

    final exercises = responseBody.map((e) => Exercise.fromMap(e));
    return exercises.toList();
  }

  @override
  Future<void> delete(Exercise exercise) async {
    final id = exercise.idExercise;
    await clientHttp.delete(uri: Uri.parse('$baseUrl/$id'));
  }

  @override
  Future<void> update(Exercise newExercise) async {
    final id = newExercise.idExercise;
    await clientHttp.put(
      uri: Uri.parse('$baseUrl/$id'),
      data: newExercise.toMap(),
    );
  }
}
