import 'package:flutter/material.dart';
import 'package:prev_ler/src/shared/entities/user.dart';
import 'package:prev_ler/src/shared/services/user_service.dart';

enum RegisterUserState { success, idle, loading, error }

class RegisterUserController extends ChangeNotifier {
  RegisterUserState state = RegisterUserState.idle;

  final UserService service;

  RegisterUserController(this.service);

  Future<void> register(User user) async {
    state = RegisterUserState.loading;
    notifyListeners();

    try {
      await service.register(user);
      state = RegisterUserState.success;
      notifyListeners();
    } catch (e) {
      state = RegisterUserState.error;
      notifyListeners();
    }
  }
}
