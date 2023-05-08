import 'package:flutter/material.dart';

import '../theme/theme_colors.dart';

class CustomAsyncLoadingButton extends StatefulWidget {
  final String text;
  final Future<void> Function() action;

  const CustomAsyncLoadingButton({
    super.key,
    required this.text,
    required this.action,
  });

  @override
  State<StatefulWidget> createState() => _CustomAsyncLoadingButtonState();
}

class _CustomAsyncLoadingButtonState extends State<CustomAsyncLoadingButton> {
  late bool _isLoading = false;

  void _changeIsLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextButton(
        onPressed: () async {
          _changeIsLoading();
          await widget.action();
          _changeIsLoading();
        },
        style: TextButton.styleFrom(
          backgroundColor: ThemeColors().blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          minimumSize: const Size(double.infinity, 60),
        ),
        child: Center(
          child: _isLoading
              ? const CircularProgressIndicator(
                  color: Colors.white,
                )
              : Text(
                  widget.text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
        ),
      ),
    );
  }
}
