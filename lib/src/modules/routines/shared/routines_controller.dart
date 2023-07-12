import 'package:flutter/material.dart';
import 'package:prev_ler/src/modules/routines/shared/routines_service.dart';
import 'package:prev_ler/src/shared/entities/routine.dart';
import 'package:prev_ler/src/shared/services/user_service.dart';
import 'package:prev_ler/src/shared/utils/enums.dart';

class RoutinesController extends ChangeNotifier {
  StateEnum state = StateEnum.idle;
  List<Routine> routines = [];
  String errorMessage = '';

  final RoutinesService routinesSservice;
  final UserService userService;

  RoutinesController(this.routinesSservice, this.userService);

  Future<void> fetchAll() async {
    final user = await userService.getUserData();
    final patientId = user.patient?.idPatient;

    if (patientId == null) {
      errorMessage = 'Você precisa ser um paciente para criar rotinas.';
      state = StateEnum.error;
      return;
    }

    try {
      final user = await userService.getUserData();
      final patient = user.patient;
      if (patient == null) {
        throw Exception(
          'Desculpe, mas apenas um paciente pode acessar essa funcionalidade',
        );
      }

      routines = await routinesSservice.getAll(patient.idPatient);
    } catch (e) {
      errorMessage = e.toString();
    } finally {}
  }

  Future<void> update() async {}

  Future<void> delete() async {}
}
