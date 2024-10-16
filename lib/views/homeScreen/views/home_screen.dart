import 'dart:io';
import 'package:contact_diary_app/routes/app_routes.dart';
import 'package:contact_diary_app/views/homeScreen/provider/home_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        title: const Text('Contacts',
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 5,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: context.watch<HomeProvider>().ContactList.length,
          itemBuilder: (context, index) {
            final contact = context.watch<HomeProvider>().ContactList[index];
            return Dismissible(
              key: Key(contact.name ??
                  index.toString()), // Unique key for the Dismissible
              background: Container(
                color: Colors.red, // Background color when swiping
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                // Directly remove the contact when swiped
                context.read<HomeProvider>().removeDetails(index);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${contact.name} deleted')),
                );
              },
              child: Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  leading: CircleAvatar(
                    radius: 30,
                    foregroundImage: FileImage(File(contact.imagePath ?? '')),
                    child: contact.imagePath == null
                        ? const Icon(Icons.person, size: 30)
                        : null,
                  ),
                  title: Text(
                    contact.name ?? 'Unknown',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    contact.mobile ?? 'No Number',
                    style: const TextStyle(color: Colors.grey),
                  ),
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
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
