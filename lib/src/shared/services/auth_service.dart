import 'dart:convert';

import 'package:prev_ler/main.dart';
import 'package:prev_ler/src/shared/entities/user.dart';
import 'package:prev_ler/src/shared/errors/base_error.dart';
import 'package:prev_ler/src/shared/services/secure_store.dart';
import 'package:prev_ler/src/shared/services/user_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sup;

class AuthService {
  User? currentUser;
  UserService userService;
  SecureStore secureStore;

  AuthService({required this.userService, required this.secureStore});

  Future<void> register(UserSignUp user) async {
    final companyUser = await getUserPropsOrThrowError(user.email);
    final userDataMap = {
      'first_name': companyUser['primeiro_nome'],
      'last_name': companyUser['ultimo_nome'],
      'cpf': user.cpf,
      'id_tipo_usuario': companyUser['tipo'],
      'id_empresa': companyUser['id_empresa'],
      'id_cargo': companyUser['id_cargo'],
    };

    try {
      final authResponse = await supabaseClient.auth.signUp(
        email: companyUser["email"],
        password: user.password,
        data: userDataMap,
      );
      await handleAuthResponse(authResponse);
    } catch (e) {
      throw BaseError(
        message: 'Ops. Não foi possível se cadastrar.'
            'Verifique se você está habilitado para utilizar o sistema.',
      );
    }
  }

  Future<void> login(String email, String password) async {
    await getUserPropsOrThrowError(email);

    try {
      final authResponse = await supabaseClient.auth.signInWithPassword(
        password: password,
        email: email,
      );
      await handleAuthResponse(authResponse);
    } catch (e) {
      throw BaseError(message: 'Usuário ou senha incorretos.');
    }
  }

  Future<dynamic> getUserPropsOrThrowError(String email) async {
    try {
      final response = await supabaseClient
          .from("usuarios_ativos")
          .select("*")
          .eq("email", email)
          .single();
      return response;
    } catch (e) {
      throw BaseError(
        message: "Usuário ou senha incorretos.",
      );
    }
  }

  Future<void> handleAuthResponse(sup.AuthResponse authResponse) async {
    if (authResponse.session?.accessToken == null) {
      throw BaseError(
        message: 'Desculpe, não foi possível realizar o login/cadastro.',
      );
    }

    currentUser = await userService.getUserProfile();
    await secureStore.saveBearer(jsonEncode(authResponse.session?.toJson()));
  }

  Future<String?> getCurrentUserId() async {
    return supabaseClient.auth.currentUser?.id;
  }

  Future<bool> checkUserState() async {
    try {
      final sessionStr = await secureStore.getBearer();
      final session = jsonDecode(sessionStr);
      final authResponse =
          await supabaseClient.auth.setSession(session['refresh_token']);
      await handleAuthResponse(authResponse);

      final isLogged = authResponse.session?.accessToken != null;
      return isLogged;
    } catch (e) {
      return false;
    }
  }

  Future<User?> getUserData() async {
    currentUser = await UserService().getUserProfile();
    return currentUser;
  }

  Future<void> logout() async {
    await secureStore.deleteBearerAndPassword();
    await supabaseClient.auth.signOut();
  }

  Future<void> updateUser(UserSignUp newUser) async {
    return;
  }
}
