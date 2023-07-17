import 'package:flutter/material.dart';
import 'package:prev_ler/src/config/routes.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () =>
              Navigator.of(Routes.navigatorKey.currentContext!).pop(),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: const Center(child: CircularProgressIndicator()),
    );
  }
}
