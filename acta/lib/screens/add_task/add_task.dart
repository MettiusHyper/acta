import 'package:acta/components/custom_app_bar.dart';
import 'package:acta/screens/add_task/components/add_task_column.dart';
import 'package:acta/screens/add_task/components/add_task_pop.dart';
import 'package:acta/screens/add_task/components/task_state.dart';
import 'package:acta/servicies/user/api_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';

class AddTask extends StatelessWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TaskState>(
      create: (_) => TaskState(),
      builder: (context, _) {
        //initialization
        final user = Provider.of<ApiState>(context);
        final task = Provider.of<TaskState>(context);
        Future.delayed(Duration.zero, () {
          if (task.list == null) {
            task.initTask(user.current!.defaultList);
          }
        });
        return task.list == null
            ? Center(child: PlatformCircularProgressIndicator())
            : PlatformScaffold(
                appBar: customAppBar(
                  context: context,
                  backButton: true,
                  trailingCupertino: GestureDetector(
                    onTap: () async => addTaskAndPop(context),
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
                    onPressed: () async => addTaskAndPop(context),
                    backgroundColor: Theme.of(context).primaryColor,
                    child: const Icon(Icons.check, color: Colors.white),
                  ),
                ),
              );
      },
    );
  }
}
