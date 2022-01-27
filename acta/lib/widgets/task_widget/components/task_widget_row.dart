import 'package:acta/components/custom_checkbox.dart';
import 'package:acta/servicies/api/models.dart';
import 'package:acta/servicies/utils.dart';
import 'package:flutter/material.dart';

class TaskWidgetRow extends StatelessWidget {
  const TaskWidgetRow({Key? key, required this.task}) : super(key: key);

  final ApiTask task;

  @override
  Widget build(BuildContext context) {
    var taskBackground = Theme.of(context).brightness == Brightness.dark
        ? lighten(Theme.of(context).scaffoldBackgroundColor, 0.15)
        : darken(Theme.of(context).scaffoldBackgroundColor, 0.12);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      decoration: BoxDecoration(
        color: taskBackground,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      height: 50,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: CustomCheckBox(
              task: task,
              foregroundColor: task.color,
              backgroundColor: taskBackground,
            ),
          ),
          Expanded(
            child: Text(
              task.name,
              maxLines: 2,
              style: Theme.of(context).textTheme.bodyText1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
