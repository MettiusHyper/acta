import 'package:acta/servicies/api/models.dart';
import 'package:flutter/material.dart';

class ListState with ChangeNotifier {
  TextEditingController name = TextEditingController();
  Color color = const Color(0xff6fbf92);
  String emoji = '😀';

  void update({String? newName, Color? newColor, String? newEmoji}) {
    if (newName != null) name.text = newName;
    if (newColor != null) color = newColor;
    if (newEmoji != null) emoji = newEmoji;
    notifyListeners();
  }

  ApiList createList() {
    return ApiList(name.text, color, emoji);
  }
}
