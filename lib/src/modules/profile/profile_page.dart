import 'package:flutter/material.dart';
import 'package:prev_ler/src/config/routes.dart';
import 'package:prev_ler/src/shared/controllers/user_controller.dart';
import 'package:prev_ler/src/shared/ui/components/dark_mode_button.dart';
import 'package:prev_ler/src/shared/ui/components/page_title.dart';
import 'package:prev_ler/src/shared/ui/components/splash_screen.dart';
import 'package:prev_ler/src/shared/utils/enums.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final UserController controller;

  @override
  void initState() {
    super.initState();

    controller = context.read<UserController>();
    controller.addListener(_handleUpdateStateChange);
  }

  @override
  void dispose() {
    controller.removeListener(_handleUpdateStateChange);
    super.dispose();
  }

  void _handleUpdateStateChange() {
    if (controller.state == StateEnum.error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Ocorreu um erro inesperado, tente novamente mais tarde.',
          ),
        ),
      );
    } else if (controller.state == StateEnum.success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Atualizado com sucesso.')),
      );
      Navigator.of(Routes.navigatorKey.currentContext!).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<UserController>();
    final user = controller.user;

    if (user == null) {
      return const SplashScreen();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        scrolledUnderElevation: 0,
        title: const PageTitle(title: 'Meu Perfil'),
        actions: const [DarkModeButton()],
      ),
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
