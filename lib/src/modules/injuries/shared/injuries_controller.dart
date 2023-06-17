import 'package:flutter/material.dart';
import 'package:prev_ler/src/modules/injuries/shared/injuries_service.dart';
import 'package:prev_ler/src/shared/entities/injury_type.dart';
import 'package:prev_ler/src/shared/enums/state_controller.dart';

class InjuriesController extends ChangeNotifier {
  final InjuriesService service;

  InjuriesController(this.service);

  List<InjuryType> injuries = [];
  StateEnum state = StateEnum.idle;
  String errorMessage = '';

  Future<void> fetchAllInjuries() async {
    state = StateEnum.loading;
    injuries = [];
    notifyListeners();

    try {
      injuries = await service.fetchAll();
      state = StateEnum.success;
    } catch (e) {
      errorMessage = e.toString();
      state = StateEnum.error;
    } finally {
      notifyListeners();
    }
  }

  Future<InjuryType> fetchInjuryTypeById(int idInjuryType) async {
    return service.fetchById(idInjuryType);
  }

  Future<void> create(InjuryType injuryType) async {
    state = StateEnum.loading;
    notifyListeners();

    try {
      final newInjuryType = await service.create(injuryType);
      injuries.add(newInjuryType);
      state = StateEnum.success;
    } catch (e) {
      errorMessage = e.toString();
      state = StateEnum.error;
    } finally {
      notifyListeners();
    }
  }

  Future<void> update(InjuryType newInjuryType) async {
    state = StateEnum.loading;
    notifyListeners();

    try {
      await service.update(newInjuryType);

      final injuryTypeIndex = injuries.indexWhere(
        (cnt) => cnt.idInjuryType == newInjuryType.idInjuryType,
      );

      if (injuryTypeIndex != -1) {
        injuries[injuryTypeIndex] = newInjuryType;
        notifyListeners();
      }

      state = StateEnum.success;
    } catch (e) {
      errorMessage = e.toString();
      state = StateEnum.error;
    } finally {
      notifyListeners();
    }
  }

  Future<void> deleteInjuryType(InjuryType injuryType) async {
    state = StateEnum.loading;
    notifyListeners();

    try {
      await service.delete(injuryType);

      injuries.removeWhere(
        (cnt) => cnt.idInjuryType == injuryType.idInjuryType,
      );
      state = StateEnum.success;
    } catch (e) {
      errorMessage = e.toString();
      state = StateEnum.error;
    } finally {
      notifyListeners();
    }
  }
}
