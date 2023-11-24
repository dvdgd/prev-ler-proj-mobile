import 'package:flutter/material.dart';
import 'package:prev_ler/src/config/routes.dart';
import 'package:prev_ler/src/shared/controllers/dark_mode_controller.dart';
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
      seedColor: Colors.blueAccent,
      brightness: brightness,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        buttonTheme: ButtonThemeData(
          colorScheme: myColorScheme,
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
            side: BorderSide(color: myColorScheme.primary),
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
      initialRoute: Routes.initial,
      routes: Routes.list,
      navigatorKey: Routes.navigatorKey,
    );
  }
}
