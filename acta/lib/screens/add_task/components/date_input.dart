import 'package:acta/screens/add_task/components/task_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DateInput extends StatelessWidget {
  const DateInput({Key? key, this.decoration, this.iconColor}) : super(key: key);
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
                DateFormat('MMM dd yyyy').format(task.date),
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Icon(
                Icons.keyboard_arrow_down,
                color: iconColor,
              )
            ],
          ),
          onTap: () {
            showPlatformDatePicker(
              context: context,
              initialDate: task.date,
              firstDate: DateTime.now().subtract(const Duration(days: 1000)),
              lastDate: DateTime.now().add(const Duration(days: 1000)),
              material: (_, __) => MaterialDatePickerData(
                builder: (BuildContext context, Widget? child) {
                  return Theme(
                    data: Theme.of(context).brightness == Brightness.dark
                        ? ThemeData.dark().copyWith(
                            brightness: Brightness.dark,
                            colorScheme: ColorScheme.dark(
                                primary: Theme.of(context).primaryColor, surface: Theme.of(context).primaryColor),
                          )
                        : ThemeData.light().copyWith(
                            colorScheme: ColorScheme.light(primary: Theme.of(context).primaryColor),
                          ),
                    child: child!,
                  );
                },
              ),
            ).then((value) {
              if (value != null) {
                task.update(newDate: value);
              }
            });
          },
        ),
      ),
    );
  }
}
