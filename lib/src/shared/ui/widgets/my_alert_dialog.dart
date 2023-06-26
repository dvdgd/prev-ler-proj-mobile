import 'package:flutter/material.dart';

import 'my_filled_button.dart';

class MyAlertDiaLog extends StatelessWidget {
  final String message;
  final VoidCallback? onTap;

  const MyAlertDiaLog({
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
        MyFilledButton(
          text: 'OK',
          onTap: onTap ?? () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}
