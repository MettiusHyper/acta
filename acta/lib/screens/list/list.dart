import 'package:acta/components/custom_app_bar.dart';
import 'package:acta/widgets/task_widget/task_widget.dart';
import 'package:acta/servicies/user/api_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';

class ListPage extends StatelessWidget {
  const ListPage({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<ApiState>(context);

    return PlatformScaffold(
      appBar: customAppBar(
        context: context,
        title: user.current!.lists[index].name,
        backButton: true,
      ),
      body: SizedBox(
        height: 65.0 * user.current!.lists[index].tasks.length,
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(8),
          itemCount: user.current!.lists[index].tasks.length,
          itemBuilder: (BuildContext context, int taskIndex) {
            return TaskWidget(
              task: user.current!.lists[index].tasks[taskIndex],
              taskList: user.current!.lists[index],
            );
          },
        ),
      ),
    );
  }
}
