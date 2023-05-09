import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/theme_colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final dynamic onSubmitted;
  final List<FilteringTextInputFormatter>? inputFormatters;
  final TextInputType? textInputType;
  final int? maxLength;
  final bool? obscureText;
  final bool? enable;
  final EdgeInsets? margin;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.onSubmitted,
    this.inputFormatters,
    this.textInputType,
    this.maxLength,
    this.obscureText,
    this.enable,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ??
          const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 10,
          ),
      height: 58,
      width: double.infinity,
      decoration: BoxDecoration(
        color: ThemeColors().grey.withOpacity(0.5),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: TextField(
          inputFormatters: inputFormatters,
          keyboardType: textInputType,
          obscureText: obscureText ?? false,
          controller: controller,
          onSubmitted: onSubmitted,
          cursorColor: ThemeColors().blue,
          enabled: enable,
          decoration: InputDecoration(
            border: InputBorder.none,
            labelText: hintText,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
          ),
        ),
      ),
    );
  }
}
