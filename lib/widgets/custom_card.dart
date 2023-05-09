import 'package:flutter/material.dart';
import 'package:prev_ler/theme/theme_colors.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final void Function() onTap;
  final Color? backgroundColor;
  final EdgeInsets? margin;
  final EdgeInsets? padding;

  const CustomCard({
    super.key,
    required this.onTap,
    required this.child,
    this.backgroundColor,
    this.margin,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final boxShadow = BoxShadow(
      color: Colors.black.withOpacity(0.7),
      blurStyle: BlurStyle.normal,
      blurRadius: 4,
      offset: const Offset(1, 2), // Shadow position
    );

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: backgroundColor ?? ThemeColors().blue,
          boxShadow: [boxShadow],
          borderRadius: BorderRadius.circular(25),
        ),
        height: 130,
        width: double.infinity,
        child: child,
      ),
    );
  }
}
