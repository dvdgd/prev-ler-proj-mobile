import 'package:flutter/material.dart';

class CustomDropdownButton extends StatefulWidget {
  final TextEditingController controller;
  final List list;
  final String hintText;
  final bool? enable;
  final Widget? prefixIcon;

  const CustomDropdownButton({
    super.key,
    required this.controller,
    required this.list,
    required this.hintText,
    this.prefixIcon,
    this.enable,
  });

  @override
  State<CustomDropdownButton> createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  String? selectedValue;
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

  void _setNewValue(String? newValue) {
    if (newValue != null) {
      setState(() {
        selectedValue = newValue;
        widget.controller.text = newValue;
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
      child: DropdownButtonFormField<String>(
        value: showInitValue ? widget.controller.text : selectedValue,
        items: widget.list
            .map((value) => DropdownMenuItem<String>(
                  value: value,
                  child: Text(value.toString()),
                ))
            .toList(),
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
