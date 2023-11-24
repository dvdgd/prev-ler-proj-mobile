import 'package:flutter/material.dart';
import 'package:prev_ler/src/shared/controllers/user_controller.dart';
import 'package:prev_ler/src/shared/utils/enums.dart';
import 'package:provider/provider.dart';

class AuthMedicAddButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AuthMedicAddButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<UserController>();
    final medic = controller.user?.type == UserType.healthProfessional;

    return medic
        ? IconButton(
            onPressed: onPressed,
            icon: const Icon(Icons.add),
          )
        : const SizedBox.shrink();
  }
}
