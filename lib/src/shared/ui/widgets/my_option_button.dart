import 'package:flutter/material.dart';

class MyOptionButton extends StatelessWidget {
  const MyOptionButton({
    super.key,
    required this.title,
    required this.icon,
    required this.pressedFunction,
  });

  final String title;
  final Icon icon;
  final void Function() pressedFunction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 20.0),
      child: Column(
        children: [
          IconButton(onPressed: pressedFunction, icon: icon),
          Text(title)
        ],
      ),
    );
  }
}
