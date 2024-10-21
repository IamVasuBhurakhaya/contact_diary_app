import 'dart:io';

import 'package:contact_diary_app/routes/app_routes.dart';
import 'package:contact_diary_app/views/homeScreen/provider/home_screen_provider.dart';
import 'package:day_night_themed_switcher/day_night_themed_switcher.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
        actions: [
          IconButton(
            icon: const Icon(Icons.lock),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.hideContactScreen);
            },
          ),
          const SizedBox(width: 10),
          DayNightSwitch(
            size: 30,
            initiallyDark: context.watch<HomeProvider>().isDarkTheme,
            onChange: (dark) {
              context.read<HomeProvider>().toggleTheme();
            },
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.8,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: context.watch<HomeProvider>().ContactList.length,
          itemBuilder: (context, index) {
            final contact = context.watch<HomeProvider>().ContactList[index];
            if (contact.ishide!) return Container(); // Skip hidden contacts

            return GestureDetector(
              onLongPress: () =>
                  context.read<HomeProvider>().removeDetails(index),
              onTap: () {
                context.read<HomeProvider>().changeIndex(index);
                Navigator.pushNamed(
                  context,
                  AppRoutes.detailscreen,
                  arguments: contact,
                );
              },
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: contact.image != null
                          ? FileImage(File(contact.image!))
                          : null,
                      child: contact.image == null
                          ? const Icon(Icons.person, size: 40)
                          : null,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      contact.name ?? 'No Name',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      contact.mobile ?? 'No Number',
                      style: const TextStyle(color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    IconButton(
                      onPressed: () async {
                        await launchUrl(Uri.parse("tel:${contact.mobile}"));
                      },
                      icon: const Icon(Icons.phone),
                      color: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.addcontact);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
