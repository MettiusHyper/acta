import 'package:acta/to_do/screens/add_task/components/task_state.dart';
import 'package:acta/to_do/servicies/api/api.dart';
import 'package:acta/to_do/servicies/user/api_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';

Future<void> addTaskAndPop(BuildContext context) async {
  final user = Provider.of<ApiState>(context, listen: false);
  final task = Provider.of<TaskState>(context, listen: false);
  if (task.name.text.isEmpty) {
    showPlatformDialog(
      context: context,
      builder: (_) => PlatformAlertDialog(
        title: const Text('Specify a task name'),
        actions: [
          PlatformDialogAction(
            child: const Text('Close'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  } else {
    Navigator.pop(context);
    user.updateUser(await addTask(task.createTask()));
  }
}
