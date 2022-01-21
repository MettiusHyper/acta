import 'package:acta/components/custom_app_bar.dart';
import 'package:acta/screens/add_task/components/add_task_column.dart';
import 'package:acta/screens/add_task/components/task_state.dart';
import 'package:acta/screens/task/componets/edit_task_pop.dart';
import 'package:acta/servicies/user/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({Key? key, required this.pageTask, required this.taskList}) : super(key: key);
  final ApiList taskList;
  final ApiTask pageTask;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TaskState>(
      create: (_) => TaskState(),
      builder: (context, _) {
        //initialization
        final task = Provider.of<TaskState>(context);
        Future.delayed(Duration.zero, () {
          if (task.list == null) {
            task.initTask(taskList);
            task.update(
              newName: pageTask.name,
              newDate: pageTask.date,
              newColor: pageTask.color,
              newCheck: pageTask.check,
              newTime: TimeOfDay.fromDateTime(pageTask.date),
            );
          }
        });
        return task.list == null
            ? Center(child: PlatformCircularProgressIndicator())
            : PlatformScaffold(
                appBar: customAppBar(
                  context: context,
                  backButton: true,
                  trailingCupertino: GestureDetector(
                    onTap: () async => editTaskAndPop(context, pageTask.id),
                    child: const Icon(Icons.check, size: 25, color: Colors.blue),
                  ),
                ),
                body: const SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: AddTaskColumn(),
                  ),
                ),
                material: (_, __) => MaterialScaffoldData(
                  floatingActionButton: FloatingActionButton(
                    onPressed: () async => editTaskAndPop(context, pageTask.id),
                    backgroundColor: Theme.of(context).primaryColor,
                    child: const Icon(Icons.check, color: Colors.white),
                  ),
                ),
              );
      },
    );
  }
}
