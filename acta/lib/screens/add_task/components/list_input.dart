import 'package:acta/screens/add_list/add_list.dart';
import 'package:acta/screens/add_task/components/task_state.dart';
import 'package:acta/servicies/api/models.dart';
import 'package:acta/servicies/user/api_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

class ListInput extends StatelessWidget {
  const ListInput({Key? key, required this.backgroundColor, required this.decoration, this.iconColor})
      : super(key: key);
  final BoxDecoration decoration;
  final Color backgroundColor;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    //initialization
    final user = Provider.of<ApiState>(context);
    final task = Provider.of<TaskState>(context);
    List<PopupMenuOption> listOptions = user.current!.lists.map<PopupMenuOption>((ApiList value) {
      return PopupMenuOption(
        label: value.name,
        onTap: (option) => task.update(newList: value),
        material: (_, __) => MaterialPopupMenuOptionData(textStyle: Theme.of(context).textTheme.bodyText1),
      );
    }).toList();
    listOptions.add(PopupMenuOption(
      label: '+ Create List',
      onTap: (option) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AddList()),
      ),
      material: (_, __) => MaterialPopupMenuOptionData(textStyle: Theme.of(context).textTheme.bodyText1),
    ));

    return Expanded(
      child: PlatformPopupMenu(
        options: listOptions,
        icon: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Spacer(),
            Container(
              decoration: decoration.copyWith(color: backgroundColor),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: SizedBox(
                        height: 15,
                        width: 15,
                        child: RoundCheckBox(
                          onTap: (value) {},
                          border: Border.all(
                            color: task.list!.color,
                            width: 4,
                          ),
                          uncheckedColor: backgroundColor,
                          checkedColor: backgroundColor,
                          animationDuration: const Duration(milliseconds: 150),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: Text(task.list!.name, style: Theme.of(context).textTheme.subtitle1),
                    ),
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: iconColor,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
        material: (_, __) => MaterialPopupMenuData(padding: EdgeInsets.zero),
      ),
    );
  }
}
