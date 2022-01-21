import 'package:acta/components/custom_checkbox.dart';
import 'package:acta/screens/task/task.dart';
import 'package:acta/servicies/api.dart';
import 'package:acta/servicies/user/api_state.dart';
import 'package:acta/servicies/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({
    Key? key,
    required this.task,
    required this.taskList,
  }) : super(key: key);

  final ApiTask task;
  final ApiList taskList;

  @override
  Widget build(BuildContext context) {
    var taskBackground = Theme.of(context).brightness == Brightness.dark
        ? lighten(Theme.of(context).scaffoldBackgroundColor, 0.15)
        : darken(Theme.of(context).scaffoldBackgroundColor, 0.12);
    return Stack(
      children: [
        Center(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 6.0),
            width: 1000,
            height: 50,
            decoration: const BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Icon(context.platformIcons.delete, color: Colors.white),
                  const Spacer(),
                  Icon(context.platformIcons.delete, color: Colors.white),
                ],
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TaskPage(pageTask: task, taskList: taskList)),
          ),
          child: Dismissible(
            key: Key(task.id),
            onDismissed: (direction) async {
              Provider.of<ApiState>(context, listen: false).updateUser(await deleteTask(task.id));
            },
            child: Container(
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
                  Text(
                    task.name,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
