import 'dart:io';

import 'package:acta/servicies/user/api_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';

PlatformAppBar customAppBar(
    {required BuildContext context,
    String? title,
    Widget? trailingCupertino,
    bool backButton = false,
    bool signOutButton = false}) {
  final user = Provider.of<ApiState>(context);

  return PlatformAppBar(
    leading: signOutButton
        ? GestureDetector(
            child: Icon(Icons.logout_rounded,
                color: Platform.isIOS ? Colors.blue : Theme.of(context).textTheme.headline1!.color),
            onTap: () {
              FirebaseAuth.instance.signOut();
              user.updateUser(null);
            },
          )
        : null,
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
                  Icons.arrow_back,
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
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.blue,
                  size: 26,
                ),
              )
            : null),
  );
}
