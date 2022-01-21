import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: const Color(0xfff8c05c),
  scaffoldBackgroundColor: const Color(0xffffffff),
  textTheme: const TextTheme(
    headline1: TextStyle(color: Color(0xff3a3b3d), fontSize: 26, fontWeight: FontWeight.w500, letterSpacing: 0),
    bodyText1: TextStyle(color: Color(0xff3a3b3d), fontSize: 20, fontWeight: FontWeight.w500),
    subtitle1: TextStyle(color: Color(0xff3a3b3d), fontSize: 18, fontWeight: FontWeight.w500),
  ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: const Color(0xfff8c05c),
  scaffoldBackgroundColor: const Color(0xff292b30),
  highlightColor: const Color(0xff363940),
  textTheme: const TextTheme(
    headline1: TextStyle(color: Color(0xffefefef), fontSize: 26, fontWeight: FontWeight.w500, letterSpacing: 0),
    bodyText1: TextStyle(color: Color(0xffefefef), fontSize: 20, fontWeight: FontWeight.w500),
    subtitle1: TextStyle(color: Color(0xffefefef), fontSize: 18, fontWeight: FontWeight.w500),
  ),
  cupertinoOverrideTheme: const CupertinoThemeData(
    textTheme: CupertinoTextThemeData(),
  ),
);
