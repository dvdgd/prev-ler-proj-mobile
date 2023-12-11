import 'package:flex_seed_scheme/flex_seed_scheme.dart';
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

    const Color primarySeedColor = Color(0xff72be95);
    const Color secondarySeedColor = Color(0xff159caf);
    // const Color tertiarySeedColor = Color(0xff349c7c);

    final ColorScheme schemeLight = SeedColorScheme.fromSeeds(
      brightness: Brightness.light,
      primaryKey: primarySeedColor,
      secondaryKey: secondarySeedColor,
      tones: FlexTones.ultraContrast(Brightness.light),
    );

    // Make a dark ColorScheme from the seeds.
    final ColorScheme schemeDark = SeedColorScheme.fromSeeds(
      brightness: Brightness.dark,
      primaryKey: primarySeedColor,
      secondaryKey: secondarySeedColor,
      tones: FlexTones.ultraContrast(Brightness.dark),
    );

    final currColorScheme =
        brightness == Brightness.dark ? schemeDark : schemeLight;

    final theme = ThemeData(
      buttonTheme: ButtonThemeData(
        colorScheme: currColorScheme,
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
          side: BorderSide(color: currColorScheme.primary),
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
      colorScheme: currColorScheme,
      brightness: brightness,
      useMaterial3: true,
      fontFamily: 'Poppins',
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      initialRoute: Routes.initial,
      routes: Routes.list,
      navigatorKey: Routes.navigatorKey,
    );
  }
}
