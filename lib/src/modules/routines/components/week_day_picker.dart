import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/date_symbols.dart';
import 'package:prev_ler/src/modules/routines/shared/controllers/week_day_controller.dart';
import 'package:provider/provider.dart';
import 'package:weekday_selector/weekday_selector.dart';

class MyDayOfWeekPicker extends StatelessWidget {
  const MyDayOfWeekPicker({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<WeekDayController>();

    final DateSymbols pt = dateTimeSymbolMap()['pt_BR'];
    final colorScheme = Theme.of(context).colorScheme;

    return WeekdaySelector(
      fillColor: colorScheme.tertiaryContainer,
      selectedFillColor: colorScheme.tertiary,
      shortWeekdays: pt.NARROWWEEKDAYS,
      onChanged: (int day) {
        final index = day % 7;
        debugPrint('Selected day index: $index');
        debugPrint('Selected days before toggle: ${controller.selectedDays}');
        controller.toggle(index);
        debugPrint('Selected days after toggle: ${controller.selectedDays}');
      },
      values: controller.selectedDays,
    );
  }
}
