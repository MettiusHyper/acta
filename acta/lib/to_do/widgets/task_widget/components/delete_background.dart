import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:flutter_platform_widgets/src/platform_icons.dart';

class DeleteBackground extends StatelessWidget {
  const DeleteBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6.0),
        height: 50,
        decoration: const BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Icon(context.platformIcons.delete, color: Colors.white),
              const Spacer(),
              Icon(context.platformIcons.delete, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
