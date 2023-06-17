import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final void Function()? onTap;
  final Color backgroundColor;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final double? elevation;
  final Clip? clipBehavior;

  const CustomCard({
    Key? key,
    required this.onTap,
    required this.child,
    required this.backgroundColor,
    this.clipBehavior,
    this.margin,
    this.padding,
    this.elevation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(10);

    return Card(
      clipBehavior: clipBehavior,
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
      ),
      elevation: elevation ?? 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius,
        child: Container(
          padding: padding ?? const EdgeInsets.all(20),
          child: child,
        ),
      ),
    );
  }
}
