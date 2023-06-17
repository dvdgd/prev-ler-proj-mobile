import 'package:flutter/material.dart';
import 'package:prev_ler/src/shared/controllers/user_controller.dart';
import 'package:prev_ler/src/shared/enums/state_controller.dart';
import 'package:provider/provider.dart';

class LogoutButton extends StatefulWidget {
  const LogoutButton({super.key});

  @override
  State<LogoutButton> createState() => _LogoutButtonState();
}

class _LogoutButtonState extends State<LogoutButton> {
  late final UserController controller;

  @override
  void initState() {
    super.initState();

    controller = context.read<UserController>();
    controller.addListener(_handleAuthStateChanged);
  }

  @override
  void dispose() {
    controller.removeListener(_handleAuthStateChanged);
    super.dispose();
  }

  void _handleAuthStateChanged() {
    if (controller.state == StateEnum.idle) {
      Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: controller.logout,
      icon: const Icon(Icons.logout),
    );
  }
}
