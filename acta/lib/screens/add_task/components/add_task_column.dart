import 'package:acta/screens/add_task/components/color_input.dart';
import 'package:acta/screens/add_task/components/date_input.dart';
import 'package:acta/screens/add_task/components/list_input.dart';
import 'package:acta/screens/add_task/components/task_state.dart';
import 'package:acta/screens/add_task/components/time_input.dart';
import 'package:acta/screens/add_task/components/title_input.dart';
import 'package:acta/servicies/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddTaskColumn extends StatelessWidget {
  const AddTaskColumn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color iconColor = Theme.of(context).brightness == Brightness.dark
        ? darken(Theme.of(context).textTheme.bodyText1!.color!, 0.2)
        : lighten(Theme.of(context).textTheme.bodyText1!.color!);
    Color widgetColor = Theme.of(context).brightness == Brightness.dark
        ? lighten(Theme.of(context).scaffoldBackgroundColor, 0.2)
        : Theme.of(context).scaffoldBackgroundColor;
    BoxDecoration widgetDecoration = const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 1.5, offset: Offset(1, 1))],
    );

    final task = Provider.of<TaskState>(context);
    return Column(
      children: [
        TitleInput(
          hint: 'Enter new task',
          controller: task.name,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                    ? lighten(Theme.of(context).scaffoldBackgroundColor)
                    : darken(Theme.of(context).scaffoldBackgroundColor, 0.15),
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text('Category', style: Theme.of(context).textTheme.bodyText1),
                      ListInput(
                        backgroundColor: widgetColor,
                        decoration: widgetDecoration,
                        iconColor: iconColor,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: [
                        Text('Due Date', style: Theme.of(context).textTheme.bodyText1),
                        const Spacer(),
                        DateInput(
                          decoration: widgetDecoration.copyWith(color: widgetColor),
                          iconColor: iconColor,
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: [
                        Text('Due Time', style: Theme.of(context).textTheme.bodyText1),
                        const Spacer(),
                        TimeInput(
                          decoration: widgetDecoration.copyWith(color: widgetColor),
                          iconColor: iconColor,
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Text('Color', style: Theme.of(context).textTheme.bodyText1),
                      const Spacer(),
                      const ColorInput(),
                    ],
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
