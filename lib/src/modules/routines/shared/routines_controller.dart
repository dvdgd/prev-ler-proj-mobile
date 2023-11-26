import 'package:flutter/material.dart';
import 'package:prev_ler/src/modules/routines/shared/routine_create_model.dart';
import 'package:prev_ler/src/modules/routines/shared/routines_service.dart';
import 'package:prev_ler/src/shared/entities/routine.dart';
import 'package:prev_ler/src/shared/entities/user.dart';
import 'package:prev_ler/src/shared/errors/base_error.dart';
import 'package:prev_ler/src/shared/services/auth_service.dart';
import 'package:prev_ler/src/shared/utils/enums.dart';

class RoutinesController extends ChangeNotifier {
  StateEnum state = StateEnum.idle;
  List<Routine> routines = [];
  String errorMessage = '';

  final RoutinesService routinesSservice;
  final AuthService userService;

  RoutinesController(this.routinesSservice, this.userService);

  Future<void> checkRoutines() async {
    if (routines.isEmpty) {
      return;
    }

    final firstRoutine = routines[0];
    if (firstRoutine.idPatient != _getPatientUser().idUser) {
      await fetchAll();
    }
  }

  User _getPatientUser() {
    final user = userService.currentUser;
    if (user == null || user.type == UserType.employee) {
      throw BaseError(
        message: 'Você precisa ser um funcionário para criar rotinas.',
      );
    }

    return user;
  }

  Future<void> create(RoutineCreateModel newRoutine) async {
    state = StateEnum.loading;
    notifyListeners();

    try {
      final patientId = _getPatientUser().idUser;
      newRoutine.patientId = patientId;

      final routine = await routinesSservice.create(newRoutine);
      routines.add(routine);
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

  Future<void> fetchAll() async {
    state = StateEnum.loading;
    notifyListeners();

    try {
      final patient = _getPatientUser();

      routines = await routinesSservice.getAll(patient.idUser);
      state = StateEnum.success;
    } on BaseError catch (e) {
      errorMessage = e.message;
      state = StateEnum.error;
    } catch (e, stackTrace) {
      errorMessage = e.toString();
      state = StateEnum.error;
      debugPrint(e.toString());
      debugPrint(stackTrace.toString());
    } finally {
      notifyListeners();
    }
  }

  Future<void> delete(Routine routine) async {
    state = StateEnum.loading;
    notifyListeners();

    try {
      await routinesSservice.delete(routine);
      routines.removeWhere((e) => e.idRoutine == routine.idRoutine);
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

  Future<void> update(Routine newRoutine) async {
    state = StateEnum.loading;
    notifyListeners();

    try {
      await routinesSservice.update(newRoutine);

      _updateRoutineFromController(newRoutine);
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

  Routine _updateRoutineFromController(Routine routine) {
    final routineIndex = routines.indexWhere(
      (e) => e.idRoutine == routine.idRoutine,
    );

    if (routineIndex != -1) {
      routines[routineIndex] = routine;
    }
    return routine;
  }

  Future<void> toggleRoutine(Routine routine) async {
    state = StateEnum.loading;
    notifyListeners();

    try {
      await routinesSservice.toggleRoutine(routine);

      _updateRoutineFromController(routine);
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
