import 'package:acta/screens/add_list/components/emoji_input.dart';
import 'package:acta/screens/add_list/components/list_color_input.dart';
import 'package:acta/screens/add_list/components/list_state.dart';
import 'package:acta/screens/add_task/components/title_input.dart';
import 'package:acta/servicies/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddListColumn extends StatelessWidget {
  const AddListColumn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final list = Provider.of<ListState>(context);
    return Column(
      children: [
        TitleInput(
          hint: 'Enter new list',
          controller: list.name,
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
                      Text('Color', style: Theme.of(context).textTheme.bodyText1),
                      const Spacer(),
                      const ListColorInput(),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 4)),
                  Row(
                    children: [
                      Text('Emoji', style: Theme.of(context).textTheme.bodyText1),
                      const Spacer(),
                      const EmojiInput(),
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
