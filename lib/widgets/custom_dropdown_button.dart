import 'package:flutter/material.dart';

class CustomDropdownButton<T> extends StatefulWidget {
  final TextEditingController controller;
  final List<DropdownMenuItem<T>> list;
  final String hintText;
  final bool? enable;
  final Widget? prefixIcon;

  const CustomDropdownButton({
    Key? key,
    required this.controller,
    required this.list,
    required this.hintText,
    this.prefixIcon,
    this.enable,
  }) : super(key: key);

  @override
  State<CustomDropdownButton<T>> createState() =>
      _CustomDropdownButtonState<T>();
}

class _CustomDropdownButtonState<T> extends State<CustomDropdownButton<T>> {
  T? selectedValue;
  bool showInitValue = false;

  @override
  void initState() {
    if (widget.controller.text.isNotEmpty) {
      setState(() {
        showInitValue = true;
      });
    }

    super.initState();
  }

  void _setNewValue(T? newValue) {
    if (newValue != null) {
      setState(() {
        selectedValue = newValue;
        widget.controller.text = newValue.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isNotEnable = widget.enable != null && widget.enable == false;

    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 10,
      ),
      child: DropdownButtonFormField<T>(
        value: showInitValue ? widget.controller.text as T? : selectedValue,
        items: widget.list,
        elevation: 8,
        onChanged: isNotEnable ? null : _setNewValue,
        menuMaxHeight: 300,
        decoration: InputDecoration(
          filled: true,
          enabled: !isNotEnable,
          labelText: widget.hintText,
          border: InputBorder.none,
          prefixIcon: widget.prefixIcon,
        ),
      ),
    );
  }
}
