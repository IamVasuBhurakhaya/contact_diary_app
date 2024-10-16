import 'package:contact_diary_app/routes/app_routes.dart';
import 'package:contact_diary_app/views/homeScreen/provider/home_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: HomeProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: AppRoutes.routes,
        darkTheme: ThemeData.dark(),
        theme: ThemeData.light(),
      ),
    );
  }
}
