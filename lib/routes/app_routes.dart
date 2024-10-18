import 'package:contact_diary_app/views/addContact/views/add_contact.dart';
import 'package:contact_diary_app/views/details/view/detail_screen.dart';
import 'package:contact_diary_app/views/hide/view/hide_contact_screen.dart';
import 'package:contact_diary_app/views/homeScreen/views/home_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static String homepage = "/";
  static String addcontact = "add_contact_page";
  static String detailscreen = "detail_screen";
  static String hideContactScreen = "hide_contact_screen";

  static Map<String, Widget Function(BuildContext)> routes = {
    homepage: (context) => const Homepage(),
    addcontact: (context) => const ContactScreen(),
    detailscreen: (context) => const DetailScreen(),
    hideContactScreen: (context) => const HideContactScreen(),
  };
}
