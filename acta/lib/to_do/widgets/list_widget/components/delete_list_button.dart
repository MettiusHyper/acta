import 'package:acta/to_do/servicies/api/api.dart';
import 'package:acta/to_do/servicies/user/api_state.dart';
import 'package:acta/to_do/widgets/list_widget/components/button_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';

class DeleteListButton extends StatelessWidget {
  const DeleteListButton({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<ApiState>(context);
    final optionButtons = Provider.of<ButtonState>(context);

    return AnimatedOpacity(
      opacity: optionButtons.current ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 100),
      child: Align(
        alignment: Alignment.topLeft,
        child: user.current!.lists[index].id != user.current!.defaultList.id
            ? FloatingActionButton.small(
                heroTag: user.current!.lists[index].id,
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
                            deletelist(user.current!.lists[index].id).then((value) => {user.updateUser(value)});
                            Navigator.pop(context);
                            optionButtons.updateButton(value: false);
                          },
                        ),
                      ],
                    ),
                  );
                },
              )
            : Container(),
      ),
    );
  }
}
