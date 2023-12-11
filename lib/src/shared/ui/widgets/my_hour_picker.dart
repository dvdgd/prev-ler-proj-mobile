import 'package:flutter/material.dart';
import 'package:prev_ler/src/shared/ui/widgets/my_text_form_field.dart';

class MyHourPicker extends StatefulWidget {
  final String labelText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? enable;
  final String? Function(String? text)? validator;
  final ValueNotifier<TimeOfDay> selectedTime;

  const MyHourPicker({
    super.key,
    required this.labelText,
    required this.selectedTime,
    this.enable,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
  });

  @override
  State<MyHourPicker> createState() => _MyHourPickerState();
}

class _MyHourPickerState extends State<MyHourPicker> {
  final _durationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final selectedTimeOfDay = widget.selectedTime.value;
    if (mounted) {
      _durationController.text = selectedTimeOfDay.format(context);
    }

    return MyTextFormField(
      readOnly: true,
      controller: _durationController,
      validator: widget.validator,
      enable: widget.enable,
      labelText: widget.labelText,
      prefixIcon: widget.prefixIcon,
      onTap: _onTap,
    );
  }

  _onTap() async {
    final timeOfDay = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (timeOfDay != null && context.mounted) {
      widget.selectedTime.value = timeOfDay;
      _durationController.text = timeOfDay.format(context);
    }
  }
}
