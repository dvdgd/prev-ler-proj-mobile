import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextFormField extends StatelessWidget {
  final dynamic onTap;
  final dynamic onChanged;
  final bool readOnly;
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final List<FilteringTextInputFormatter>? inputFormatters;
  final TextInputType? textInputType;
  final int? maxLength;
  final bool? obscureText;
  final bool? enable;
  final EdgeInsets? margin;
  final InputBorder? border;
  final int? maxLines;
  final String? Function(String? text)? validator;

  const MyTextFormField({
    super.key,
    this.controller,
    this.labelText,
    this.hintText,
    this.border,
    this.prefixIcon,
    this.suffixIcon,
    this.onTap,
    this.inputFormatters,
    this.textInputType,
    this.maxLength,
    this.obscureText,
    this.enable,
    this.margin,
    this.maxLines,
    this.onChanged,
    this.validator,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    double bottomMargin = 20;

    return Container(
      margin: margin ??
          EdgeInsets.only(
            left: 21,
            right: 21,
            top: 10,
            bottom: bottomMargin,
          ),
      child: TextFormField(
        readOnly: readOnly,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        maxLength: maxLength,
        validator: validator,
        inputFormatters: inputFormatters,
        keyboardType: textInputType,
        obscureText: obscureText ?? false,
        controller: controller,
        onTap: onTap,
        onChanged: onChanged,
        enabled: enable,
        maxLines: maxLines ?? 1,
        minLines: 1,
        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
