import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? labelText;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final dynamic onSubmitted;
  final List<FilteringTextInputFormatter>? inputFormatters;
  final TextInputType? textInputType;
  final int? maxLength;
  final bool? obscureText;
  final bool? enable;
  final EdgeInsets? margin;
  final InputBorder? border;
  final int? maxLines;

  const CustomTextField({
    super.key,
    required this.controller,
    this.labelText,
    this.hintText,
    this.border,
    this.prefixIcon,
    this.suffixIcon,
    this.onSubmitted,
    this.inputFormatters,
    this.textInputType,
    this.maxLength,
    this.obscureText,
    this.enable,
    this.margin,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ??
          const EdgeInsets.only(
            left: 21,
            right: 21,
            top: 10,
          ),
      child: TextField(
        inputFormatters: inputFormatters,
        keyboardType: textInputType,
        obscureText: obscureText ?? false,
        controller: controller,
        onSubmitted: onSubmitted,
        style: TextStyle(
          color: enable != null && enable == false
              ? Theme.of(context).disabledColor
              : null,
        ),
        enabled: enable,
        maxLines: maxLines ?? 1,
        decoration: InputDecoration(
          border: InputBorder.none,
          filled: true,
          hintText: hintText,
          labelText: labelText,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
