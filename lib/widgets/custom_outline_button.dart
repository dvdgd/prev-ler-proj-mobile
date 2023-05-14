import 'package:flutter/material.dart';
import 'package:prev_ler/theme/theme_colors.dart';

class CustomOutlineButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final Color? textColor;
  final Color? buttonColor;

  const CustomOutlineButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.textColor,
    this.buttonColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = buttonColor ?? ThemeColors().blue;

    return OutlinedButton(
      onPressed: onTap,
      style: ButtonStyle(
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        side: MaterialStateProperty.all<BorderSide>(
          BorderSide(
            color: color,
            width: 2,
          ),
        ),
      ),
      child: SizedBox(
        height: 60,
        width: double.infinity,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              shadows: [
                Shadow(
                  color: Colors.grey.shade100,
                  offset: const Offset(1, 1),
                  blurRadius: 2,
                ),
              ],
              color: color,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
