import 'package:flutter/material.dart';

class OptionButton extends StatelessWidget {
  final String title;
  final VoidCallback pressedFunction;
  final Icon icon;

  const OptionButton({
    super.key,
    required this.title,
    required this.pressedFunction,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextButton.icon(
        style: const ButtonStyle(iconSize: MaterialStatePropertyAll(30)),
        onPressed: pressedFunction,
        icon: icon,
        label: Text(
          title,
          style: const TextStyle(color: Colors.black, fontSize: 17.0),
        ),
      ),
    );
  }
}
