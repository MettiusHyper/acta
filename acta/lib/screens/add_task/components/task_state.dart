import 'package:acta/servicies/user/api.dart';
import 'package:flutter/material.dart';

class TaskState with ChangeNotifier {
  TextEditingController name = TextEditingController();
  ApiList? list;
  Color color = const Color(0xff6fbf92);
  DateTime date = DateTime.now();
  TimeOfDay time = TimeOfDay.now();
  bool check = false;

  void initTask(ApiList defaultList) {
    list = defaultList;
    notifyListeners();
  }

  void update(
      {String? newName, ApiList? newList, DateTime? newDate, bool? newCheck, TimeOfDay? newTime, Color? newColor}) {
    if (newName != null) name.text = newName;
    if (newList != null) list = newList;
    if (newDate != null) date = newDate;
    if (newCheck != null) check = newCheck;
    if (newTime != null) time = newTime;
    if (newColor != null) color = newColor;
    notifyListeners();
  }

  ApiTask createTask() {
    return ApiTask(
        name.text, color, '', DateTime(date.year, date.month, date.day, time.hour, time.minute), list!.id, check);
  }
}
