import 'package:flutter/material.dart';
import 'package:prev_ler/src/shared/ui/widgets/my_text_form_field.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final Widget? prefixIcon;
  final int? maxLength;
  final bool? obscureText;
  final String? Function(String? text)? validator;

  const PasswordField({
    super.key,
    required this.controller,
    required this.labelText,
    this.maxLength,
    this.obscureText,
    this.prefixIcon,
    this.validator,
  });

  @override
  State<StatefulWidget> createState() => _CustomPasswordFieldPageState();
}

class _CustomPasswordFieldPageState extends State<PasswordField> {
  bool _obscureText = true;

  void _changeVisiblePassword() {
    setState(() => _obscureText = !_obscureText);
  }

  get suffixIcon => IconButton(
        icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
        onPressed: _changeVisiblePassword,
      );

  @override
  Widget build(BuildContext context) {
    return MyTextFormField(
      validator: widget.validator,
      controller: widget.controller,
      labelText: widget.labelText,
      textInputType: TextInputType.visiblePassword,
      prefixIcon: const Icon(Icons.lock_outline),
      obscureText: _obscureText,
      maxLength: widget.maxLength,
      suffixIcon: suffixIcon,
    );
  }
}
