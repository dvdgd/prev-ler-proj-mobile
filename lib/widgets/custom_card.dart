import 'package:flutter/material.dart';
import 'package:prev_ler/theme/theme_colors.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final void Function()? onTap;
  final Color? backgroundColor;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final double? height;

  const CustomCard({
    Key? key,
    required this.onTap,
    required this.child,
    this.backgroundColor,
    this.margin,
    this.padding,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final boxShadow = BoxShadow(
      color: Colors.black.withOpacity(0.7),
      blurStyle: BlurStyle.normal,
      blurRadius: 4,
      offset: const Offset(1, 2), // Shadow position
    );

    return Container(
      margin: margin ?? const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        boxShadow: [boxShadow],
      ),
      child: Material(
        color: backgroundColor ?? ThemeColors().blue,
        borderRadius: BorderRadius.circular(25),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(25),
          child: Container(
            padding: padding ?? const EdgeInsets.all(20),
            height: height ?? 130,
            width: double.infinity,
            child: child,
          ),
        ),
      ),
    );
  }
}
