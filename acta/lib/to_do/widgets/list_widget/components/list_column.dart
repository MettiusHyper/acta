import 'package:acta/to_do/servicies/user/api_state.dart';
import 'package:acta/to_do/servicies/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListColumn extends StatelessWidget {
  const ListColumn({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<ApiState>(context);

    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color:
              lighten(user.current!.lists[index].color, Theme.of(context).brightness == Brightness.dark ? 0.08 : 0.13),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Material(
              color: Colors.transparent,
              child: Text(
                user.current!.lists[index].emoji,
                style: const TextStyle(fontSize: 48),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 4),
              child: LayoutBuilder(builder: (context, contrains) {
                int i = 0;
                int checked = 0;
                for (var e in user.current!.lists[index].tasks) {
                  {
                    if (e.check == true) checked++;
                  }
                }

                return Row(
                  children: user.current!.lists[index].tasks.map<Widget>((task) {
                    Widget w = Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: Container(
                        decoration: BoxDecoration(
                            color: i < checked ? Theme.of(context).primaryColor : Colors.grey.shade400,
                            borderRadius: const BorderRadius.all(Radius.circular(4))),
                        height: 8,
                        width: (contrains.maxWidth / user.current!.lists[index].tasks.length) - 4,
                      ),
                    );
                    i++;
                    return w;
                  }).toList(),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
