import 'package:flutter/material.dart';
import 'package:prev_ler/src/modules/home/components/dark_mode_button.dart';
import 'package:prev_ler/src/shared/controllers/user_controller.dart';
import 'package:prev_ler/src/shared/ui/components/page_title.dart';
import 'package:prev_ler/src/shared/ui/components/splash_screen.dart';
import 'package:prev_ler/src/shared/ui/components/user_form.dart';
import 'package:prev_ler/src/shared/utils/enums.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<UserController>();
    final user = controller.user;

    if (user == null) {
      return const SplashScreen();
    }

    final isMedic = user.medic != null;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        scrolledUnderElevation: 0,
        title: const PageTitle(title: 'Meu Perfil'),
        actions: const [DarkModeButton()],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            UserForm(
              action: controller.updateUser,
              userType: isMedic ? UserType.medic : UserType.patient,
              user: user,
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
