import 'package:flutter/material.dart';
import 'package:prev_ler/theme/theme_colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final Color? textColor;
  final Color? buttonColor;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.textColor,
    this.buttonColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all<Color>(buttonColor ?? ThemeColors().blue),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: textColor ?? Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
