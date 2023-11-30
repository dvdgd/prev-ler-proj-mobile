import 'package:flutter/material.dart';
import 'package:prev_ler/src/modules/auth/shared/auth_request_model.dart';
import 'package:prev_ler/src/shared/errors/base_error.dart';
import 'package:prev_ler/src/shared/http/client_http.dart';
import 'package:prev_ler/src/shared/services/auth_service.dart';

enum AuthState { loggedIn, error, loggedOut, loading, idle }

class AuthController extends ChangeNotifier {
  final AuthService authService;
  final ClientHttp clientHttp;

  AuthController(this.authService, this.clientHttp);

  AuthState state = AuthState.idle;
  String errorMessage = '';

  Future<void> login(AuthRequestModel authRequest) async {
    state = AuthState.loading;
    notifyListeners();

    final email = authRequest.email;
    final password = authRequest.password;

    try {
      if (email.isEmpty && password.isEmpty) {
        throw BaseError(message: "O e-mail e a senha não podem ser vazios.");
      }

      await authService.login(email, password);

      state = AuthState.loggedIn;
    } on BaseError catch (e) {
      errorMessage = e.message;
      state = AuthState.error;
    } catch (e) {
      errorMessage = 'Erro inesperado';
      state = AuthState.error;
    } finally {
      notifyListeners();
    }
  }

  Future<void> checkUserState() async {
    try {
      final logged = await authService.checkUserState();

      if (logged) {
        state = AuthState.loggedIn;
      } else {
        state = AuthState.loggedOut;
      }
    } catch (e) {
      state = AuthState.error;
      errorMessage = "Ops... Não foi possível recuperar a sessão do usuário";
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
