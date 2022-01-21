import 'dart:ui';

import 'package:acta/constants/emoji.dart';
import 'package:acta/screens/add_list/components/list_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Map<String, IconData> emojiIcons = {
  'smile': Icons.emoji_emotions_outlined,
  'people': Icons.emoji_people_outlined,
  'accessories': Icons.emoji_events_outlined,
  'nature': Icons.emoji_nature_outlined,
  'food': Icons.emoji_food_beverage_outlined,
  'objects': Icons.emoji_objects_outlined,
  'symbols': Icons.emoji_symbols_outlined,
  'flags': Icons.emoji_flags_outlined
};

class EmojiInput extends StatefulWidget {
  const EmojiInput({Key? key}) : super(key: key);

  @override
  _EmojiInputState createState() => _EmojiInputState();
}

class _EmojiInputState extends State<EmojiInput> {
  @override
  Widget build(BuildContext context) {
    final list = Provider.of<ListState>(context);

    List<List<Widget>> emojisWidget = emojis.values
        .map<List<Widget>>((entry) => entry.map<Widget>((String emoji) {
              return GestureDetector(
                onTap: () {
                  list.update(newEmoji: emoji);
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Text(
                    emoji,
                    style: const TextStyle(fontFamily: 'EmojiOne', fontSize: 22),
                  ),
                ),
              );
            }).toList())
        .toList();

    int emojiPageIndex = 0;
    List<Widget> currentEmojis = emojisWidget[emojiPageIndex];

    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return StatefulBuilder(builder: (context, setState) {
              void updateCurrentEmojis(int index) {
                setState(() {
                  emojiPageIndex = index;
                  currentEmojis = emojisWidget[index];
                });
              }

              List<Widget> emojisOptions = emojis.keys
                  .toList()
                  .map<Widget>((key) => GestureDetector(
                        onTap: () {
                          updateCurrentEmojis(emojis.keys.toList().indexOf(key));
                        },
                        child: SizedBox(
                            height: 48,
                            child: Icon(
                              emojiIcons[key],
                              color: emojiPageIndex == emojis.keys.toList().indexOf(key)
                                  ? Colors.blue
                                  : Theme.of(context).textTheme.headline1!.color,
                            )),
                      ))
                  .toList();

              return AlertDialog(
                titlePadding: const EdgeInsets.all(0),
                contentPadding: const EdgeInsets.all(0),
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: SizedBox(
                          height: 300,
                          width: 300,
                          child: GridView.count(
                            crossAxisCount: 8,
                            children: currentEmojis,
                          ),
                        ),
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: emojisOptions,
                      )
                    ],
                  ),
                ),
              );
            });
          },
        );
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
