import 'package:flutter/material.dart';

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
      child: FilledButton(
        onPressed: _isLoading
            ? null
            : () async {
                _changeIsLoading();
                await widget.action();
                _changeIsLoading();
              },
        style: ButtonStyle(
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        child: SizedBox(
          height: 60,
          width: double.infinity,
          child: Center(
            child: _isLoading
                ? CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.background,
                  )
                : Text(
                    widget.text,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
