import 'package:flutter/material.dart';

class ButtonState with ChangeNotifier {
  bool current = false;

  void updateButton({bool? value}) {
    if (value != null) {
      current = value;
    } else {
      current = !current;
    }
    notifyListeners();
  }
}
