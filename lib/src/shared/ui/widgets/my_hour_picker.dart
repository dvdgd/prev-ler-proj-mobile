import 'package:flutter/material.dart';
import 'package:prev_ler/src/shared/ui/widgets/my_text_form_field.dart';

class MyHourPicker extends StatefulWidget {
  final String labelText;
  final TextEditingController controller;
  final TextEditingController selectedDate;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? enable;
  final String? Function(String? text)? validator;

  const MyHourPicker({
    super.key,
    required this.labelText,
    required this.controller,
    required this.selectedDate,
    this.enable,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
  });

  @override
  State<MyHourPicker> createState() => _MyHourPickerState();
}

class _MyHourPickerState extends State<MyHourPicker> {
  @override
  Widget build(BuildContext context) {
    return MyTextFormField(
      readOnly: true,
      validator: widget.validator,
      enable: widget.enable,
      controller: widget.controller,
      labelText: widget.labelText,
      prefixIcon: widget.prefixIcon,
      suffixIcon: widget.controller.text.isEmpty
          ? null
          : IconButton(
              icon: const Icon(Icons.clear_outlined),
              onPressed: () {
                setState(() {
                  widget.selectedDate.text = '';
                  widget.controller.text = '';
                });
              },
            ),
      onTap: _onTap,
    );
  }

  _onTap() async {
    final timeOfDay = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (timeOfDay != null) {
      setState(() {
        widget.selectedDate.text = timeOfDay.toString();
        widget.controller.text = timeOfDay.toString();
      });
    }
  }
}
