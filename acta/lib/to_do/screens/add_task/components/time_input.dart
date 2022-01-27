import 'package:acta/to_do/screens/add_task/components/task_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:platform_date_picker/platform_date_picker.dart' as platform_date_picker;

class TimeInput extends StatelessWidget {
  const TimeInput({Key? key, this.decoration, this.iconColor}) : super(key: key);
  final BoxDecoration? decoration;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final task = Provider.of<TaskState>(context);
    return Container(
      decoration: decoration,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          child: Row(
            children: [
              Text(
                task.time.format(context),
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Icon(
                Icons.keyboard_arrow_down,
                color: iconColor,
              )
            ],
          ),
          onTap: () {
            platform_date_picker
                .showPlatformTimePicker(
              context: context,
              initialTime: task.time,
              builder: (BuildContext context, Widget? child) {
                return Theme(
                  data: Theme.of(context).brightness == Brightness.dark
                      ? ThemeData.dark().copyWith(
                          brightness: Brightness.dark,
                          colorScheme: ColorScheme.dark(primary: Theme.of(context).primaryColor),
                        )
                      : ThemeData.light().copyWith(
                          colorScheme: ColorScheme.light(primary: Theme.of(context).primaryColor),
                        ),
                  child: child!,
                );
              },
            )
                .then((value) {
              if (value != null) {
                task.update(newTime: value);
              }
            });
          },
        ),
      ),
    );
  }
}
