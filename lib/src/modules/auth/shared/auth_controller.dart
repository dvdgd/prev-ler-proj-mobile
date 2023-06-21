import 'package:flutter/material.dart';
import 'package:prev_ler/src/modules/auth/shared/auth_request_model.dart';
import 'package:prev_ler/src/shared/http/client_http.dart';
import 'package:prev_ler/src/shared/services/user_service.dart';

enum AuthState { loggedIn, error, loggedOut, loading }

class AuthController extends ChangeNotifier {
  final UserService authService;
  final ClientHttp clientHttp;

  AuthController(this.authService, this.clientHttp);

  AuthState state = AuthState.loggedOut;
  String errorMessage = '';

  Future<void> login(AuthRequestModel authRequest) async {
    state = AuthState.loading;
    notifyListeners();

    final email = authRequest.email;
    final password = authRequest.password;

    try {
      if (email.isEmpty && password.isEmpty) {
        throw Exception("Email and password must be filled");
      }

      await authService.login(email, password);

      state = AuthState.loggedIn;
    } catch (e) {
      errorMessage = e.toString();
      state = AuthState.error;
    } finally {
      notifyListeners();
    }
  }

  void clearState() {
    state = AuthState.loggedOut;
    errorMessage = '';
    notifyListeners();
  }
}
