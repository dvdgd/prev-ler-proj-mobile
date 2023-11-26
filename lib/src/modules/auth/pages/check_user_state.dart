import 'package:flutter/material.dart';
import 'package:prev_ler/src/modules/auth/pages/login_page.dart';
import 'package:prev_ler/src/modules/auth/shared/auth_controller.dart';
import 'package:prev_ler/src/modules/main/main_page.dart';
import 'package:prev_ler/src/shared/ui/components/splash_screen.dart';
import 'package:provider/provider.dart';

class CheckUserState extends StatefulWidget {
  const CheckUserState({super.key});

  @override
  State<CheckUserState> createState() => _CheckUserStateState();
}

class _CheckUserStateState extends State<CheckUserState> {
  @override
  void initState() {
    super.initState();
    final controller = context.read<AuthController>();
    if (controller.state == AuthState.idle) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await controller.checkUserState();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<AuthController>();
    final state = controller.state;

    switch (state) {
      case AuthState.loggedIn:
        return const MainPage();
      case AuthState.loading:
      case AuthState.idle:
        return const SplashScreen();
      case AuthState.error:
        return const AuthPage();
      case AuthState.loggedOut:
        return const AuthPage();
      default:
        return const SplashScreen();
    }
  }
}
