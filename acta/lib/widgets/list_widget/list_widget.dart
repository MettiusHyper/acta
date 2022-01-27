import 'package:acta/screens/list/list.dart';
import 'package:acta/widgets/list_widget/components/button_state.dart';
import 'package:acta/widgets/list_widget/components/delete_list_button.dart';
import 'package:acta/widgets/list_widget/components/edit_list_button.dart';
import 'package:acta/widgets/list_widget/components/list_column.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListWidget extends StatefulWidget {
  const ListWidget({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  _ListWidgetState createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ButtonState>(
        create: (_) => ButtonState(),
        builder: (context, _) {
          final optionButtons = Provider.of<ButtonState>(context);

          return GestureDetector(
            onTap: () {
              optionButtons.updateButton(value: false);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ListPage(index: widget.index)),
              );
            },
            onLongPress: () {
              optionButtons.updateButton();
            },
            child: Stack(
              children: [
                ListColumn(index: widget.index),
                DeleteListButton(index: widget.index),
                EditListButton(index: widget.index)
              ],
            ),
          );
        });
  }
}
