import 'package:flutter/material.dart';
import 'package:prev_ler/src/shared/entities/user.dart';
import 'package:prev_ler/src/shared/services/user_service.dart';
import 'package:prev_ler/src/shared/utils/enums.dart';

class UserController extends ChangeNotifier {
  final UserService authService;
  UserController(this.authService);

  User? user;
  StateEnum state = StateEnum.idle;

  String errorMessage = '';

  Future<void> fetchUser() async {
    if (state != StateEnum.idle) {
      return;
    } else {
      state = StateEnum.loading;
      notifyListeners();
    }

    try {
      user = await authService.getUserData();
      state = StateEnum.success;
    } catch (e) {
      errorMessage = e.toString();
      state = StateEnum.error;
    } finally {
      notifyListeners();
    }
  }

  Future<void> updateUser(User newUser) async {
    state = StateEnum.loading;
    notifyListeners();

    try {
      await authService.updateUser(newUser);
      user = newUser;
      state = StateEnum.success;
    } catch (e) {
      errorMessage = e.toString();
      state = StateEnum.error;
    } finally {
      notifyListeners();
    }
  }

  Future<void> logout() async {
    state = StateEnum.loading;
    notifyListeners();

    await authService.logout();
    clearState();
  }

  void clearState() {
    state = StateEnum.idle;
    user = null;
    notifyListeners();
  }
}
