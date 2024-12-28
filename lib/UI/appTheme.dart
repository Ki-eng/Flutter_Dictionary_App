import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  scaffoldBackgroundColor: Colors.blueGrey.shade900,
  primaryColor: Colors.amber,
  appBarTheme: AppBarTheme(
    color: Colors.blueGrey.shade900,
    centerTitle: true,
    titleTextStyle: TextStyle(
        color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
  ),
  textTheme: TextTheme(
    headlineSmall: TextStyle(
        color: Colors.white, fontSize: 24, fontWeight: FontWeight.normal),
  ),
  dividerTheme: DividerThemeData(
    color: Colors.amber,
    thickness: 2,
  ),
  cardTheme: CardTheme(
    color: Colors.blueGrey.shade900,
    elevation: 15,
    shadowColor: Colors.grey,
  ),
);
