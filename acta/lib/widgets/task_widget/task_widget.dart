import 'package:acta/screens/task/task.dart';
import 'package:acta/servicies/api/models.dart';
import 'package:acta/servicies/api/api.dart';
import 'package:acta/servicies/user/api_state.dart';
import 'package:acta/widgets/task_widget/components/delete_background.dart';
import 'package:acta/widgets/task_widget/components/task_widget_row.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({Key? key, required this.task, required this.taskList}) : super(key: key);

  final ApiTask task;
  final ApiList taskList;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const DeleteBackground(),
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
            child: TaskWidgetRow(task: task),
          ),
        ),
      ],
    );
  }
}
