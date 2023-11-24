import 'package:flutter/material.dart';
import 'package:prev_ler/main.dart';
import 'package:prev_ler/src/shared/entities/user.dart';
import 'package:prev_ler/src/shared/utils/enums.dart';

class UserService {
  User? currentUser;
  UserService();

  Future<void> register(User user) async {
    await supabaseClient.auth.signUp(
      email: user.email,
      password: user.password!,
      data: user.toMap(),
    );
  }

  Future<dynamic> getCurrentUserId() async {
    return supabaseClient.auth.currentUser?.id;
  }

  Future<bool> checkUserState() {
    final isLogged = supabaseClient.auth.currentSession?.isExpired;
    return Future.value(isLogged ?? false);
  }

  Future<void> login(String email, String password) async {
    await supabaseClient.auth
        .signInWithPassword(password: password, email: email);
  }

  Future<User> getUserData() async {
    final data = await supabaseClient.from("profiles").select("");
    debugPrint(data);

    return User(
      email: "teste",
      bornDate: DateTime.now(),
      firstName: "teste",
      cpf: '',
      lastName: 'teste 2',
      type: UserType.employee,
    );
  }

  Future<void> logout() async {
    await supabaseClient.auth.signOut();
  }

  Future<void> updateUser(User newUser) async {
    return;
  }
}
