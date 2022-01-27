import 'package:acta/to_do/screens/add_list/components/list_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';

class ListColorInput extends StatelessWidget {
  const ListColorInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final list = Provider.of<ListState>(context);

    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              titlePadding: const EdgeInsets.all(0),
              contentPadding: const EdgeInsets.all(0),
              content: SingleChildScrollView(
                child: ColorPicker(
                  pickerColor: list.color,
                  onColorChanged: (color) {
                    list.update(newColor: color);
                  },
                  colorPickerWidth: 300,
                  pickerAreaHeightPercent: 0.7,
                  enableAlpha: false,
                  pickerAreaBorderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(2),
                    topRight: Radius.circular(2),
                  ),
                ),
              ),
            );
          },
        );
      },
      child: Container(
        margin: const EdgeInsets.all(7),
        height: 48,
        width: 48,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: list.color,
        ),
      ),
    );
  }
}
