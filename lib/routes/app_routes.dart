import 'package:contact_diary_app/views/addContact/views/add_contact.dart';
import 'package:contact_diary_app/views/homeScreen/views/home_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static String homepage = "/";
  static String addcontact = "add_contact_page";

  static Map<String, Widget Function(BuildContext)> routes = {
    homepage: (context) => const Homepage(),
    addcontact: (context) => const ContactPage(),
  };
}
