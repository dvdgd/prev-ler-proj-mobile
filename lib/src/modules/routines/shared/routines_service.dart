import 'package:prev_ler/main.dart';
import 'package:prev_ler/src/shared/entities/routine.dart';
import 'package:prev_ler/src/shared/http/client_http.dart';

abstract class RoutinesService {
  Future<List<Routine>> getAll(int patientId);
  Future<Routine> create(Routine newRoutine);
  Future<void> update(Routine newRoutine);
  Future<void> delete(Routine newRoutine);
}

class RoutinesServiceImpl extends RoutinesService {
  final ClientHttp clientHttp;
  final _baseUrl = Environment.apiBaseUrl;

  RoutinesServiceImpl(this.clientHttp);

  @override
  Future<List<Routine>> getAll(int patientId) async {
    final responseBody = await clientHttp.fetch<List<dynamic>>(
      uri: Uri.parse('$_baseUrl/pacientes/$patientId/rotinas'),
    );

    final routines = responseBody.map((e) => Routine.fromMap(e)).toList();
    return routines;
  }

  @override
  Future<Routine> create(Routine newRoutine) async {
    final responseBody = await clientHttp.post(
      uri: Uri.parse(_baseUrl),
      data: newRoutine.toMap(),
    );

    final routine = Routine.fromMap(responseBody);
    return routine;
  }

  @override
  Future<void> delete(Routine newRoutine) async {
    final id = newRoutine.idRoutine;
    await clientHttp.delete(uri: Uri.parse('$_baseUrl/$id'));
  }

  @override
  Future<void> update(Routine newRoutine) async {
    final id = newRoutine.idRoutine;
    await clientHttp.put(
      uri: Uri.parse('$_baseUrl/$id'),
      data: newRoutine.toMap(),
    );
  }
}
