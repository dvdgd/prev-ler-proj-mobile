import 'package:flutter/material.dart';

import 'custom_button.dart';

class CustomAlertDialog extends StatelessWidget {
  final String message;

  const CustomAlertDialog({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        message,
        textAlign: TextAlign.center,
      ),
      actions: [
        CustomButton(
          text: 'OK',
          onTap: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}
