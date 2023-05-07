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
    return GestureDetector(
      onTap: () async {
        _changeIsLoading();
        await widget.action();
        _changeIsLoading();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            color: ThemeColors().blue,
            borderRadius: BorderRadius.circular(15),
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
      ),
    );
  }
}
