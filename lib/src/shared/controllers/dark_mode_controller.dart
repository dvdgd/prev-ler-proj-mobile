
import 'package:flutter/material.dart';

class DarkModeController extends ValueNotifier<bool> {
  DarkModeController() : super(false);

  void toggle() {
    value = !value;
  }
}
