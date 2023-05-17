import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final void Function()? onTap;
  final Color backgroundColor;
  final EdgeInsets? margin;
  final EdgeInsets? padding;

  const CustomCard({
    Key? key,
    required this.onTap,
    required this.child,
    required this.backgroundColor,
    this.margin,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(15);

    return Card(
      margin: margin ?? const EdgeInsets.all(5),
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
      ),
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius,
        child: Padding(
          padding: padding ?? const EdgeInsets.all(20),
          child: child,
        ),
      ),
    );
  }
}
