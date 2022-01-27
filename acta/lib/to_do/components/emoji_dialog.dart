import 'package:acta/constants/emojis.dart';
import 'package:acta/to_do/screens/add_list/components/list_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';

void emojiDialog(BuildContext context) {
  final list = Provider.of<ListState>(context, listen: false);

  List<Widget> generateEmojiPage(Map<String, String> emojiMap) {
    List<Widget> returnList = [];
    emojiMap.forEach((name, emoji) => returnList.add(Tooltip(
          message: name,
          child: GestureDetector(
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
          ),
        )));
    return returnList;
  }

  int emojiPageIndex = 0;
  List<List<Widget>> emojisWidget = emojis.values.map<List<Widget>>((entry) => generateEmojiPage(entry)).toList();
  List<Widget> currentEmojis = emojisWidget[emojiPageIndex];
  List<Widget> foundEmoji = [];
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(builder: (context, setState) {
        void searchEmoji(String key) {
          if (key.isEmpty) {
            setState(() => foundEmoji = []);
          } else {
            var validKeys = allEmojis.keys.where((name) => name.toLowerCase().contains(key.toLowerCase()));
            var validEmojis = {for (var key in validKeys) key: allEmojis[key]!};
            setState(() {
              foundEmoji = generateEmojiPage(validEmojis);
            });
          }
        }

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
                  padding: const EdgeInsets.all(8.0),
                  child: PlatformTextField(
                    hintText: 'Search emoji',
                    onChanged: (text) => {searchEmoji(text)},
                    style: Theme.of(context).textTheme.bodyText1,
                    cupertino: (_, __) =>
                        CupertinoTextFieldData(decoration: const BoxDecoration(color: Colors.transparent)),
                    material: (_, __) =>
                        MaterialTextFieldData(decoration: const InputDecoration(border: InputBorder.none)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: SizedBox(
                    height: 300,
                    width: 300,
                    child: GridView.count(
                      crossAxisCount: 8,
                      children: foundEmoji.isNotEmpty ? foundEmoji : currentEmojis,
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
}
