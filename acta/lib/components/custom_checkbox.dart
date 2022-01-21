import 'package:acta/servicies/api.dart';
import 'package:acta/servicies/user/api_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

class CustomCheckBox extends StatelessWidget {
  const CustomCheckBox({Key? key, required this.task, required this.foregroundColor, required this.backgroundColor})
      : super(key: key);

  final ApiTask task;
  final Color foregroundColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      width: 30,
      child: RoundCheckBox(
        isChecked: task.check,
        onTap: (value) async {
          Provider.of<ApiState>(context, listen: false).updateUser(
              await editTask(task.id, ApiTask(task.name, task.color, task.description, task.date, task.list, value!)));
        },
        border: Border.all(
          color: foregroundColor,
          width: 4,
        ),
        uncheckedColor: backgroundColor,
        checkedColor: backgroundColor,
        checkedWidget: Container(
          decoration: BoxDecoration(
              color: foregroundColor,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              border: Border.all(color: backgroundColor, width: 3)),
        ),
        animationDuration: const Duration(milliseconds: 150),
      ),
    );
  }
}
