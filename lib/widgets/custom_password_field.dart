import 'package:flutter/material.dart';
import 'package:prev_ler/widgets/custom_text_field.dart';

class CustomPasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final Widget? prefixIcon;
  final int? maxLength;
  final bool? obscureText;

  const CustomPasswordField({
    super.key,
    required this.controller,
    required this.hintText,
    this.maxLength,
    this.obscureText,
    this.prefixIcon,
  });

  @override
  State<StatefulWidget> createState() => _CustomPasswordFieldPageState();
}

class _CustomPasswordFieldPageState extends State<CustomPasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: widget.controller,
      hintText: widget.hintText,
      textInputType: TextInputType.visiblePassword,
      prefixIcon: const Icon(Icons.lock_outline),
      obscureText: _obscureText,
      maxLength: widget.maxLength,
      suffixIcon: IconButton(
        icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
      ),
    );
  }
}
