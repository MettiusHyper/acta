import 'package:acta/to_do/screens/edit_list/edit_list.dart';
import 'package:acta/to_do/servicies/user/api_state.dart';
import 'package:acta/to_do/widgets/list_widget/components/button_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';

class EditListButton extends StatelessWidget {
  const EditListButton({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<ApiState>(context);
    final optionButtons = Provider.of<ButtonState>(context);

    return AnimatedOpacity(
      opacity: optionButtons.current ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 100),
      child: Align(
        alignment: Alignment.topRight,
        child: FloatingActionButton.small(
          heroTag: user.current!.lists[index].id + 'edit',
          backgroundColor: Colors.blue,
          elevation: 3,
          child: Icon(
            context.platformIcons.edit,
            color: const Color(0xffefefef),
            size: 20,
          ),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => EditList(editList: user.current!.lists[index])));
            optionButtons.updateButton(value: false);
          },
        ),
      ),
    );
  }
}
