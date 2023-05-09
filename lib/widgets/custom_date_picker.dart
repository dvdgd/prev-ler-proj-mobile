import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../theme/theme_colors.dart';

class CustomDatePicker extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final TextEditingController selectedDate;
  final BuildContext context;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? enable;

  const CustomDatePicker({
    super.key,
    required this.labelText,
    required this.controller,
    required this.context,
    required this.selectedDate,
    this.enable,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    final isNotEnable = enable != null && enable == false;

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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: TextField(
            enabled: enable,
            controller: controller,
            style: TextStyle(
              color: isNotEnable ? Colors.grey.shade400 : null,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              labelText: labelText,
              prefixIcon: prefixIcon,
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear_outlined),
                onPressed: () {
                  controller.text = '';
                },
              ),
            ),
            onTap: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1990),
                lastDate: DateTime(2035),
              );

              if (date != null) {
                selectedDate.text = date.toString();
                controller.text = DateFormat('dd/MM/yyyy').format(date);
              }
            },
          ),
        ),
      ),
    );
  }
}
