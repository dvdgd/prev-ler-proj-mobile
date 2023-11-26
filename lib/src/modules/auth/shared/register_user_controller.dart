import 'package:flutter/material.dart';
import 'package:prev_ler/src/shared/entities/user.dart';
import 'package:prev_ler/src/shared/services/auth_service.dart';

enum RegisterUserState { success, idle, loading, error }

class RegisterUserController extends ChangeNotifier {
  RegisterUserState state = RegisterUserState.idle;

  final AuthService service;

  RegisterUserController(this.service);

  Future<void> register(UserSignUp user) async {
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
