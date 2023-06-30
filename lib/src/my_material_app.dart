import 'package:flutter/material.dart';
import 'package:prev_ler/src/modules/auth/pages/login_page.dart';
import 'package:prev_ler/src/modules/auth/pages/user_register_page.dart';
import 'package:prev_ler/src/modules/contents/pages/content_form_page.dart';
import 'package:prev_ler/src/modules/home/home_page.dart';
import 'package:prev_ler/src/modules/injuries/pages/injury_form_page.dart';
import 'package:prev_ler/src/modules/main/main_page.dart';
import 'package:prev_ler/src/modules/profile/profile_page.dart';
import 'package:prev_ler/src/modules/routines/pages/routine_form_page.dart';
import 'package:prev_ler/src/modules/routines/pages/routine_page.dart';
import 'package:prev_ler/src/shared/controllers/dark_mode_controller.dart';
import 'package:prev_ler/src/shared/utils/enums.dart';
import 'package:provider/provider.dart';

class MyMaterialApp extends StatelessWidget {
  const MyMaterialApp({super.key});

  get _borderRadius => BorderRadius.circular(15);
  get _roudedRectangleBorder => RoundedRectangleBorder(
        borderRadius: _borderRadius,
      );

  @override
  Widget build(BuildContext context) {
    final darkModeController = context.watch<DarkModeController>();

    final isDarkMode = darkModeController.value;
    final brightness = isDarkMode ? Brightness.dark : Brightness.light;

    final myColorScheme = ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      brightness: brightness,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        buttonTheme: ButtonThemeData(
          shape: _roudedRectangleBorder,
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<OutlinedBorder>(
              _roudedRectangleBorder,
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            shape: _roudedRectangleBorder,
            side: BorderSide(
              color: myColorScheme.primary,
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          border: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
        snackBarTheme: const SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
        ),
        colorScheme: myColorScheme,
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
        '/contents/register': (_) => const ContentFormPage(
              title: 'Cadastrar Conteúdo',
              content: null,
            ),
        '/injuries/register': (_) => const InjuryFormPage(
              title: 'Nova Lesão',
              injury: null,
            ),
        '/profile': (_) => const ProfilePage(),
        '/routines': (_) => const RoutinesPage(),
        '/routines/register': (_) => RoutineFormPage(
              title: 'Nova Rotina',
              routine: null,
            )
      },
    );
  }
}
