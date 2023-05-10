import 'package:flutter/material.dart';

class PageTitle extends StatelessWidget {
  final String title;
  final TextStyle? style;

  const PageTitle({
    super.key,
    required this.title,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: style ??
          const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 23,
          ),
    );
  }
}
