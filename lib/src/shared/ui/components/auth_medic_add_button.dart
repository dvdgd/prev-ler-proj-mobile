import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:prev_ler/src/shared/controllers/user_controller.dart';

class AuthMedicAddButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AuthMedicAddButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<UserController>();
    final medic = controller.user?.medic;

    return medic != null
        ? IconButton(
            onPressed: onPressed,
            icon: const Icon(Icons.add),
          )
        : const SizedBox.shrink();
  }
}
