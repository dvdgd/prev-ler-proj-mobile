import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../theme/theme_colors.dart';

class CustomDatePicker extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final BuildContext context;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  const CustomDatePicker({
    super.key,
    required this.hintText,
    required this.controller,
    required this.context,
    this.prefixIcon,
    this.suffixIcon,
  });

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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
            ),
            controller: controller,
            readOnly: true,
            onTap: () async {
              final selectedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1990),
                lastDate: DateTime(2035),
              );

              if (selectedDate != null) {
                controller.text = DateFormat('dd/MM/yyyy').format(selectedDate);
              }
            },
          ),
        ),
      ),
    );
  }
}
