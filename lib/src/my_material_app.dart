import 'package:flutter/material.dart';
import 'package:prev_ler/src/modules/auth/pages/login_page.dart';
import 'package:prev_ler/src/modules/auth/pages/user_register_page.dart';
import 'package:prev_ler/src/modules/contents/pages/content_register_page.dart';
import 'package:prev_ler/src/modules/home/home_page.dart';
import 'package:prev_ler/src/modules/injuries/pages/register_injury.dart';
import 'package:prev_ler/src/modules/main/main_page.dart';
import 'package:prev_ler/src/modules/profile/profile_page.dart';
import 'package:prev_ler/src/modules/routines/pages/routine_page.dart';
import 'package:prev_ler/src/shared/controllers/dark_mode_controller.dart';
import 'package:prev_ler/src/shared/utils/enums.dart';
import 'package:provider/provider.dart';

class MyMaterialApp extends StatelessWidget {
  const MyMaterialApp({super.key});

  @override
  Widget build(BuildContext context) {
    final darkModeController = context.watch<DarkModeController>();

    final isDarkMode = darkModeController.value;
    final brightness = isDarkMode ? Brightness.dark : Brightness.light;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.deepPurple,
        brightness: brightness,
        useMaterial3: true,
        fontFamily: 'Poppins',
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => const AuthPage(),
        '/home': (_) => const MainPage(page: HomePage),
        '/register/patient': (_) =>
            const AuthRegisterPage(userType: UserType.patient),
        '/register/medic': (_) =>
            const AuthRegisterPage(userType: UserType.medic),
        '/contents/register': (_) => const RegisterContentPage(
              title: 'Cadastrar Conteúdo',
              content: null,
            ),
        '/injuries/register': (_) => const RegisterInjury(
              title: 'Cadastrar Lesão',
              injury: null,
            ),
        '/profile': (_) => const ProfilePage(),
        '/routines': (_) => const RoutinesPage(),
      },
    );
  }
}
