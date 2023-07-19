import 'package:prev_ler/main.dart';
import 'package:prev_ler/src/modules/routines/shared/repositories/routine_repository.dart';
import 'package:prev_ler/src/shared/entities/exercise.dart';
import 'package:prev_ler/src/shared/entities/notification.dart';
import 'package:prev_ler/src/shared/entities/routine.dart';
import 'package:prev_ler/src/shared/http/client_http.dart';

class RoutineHttpRepository implements IRoutineRepository {
  final ClientHttp _clientHttp;
  final _patientBaseUrl = '${Environment.apiBaseUrl}/pacientes';
  final _routineBaseUrl = '${Environment.apiBaseUrl}/rotinas';

  RoutineHttpRepository(this._clientHttp);

  @override
  Future<Routine> create(Routine routine) async {
    final patientId = routine.idPatient;
    final responseBody = await _clientHttp.post(
      uri: Uri.parse('$_patientBaseUrl/$patientId/rotinas'),
      data: routine.toMap(),
    );

    return Routine.fromMap(responseBody);
  }

  @override
  Future<void> delete(Routine routine) async {
    final id = routine.idRoutine;
    await _clientHttp.delete(uri: Uri.parse('$_routineBaseUrl/$id'));
  }

  @override
  Future<void> update(Routine newRoutine) async {
    final id = newRoutine.idRoutine;
    await _clientHttp.put(
      uri: Uri.parse('$_routineBaseUrl/$id'),
      data: newRoutine.toMap(),
    );
  }

  @override
  Future<List<Routine>> getAllRoutinesByPatientId(int patientId) async {
    final respBody = await _clientHttp.fetch<List<dynamic>>(
      uri: Uri.parse('$_patientBaseUrl/$patientId/rotinas'),
    );

    final routines = respBody.map((e) => Routine.fromMap(e));
    return routines.toList();
  }

  @override
  Future<List<Exercise?>> getActiveExercisesByPatientId(int patientId) {
    // TODO: implement getActiveExercisesByPatientId
    throw UnimplementedError();
  }

  @override
  Future<List<NotificationData>> getAllNotificationsByPatientId(
    int patientId,
  ) async {
    final respBody = await _clientHttp.fetch<List<dynamic>>(
      uri: Uri.parse('$_patientBaseUrl/$patientId/notificacoes'),
    );

    final notifications = respBody.map((e) => NotificationData.fromMap(e));
    return notifications.toList();
  }
}
