import 'package:flutter/material.dart';
import 'package:prev_ler/src/shared/controllers/dark_mode_controller.dart';
import 'package:provider/provider.dart';

class DarkModeButton extends StatelessWidget {
  const DarkModeButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<DarkModeController>();

    return IconButton(
      onPressed: controller.toggle,
      icon: controller.value
          ? const Icon(Icons.light_mode)
          : const Icon(Icons.light_mode_outlined),
    );
  }
}
