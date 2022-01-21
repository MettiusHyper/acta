import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class TitleInput extends StatelessWidget {
  const TitleInput({Key? key, this.hint, this.controller}) : super(key: key);
  final String? hint;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return PlatformTextField(
      hintText: hint,
      style: Theme.of(context).textTheme.bodyText1,
      controller: controller,
      cupertino: (_, __) => CupertinoTextFieldData(decoration: const BoxDecoration(color: Colors.transparent)),
      material: (_, __) => MaterialTextFieldData(decoration: const InputDecoration(border: InputBorder.none)),
    );
  }
}
