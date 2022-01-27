import 'package:acta/components/emoji_dialog.dart';
import 'package:acta/screens/add_list/components/list_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmojiInput extends StatefulWidget {
  const EmojiInput({Key? key}) : super(key: key);

  @override
  _EmojiInputState createState() => _EmojiInputState();
}

class _EmojiInputState extends State<EmojiInput> {
  @override
  Widget build(BuildContext context) {
    final list = Provider.of<ListState>(context);

    return GestureDetector(
      onTap: () {
        emojiDialog(context);
      },
      child: Material(
        type: MaterialType.transparency,
        child: Container(
          margin: const EdgeInsets.all(7),
          height: 62,
          width: 48,
          child: Text(
            list.emoji, // emoji characters
            style: const TextStyle(fontSize: 42, fontStyle: FontStyle.normal),
          ),
        ),
      ),
    );
  }
}
