import 'package:prev_ler/main.dart';
import 'package:prev_ler/src/shared/entities/user.dart';
import 'package:prev_ler/src/shared/errors/base_error.dart';
import 'package:prev_ler/src/shared/services/user_service.dart';

class AuthService {
  User? currentUser;
  UserService userService;

  AuthService({required this.userService});

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

  Future<void> register(UserSignUp user) async {
    final companyUser = await getUserPropsOrThrowError(user.email);

    final authResponse = await supabaseClient.auth.signUp(
      email: companyUser["email"],
      password: user.password,
      data: {
        'first_name': companyUser['primeiro_nome'],
        'last_name': companyUser['ultimo_nome'],
        'cpf': user.cpf,
        'id_tipo_usuario': companyUser['tipo'],
        'id_empresa': companyUser['id_empresa'],
        'id_cargo': companyUser['id_cargo'],
      },
    );

    if (authResponse.session?.accessToken == null) {
      throw BaseError(
        message: 'Não foi possível se cadastrar.',
      );
    }

    currentUser = await userService.getUserProfile();
  }

  Future<void> login(String email, String password) async {
    await getUserPropsOrThrowError(email);

    try {
      await supabaseClient.auth.signInWithPassword(
        password: password,
        email: email,
      );
    } catch (e) {
      throw BaseError(message: 'Usuário ou senha incorretos.');
    }

    currentUser = await UserService().getUserProfile();
  }

  Future<String?> getCurrentUserId() async {
    return supabaseClient.auth.currentUser?.id;
  }

  Future<bool> checkUserState() {
    final isLogged = supabaseClient.auth.currentSession?.isExpired;
    return Future.value(isLogged ?? false);
  }

  Future<User?> getUserData() async {
    currentUser = await UserService().getUserProfile();
    return currentUser;
  }

  Future<void> logout() async {
    await supabaseClient.auth.signOut();
  }

  Future<void> updateUser(User newUser) async {
    return;
  }
}
