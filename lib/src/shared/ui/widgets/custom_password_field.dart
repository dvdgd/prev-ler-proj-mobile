import 'package:flutter/material.dart';
import 'package:prev_ler/src/shared/ui/widgets/custom_text_field.dart';

class CustomPasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final Widget? prefixIcon;
  final int? maxLength;
  final bool? obscureText;
  final String? Function(String? text)? validator;

  const CustomPasswordField({
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

class _CustomPasswordFieldPageState extends State<CustomPasswordField> {
  bool _obscureText = true;
  bool _showVisibleButton = false;

  @override
  void initState() {
    super.initState();
    _checkVisibleButton(null);
  }

  void _checkVisibleButton(_) {
    final controllerText = widget.controller.text;
    if (controllerText.isEmpty) {
      setState(() => _showVisibleButton = false);
    } else if (controllerText.isNotEmpty && _showVisibleButton == false) {
      setState(() => _showVisibleButton = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      validator: widget.validator,
      controller: widget.controller,
      labelText: widget.labelText,
      textInputType: TextInputType.visiblePassword,
      prefixIcon: const Icon(Icons.lock_outline),
      obscureText: _obscureText,
      maxLength: widget.maxLength,
      onChanged: _checkVisibleButton,
      suffixIcon: suffixIcon(),
    );
  }

  IconButton? suffixIcon() {
    if (_showVisibleButton) {
      return IconButton(
        icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
      );
    }
    return null;
  }
}
