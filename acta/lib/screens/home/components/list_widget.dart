import 'package:acta/screens/edit_list/edit_list.dart';
import 'package:acta/screens/list/list.dart';
import 'package:acta/servicies/user/api.dart';
import 'package:acta/servicies/user/api_state.dart';
import 'package:acta/servicies/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';

class ListWidget extends StatefulWidget {
  const ListWidget({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  _ListWidgetState createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  bool deleteButton = false;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<ApiState>(context);

    return GestureDetector(
      onTap: () {
        setState(() {
          deleteButton = false;
        });
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ListPage(index: widget.index)),
        );
      },
      onLongPress: () {
        setState(() {
          deleteButton = !deleteButton;
        });
      },
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: lighten(user.current!.lists[widget.index].color,
                    Theme.of(context).brightness == Brightness.dark ? 0.08 : 0.13),
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Material(
                    color: Colors.transparent,
                    child: Text(
                      user.current!.lists[widget.index].emoji,
                      style: const TextStyle(fontSize: 48),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: LayoutBuilder(builder: (context, contrains) {
                      int i = 0;
                      int checked = 0;
                      for (var e in user.current!.lists[widget.index].tasks) {
                        {
                          if (e.check == true) checked++;
                        }
                      }

                      return Row(
                        children: user.current!.lists[widget.index].tasks.map<Widget>((task) {
                          Widget w = Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: i < checked ? Theme.of(context).primaryColor : Colors.grey.shade400,
                                  borderRadius: const BorderRadius.all(Radius.circular(4))),
                              height: 8,
                              width: (contrains.maxWidth / user.current!.lists[widget.index].tasks.length) - 4,
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
          ),
          AnimatedOpacity(
            opacity: deleteButton ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 100),
            child: Align(
              alignment: Alignment.topLeft,
              child: user.current!.lists[widget.index].id != user.current!.defaultList.id
                  ? FloatingActionButton.small(
                      heroTag: user.current!.lists[widget.index].id,
                      backgroundColor: Colors.red,
                      elevation: 3,
                      child: Icon(
                        context.platformIcons.remove,
                        color: const Color(0xffefefef),
                        size: 20,
                      ),
                      onPressed: () {
                        showPlatformDialog(
                          context: context,
                          builder: (_) => PlatformAlertDialog(
                            title: const Text('Delete list'),
                            content: const Text('All tasks in the list will be deleted'),
                            actions: [
                              PlatformDialogAction(
                                child: const Text('Close'),
                                onPressed: () => Navigator.pop(context),
                              ),
                              PlatformDialogAction(
                                child: const Text('Delete'),
                                onPressed: () {
                                  deletelist(user.current!.lists[widget.index].id)
                                      .then((value) => {user.updateUser(value)});
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  : Container(),
            ),
          ),
          AnimatedOpacity(
            opacity: deleteButton ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 100),
            child: Align(
              alignment: Alignment.topRight,
              child: FloatingActionButton.small(
                heroTag: user.current!.lists[widget.index].id + 'edit',
                backgroundColor: Colors.blue,
                elevation: 3,
                child: Icon(
                  context.platformIcons.edit,
                  color: const Color(0xffefefef),
                  size: 20,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => EditList(editList: user.current!.lists[widget.index])));
                  setState(() {
                    deleteButton = !deleteButton;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
