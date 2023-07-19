import 'package:flutter/material.dart';
import 'package:prev_ler/src/modules/auth/shared/auth_controller.dart';
import 'package:prev_ler/src/shared/controllers/user_controller.dart';
import 'package:provider/provider.dart';

class LogoutButton extends StatefulWidget {
  const LogoutButton({super.key});

  @override
  State<LogoutButton> createState() => _LogoutButtonState();
}

class _LogoutButtonState extends State<LogoutButton> {
  late final UserController userController;
  late final AuthController authController;

  @override
  void initState() {
    super.initState();

    userController = context.read<UserController>();
    authController = context.read<AuthController>();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        await userController.logout();
        await authController.checkUserState();
      },
      icon: const Icon(Icons.logout),
    );
  }
}
