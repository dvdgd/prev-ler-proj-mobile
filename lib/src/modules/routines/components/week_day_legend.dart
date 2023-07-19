import 'package:flutter/material.dart';

class WeekdayLegend extends StatelessWidget {
  const WeekdayLegend({super.key});

  @override
  Widget build(BuildContext context) {
    const double width = 10;
    const double height = 10;
    const double blurRadius = 2;

    const double borderRadius = 15;

    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: colorScheme.tertiary,
            borderRadius: BorderRadius.circular(borderRadius),
            boxShadow: const [BoxShadow(blurRadius: blurRadius)],
          ),
        ),
        const SizedBox(width: 6),
        const Text('Ativado'),
        const SizedBox(width: 12),
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: colorScheme.tertiaryContainer,
            borderRadius: BorderRadius.circular(borderRadius),
            boxShadow: [
              BoxShadow(color: colorScheme.tertiary, blurRadius: blurRadius),
            ],
          ),
        ),
        const SizedBox(width: 6),
        const Text('Desativado'),
      ],
    );
  }
}
