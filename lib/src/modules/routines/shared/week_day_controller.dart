import 'package:flutter/material.dart';

class WeekDayController extends ChangeNotifier {
  List<bool> selectedDays = List.generate(7, (index) => false);

  void toggle(int index) {
    selectedDays[index] = !selectedDays[index];
    notifyListeners();
  }

  void fromList(List<bool> fromSelectedDays) {
    selectedDays = fromSelectedDays.getRange(0, 7).toList();
    notifyListeners();
  }

  void disableAll() {
    selectedDays = List.generate(7, (_) => false);
  }

  void enableAll() {
    selectedDays = List.generate(7, (index) => true);
  }
}
