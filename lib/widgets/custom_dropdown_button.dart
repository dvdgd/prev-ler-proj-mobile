import 'package:flutter/material.dart';
import 'package:prev_ler/theme/theme_colors.dart';

class CustomDropdownButton extends StatefulWidget {
  final TextEditingController controller;
  final List list;
  final String hintText;
  final bool? enable;

  const CustomDropdownButton({
    super.key,
    required this.controller,
    required this.list,
    required this.hintText,
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 10,
      ),
      child: Container(
        height: 58,
        width: double.infinity,
        decoration: BoxDecoration(
          color: ThemeColors().grey.withOpacity(0.5),
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: DropdownButtonFormField<String>(
          value: showInitValue ? widget.controller.text : selectedValue,
          items: widget.list
              .map((value) => DropdownMenuItem<String>(
                    value: value,
                    child: Text(value.toString()),
                  ))
              .toList(),
          onChanged: _setNewValue,
          decoration: InputDecoration(
            labelText: widget.hintText,
            border: InputBorder.none,
            prefixIcon: const Icon(Icons.map_outlined),
          ),
        ),
      ),
    );
  }

  void _setNewValue(String? newValue) {
    if (newValue != null) {
      setState(() {
        selectedValue = newValue;
        widget.controller.text = newValue;
      });
    }
  }
}
