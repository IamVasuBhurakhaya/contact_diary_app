import 'dart:io';

import 'package:contact_diary_app/routes/app_routes.dart';
import 'package:contact_diary_app/views/homeScreen/provider/home_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HideContactScreen extends StatefulWidget {
  const HideContactScreen({super.key});

  @override
  State<HideContactScreen> createState() => _HideContactScreenState();
}

class _HideContactScreenState extends State<HideContactScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hide Contact'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: context.watch<HomeProvider>().ContactList.length,
          itemBuilder: (context, index) {
            final contact = context.watch<HomeProvider>().ContactList[index];
            if (!(contact.ishide ?? false))
              return Container(); // Skip visible contacts

            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                onLongPress: () =>
                    context.read<HomeProvider>().removeDetails(index),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.detailscreen,
                    arguments: contact,
                  );
                },
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: contact.image != null
                      ? FileImage(File(contact.image!))
                      : null,
                  child: contact.image == null
                      ? const Icon(Icons.person, size: 30)
                      : null,
                ),
                title: Text(
                  contact.name ?? 'No Name',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  contact.mobile ?? 'No Number',
                  style: TextStyle(color: Colors.grey[600]),
                ),
                trailing: IconButton(
                  onPressed: () async {
                    await launchUrl(Uri.parse("tel:${contact.mobile}"));
                  },
                  icon: const Icon(Icons.phone),
                  color: Theme.of(context).primaryColor,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
