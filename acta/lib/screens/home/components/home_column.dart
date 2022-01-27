import 'dart:math';

import 'package:acta/widgets/list_widget/list_widget.dart';
import 'package:acta/widgets/task_widget/task_widget.dart';
import 'package:acta/servicies/user/api_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeColumn extends StatelessWidget {
  const HomeColumn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<ApiState>(context);

    return Column(
      children: [
        SizedBox(
          height: 65.0 * min(user.current!.defaultList.tasks.length, 3),
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(8),
            itemCount: min(user.current!.defaultList.tasks.length, 3),
            itemBuilder: (BuildContext context, int index) {
              return TaskWidget(
                key: Key("task_widget_btn_${user.current!.defaultList.tasks[index].id}"),
                task: user.current!.defaultList.tasks[index],
                taskList: user.current!.defaultList,
              );
            },
          ),
        ),
        Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            children: List.generate(user.current!.lists.length, (index) {
              return ListWidget(key: Key(user.current!.lists[index].id), index: index);
            }),
          ),
        ),
      ],
    );
  }
}
