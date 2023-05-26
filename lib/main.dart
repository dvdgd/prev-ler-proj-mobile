import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prev_ler/pages/auths/login_page.dart';
import 'package:prev_ler/services/darkmode_notifier.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final darkMode = ref.watch(darkModeProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        colorSchemeSeed: Colors.deepPurple,
        brightness: darkMode ? Brightness.dark : Brightness.light,
        useMaterial3: true,
        fontFamily: 'Poppins',
      ),
      home: LoginPage(),
    );
  }
}
