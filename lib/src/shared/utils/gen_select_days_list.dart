import 'package:prev_ler/src/shared/entities/day_of_week.dart';
import 'package:prev_ler/src/shared/entities/routine.dart';
import 'package:prev_ler/src/shared/entities/week_days.dart';

bool _checkIfIsSelected(
  List<DayOfWeek?>? routineWeekdays,
  DayOfWeek currDayOfWeek,
) {
  try {
    final foundDayOfWeek = routineWeekdays?.firstWhere(
      (wd) => wd?.enumName == currDayOfWeek.enumName,
    );
    return foundDayOfWeek == null ? false : true;
  } catch (e) {
    return false;
  }
}

List<bool> generateSelectedDaysFromRoutine(Routine routine) {
  final selectedDays = daysOfWeek.map(
    (e) => _checkIfIsSelected(routine.weekdays, e),
  );

  return selectedDays.toList();
}
