import 'package:acta/to_do/servicies/api/api.dart';
import 'package:acta/to_do/servicies/api/models.dart';
import 'package:flutter/material.dart';

class ApiState with ChangeNotifier {
  ApiUser? current;

  void updateUser(ApiUser? newUser) {
    current = newUser;
    notifyListeners();
  }

  Future<void> asyncUpdateUser() async {
    current = await userinfo();
    notifyListeners();
  }
}
