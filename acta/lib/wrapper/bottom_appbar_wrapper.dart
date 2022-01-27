import 'dart:io';

import 'package:acta/account/account.dart';
import 'package:acta/constants/acta_icons_icons.dart';
import 'package:acta/to_do/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class BottomAppbarWrapper extends StatefulWidget {
  const BottomAppbarWrapper({Key? key}) : super(key: key);
  @override
  _BottomAppbarWrapperState createState() => _BottomAppbarWrapperState();
}

class _BottomAppbarWrapperState extends State<BottomAppbarWrapper> {
  List<Widget> pages = [
    const Home(),
    const Account(),
  ];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      body: pages.elementAt(currentIndex),
      bottomNavBar: PlatformNavBar(
        currentIndex: currentIndex,
        itemChanged: (i) => setState(
          () {
            currentIndex = i;
          },
        ),
        items: [
          BottomNavigationBarItem(icon: const Icon(ActaIcons.logo), label: Platform.isAndroid ? 'to do' : null),
          BottomNavigationBarItem(
              icon: Icon(context.platformIcons.accountCircle), label: Platform.isAndroid ? 'account' : null)
        ],
        material: (_, __) => MaterialNavBarData(
          elevation: 0,
          selectedItemColor: Theme.of(context).primaryColor,
          iconSize: 28,
          showSelectedLabels: false,
          showUnselectedLabels: false,
        ),
      ),
    );
  }
}
