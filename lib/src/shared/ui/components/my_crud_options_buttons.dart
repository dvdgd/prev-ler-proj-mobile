import 'package:flutter/material.dart';

class MyCrudOptionsButtons extends StatelessWidget {
  const MyCrudOptionsButtons({
    super.key,
    required this.options,
  });

  final List<Widget> options;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: options,
        ),
      ),
    );
  }
}
