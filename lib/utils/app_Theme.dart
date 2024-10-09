import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorSchemeSeed: Colors.blue,
    appBarTheme: const AppBarTheme(
      color: Colors.blue,
      elevation: 0.0,
      centerTitle: true,
      iconTheme: IconThemeData(
        size: 20,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.light,
    colorSchemeSeed: Colors.blue,
    appBarTheme: const AppBarTheme(
      color: Colors.blue,
      elevation: 0.0,
      centerTitle: true,
      iconTheme: IconThemeData(
        size: 20,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
    ),
  );
}
