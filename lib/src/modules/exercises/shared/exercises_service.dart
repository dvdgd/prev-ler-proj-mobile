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
  Future<void> create(Exercise newExercise) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<List<Exercise>> fetchAll() {
    // TODO: implement fetchAll
    throw UnimplementedError();
  }

  @override
  Future<void> delete(Exercise exercise) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<void> update(Exercise newExercise) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
