import 'package:prev_ler/main.dart';
import 'package:prev_ler/src/shared/entities/exercise.dart';
import 'package:prev_ler/src/shared/http/client_http.dart';

abstract class ExerciseService {
  Future<List<Exercise>> fetchAll();
  Future<void> create(Exercise newExercise);
  Future<void> update(Exercise newExercise);
  Future<void> delete(Exercise exercise);
}

class ExercisesServiceImpl extends ExerciseService {
  final ClientHttp clientHttp;
  final String baseUrl = '${Environment.apiBaseUrl}/exercicios';

  ExercisesServiceImpl(this.clientHttp);

  @override
  Future<void> create(Exercise newExercise) async {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<List<Exercise>> fetchAll() async {
    // TODO: implement create
    // final responseBody = await clientHttp.fetch(uri: Uri.parse(baseUrl));
    throw UnimplementedError();
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
