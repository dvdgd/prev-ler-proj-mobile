import 'package:flutter/material.dart';

class CustomDropdownButton<T> extends StatefulWidget {
  final TextEditingController controller;
  final List<DropdownMenuItem<T>> list;
  final String hintText;
  final bool enable;
  final Widget? prefixIcon;
  final T? initValue;
  final String? Function(T?)? validator;

  const CustomDropdownButton({
    super.key,
    required this.controller,
    required this.list,
    required this.hintText,
    this.prefixIcon,
    this.enable = true,
    this.initValue,
    this.validator,
  });

  @override
  State<CustomDropdownButton<T>> createState() =>
      _CustomDropdownButtonState<T>();
}

class _CustomDropdownButtonState<T> extends State<CustomDropdownButton<T>> {
  T? selectedValue;
  bool showInitValue = false;

  @override
  void initState() {
    super.initState();
    if (widget.controller.text.isNotEmpty) {
      setState(() => showInitValue = true);
    }
  }

  void _setNewValue(T? newValue) {
    if (newValue != null) {
      setState(() => selectedValue = newValue);
      widget.controller.text = newValue.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    final notEnable = widget.enable == false;

    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 10,
        bottom: 20,
      ),
      child: DropdownButtonFormField<T>(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: widget.validator,
        value: widget.initValue,
        items: widget.list,
        elevation: 8,
        onChanged: notEnable ? null : _setNewValue,
        menuMaxHeight: 300,
        decoration: InputDecoration(
          filled: true,
          enabled: !notEnable,
          labelText: widget.hintText,
          prefixIcon: widget.prefixIcon,
        ),
      ),
    );
  }
}
