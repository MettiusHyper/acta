import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

PlatformAppBar customAppBar(
    {required BuildContext context, String? title, Widget? trailingCupertino, bool backButton = false}) {
  return PlatformAppBar(
    title: title != null
        ? FractionallySizedBox(
            widthFactor: 0.95,
            child: Text(
              title,
              style: Theme.of(context).textTheme.headline1,
              softWrap: false,
              overflow: TextOverflow.fade,
            ),
          )
        : null,
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    material: (_, __) => MaterialAppBarData(
        elevation: 0,
        leading: backButton
            ? GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  context.platformIcons.back,
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
              )
            : null),
    cupertino: (_, __) => CupertinoNavigationBarData(
        border: const Border(bottom: BorderSide(color: Colors.transparent)),
        trailing: trailingCupertino,
        leading: backButton
            ? GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  context.platformIcons.back,
                  color: Colors.blue,
                  size: 26,
                ),
              )
            : null),
  );
}
