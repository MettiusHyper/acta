import 'package:acta/screens/add_task/components/task_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';

class ColorInput extends StatelessWidget {
  const ColorInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final task = Provider.of<TaskState>(context);

    return BlockPicker(
        pickerColor: task.color,
        availableColors: const [Color(0xffeb5363), Color(0xfff5a05c), Color(0xff6fbf92)],
        layoutBuilder: (context, colors, child) {
          Orientation orientation = MediaQuery.of(context).orientation;
          return SizedBox(
            width: orientation == Orientation.portrait ? 200 : 400,
            height: 70,
            child: GridView.count(
              crossAxisCount: orientation == Orientation.portrait ? 3 : 6,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              children: [for (Color color in colors) child(color)],
            ),
          );
        },
        itemBuilder: (Color color, bool isCurrentColor, void Function() changeColor) {
          return Container(
            margin: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: changeColor,
                borderRadius: BorderRadius.circular(50),
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 210),
                  opacity: isCurrentColor ? 1 : 0,
                  child: Icon(Icons.done, color: Theme.of(context).textTheme.headline1!.color),
                ),
              ),
            ),
          );
        },
        onColorChanged: (color) {
          task.update(newColor: color);
        });
  }
}
