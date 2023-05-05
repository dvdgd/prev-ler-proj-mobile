import 'package:flutter/material.dart';

import '../theme/theme_colors.dart';

class CustomDropdownButton extends StatefulWidget {
  final TextEditingController controller;
  final List list;

  const CustomDropdownButton({
    super.key,
    required this.controller,
    required this.list,
  });

  @override
  State<CustomDropdownButton> createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 10,
      ),
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: ThemeColors().grey.withOpacity(0.5),
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: DropdownButtonFormField<String>(
          items: widget.list
              .map((value) => DropdownMenuItem<String>(
                    value: value,
                    child: Text(value.toString()),
                  ))
              .toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() {
                widget.controller.text = newValue;
              });
            }
          },
          decoration: const InputDecoration(
            hintText: 'Selecione um estado',
            border: InputBorder.none,
            prefixIcon: Icon(Icons.map_outlined),
          ),
        ),
      ),
    );
  }
}
