import 'package:flutter/material.dart';
import 'package:prev_ler/src/shared/ui/widgets/custom_text_field.dart';

class CustomPasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final Widget? prefixIcon;
  final int? maxLength;
  final bool? obscureText;

  const CustomPasswordField({
    super.key,
    required this.controller,
    required this.labelText,
    this.maxLength,
    this.obscureText,
    this.prefixIcon,
  });

  @override
  State<StatefulWidget> createState() => _CustomPasswordFieldPageState();
}

class _CustomPasswordFieldPageState extends State<CustomPasswordField> {
  bool _obscureText = true;
  bool _showVisibleButton = false;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: widget.controller,
      labelText: widget.labelText,
      textInputType: TextInputType.visiblePassword,
      prefixIcon: const Icon(Icons.lock_outline),
      obscureText: _obscureText,
      maxLength: widget.maxLength,
      onChanged: _onChangeValue,
      suffixIcon: suffixIcon(),
    );
  }

  void _onChangeValue(value) {
    if (widget.controller.text.isEmpty) {
      setState(() => _showVisibleButton = false);
    } else if (_showVisibleButton == false) {
      setState(() => _showVisibleButton = true);
    }
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
