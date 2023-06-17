import 'package:flutter/material.dart';

class MyLoadingSliver extends StatelessWidget {
  const MyLoadingSliver({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverFillRemaining(
      hasScrollBody: false,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
