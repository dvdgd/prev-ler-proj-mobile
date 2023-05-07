import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../theme/theme_colors.dart';

class CustomDatePicker extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final TextEditingController selectedDate;
  final BuildContext context;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  const CustomDatePicker({
    super.key,
    required this.hintText,
    required this.controller,
    required this.context,
    required this.selectedDate,
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
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear_outlined),
                onPressed: () {
                  controller.text = '';
                },
              ),
            ),
            controller: controller,
            readOnly: true,
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
