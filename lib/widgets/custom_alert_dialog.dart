import 'package:flutter/material.dart';

import 'custom_button.dart';

class CustomAlertDialog extends StatelessWidget {
  final String message;
  final dynamic onTap;

  const CustomAlertDialog({
    super.key,
    required this.message,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: SingleChildScrollView(
        child: Text(
          message,
          textAlign: TextAlign.center,
          maxLines: 15,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      actions: [
        CustomButton(
          text: 'OK',
          onTap: onTap,
        ),
      ],
    );
  }
}
