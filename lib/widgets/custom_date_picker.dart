import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prev_ler/widgets/custom_text_field.dart';

class CustomDatePicker extends StatefulWidget {
  final String labelText;
  final TextEditingController controller;
  final TextEditingController selectedDate;
  final BuildContext context;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? enable;

  const CustomDatePicker({
    super.key,
    required this.labelText,
    required this.controller,
    required this.context,
    required this.selectedDate,
    this.enable,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      enable: widget.enable,
      controller: widget.controller,
      labelText: widget.labelText,
      prefixIcon: widget.prefixIcon,
      suffixIcon: _suffixIcon(),
      onTap: _onTap,
    );
  }

  IconButton? _suffixIcon() {
    if (widget.controller.text.isEmpty) {
      return null;
    }

    return IconButton(
      icon: const Icon(Icons.clear_outlined),
      onPressed: () {
        setState(() {
          widget.selectedDate.text = '';
          widget.controller.text = '';
        });
      },
    );
  }

  _onTap() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime(2035),
    );

    if (date != null) {
      setState(() {
        widget.selectedDate.text = date.toString();
        widget.controller.text = DateFormat('dd/MM/yyyy').format(date);
      });
    }
  }
}
