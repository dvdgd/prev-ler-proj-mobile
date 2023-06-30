import 'package:flutter/material.dart';

class SliverCenterText extends StatelessWidget {
  const SliverCenterText({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Text(
            message,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
