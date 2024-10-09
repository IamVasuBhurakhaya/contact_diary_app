import 'package:contact_diary_app/utils/app_Theme.dart';
import 'package:flutter/material.dart';
import 'package:day_night_themed_switcher/day_night_themed_switcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light; // Default is light mode

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // routes: AppRoutes.routes,
      theme: AppTheme.lightTheme,
      darkTheme: ThemeData.dark(),
      themeMode: _themeMode,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Day Night Theme Switcher'),
        ),
        body: Center(
          child: themeSwitch(),
        ),
      ),
    );
  }

  Widget themeSwitch() {
    return DayNightSwitch(
      duration: const Duration(seconds: 2),
      size: 80,
      onChange: (dark) {
        setState(() {
          _themeMode = dark ? ThemeMode.dark : ThemeMode.light;
        });
      },
    );
  }
}
