import 'dart:io';

import 'package:contact_diary_app/routes/app_routes.dart';
import 'package:contact_diary_app/views/homeScreen/provider/home_screen_provider.dart';
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
        title: const Text('Homepage'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.hideContactScreen);
              },
              icon: const Icon(Icons.lock))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: context.watch<HomeProvider>().ContactList.length,
          itemBuilder: (context, index) {
            return Visibility(
              visible:
                  context.watch<HomeProvider>().ContactList[index].ishide ==
                      false,
              child: ListTile(
                onLongPress: () =>
                    context.read<HomeProvider>().removeDetails(index),
                onTap: () {
                  context.read<HomeProvider>().changeIndex(index);
                  print(
                      "Index : ${context.read<HomeProvider>().selectedIndex}");
                  Navigator.pushNamed(context, AppRoutes.detailscreen,
                      arguments:
                          context.read<HomeProvider>().ContactList[index]);
                },
                leading: CircleAvatar(
                  foregroundImage: FileImage(
                    File(context
                            .watch<HomeProvider>()
                            .ContactList[index]
                            .image ??
                        ''),
                  ),
                  child: Center(
                    child: Text(
                      context
                          .watch<HomeProvider>()
                          .ContactList[index]
                          .name![0]
                          .toUpperCase(),
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                title: Text(context
                    .watch<HomeProvider>()
                    .ContactList[index]
                    .name
                    .toString()),
                subtitle: Text(context
                    .watch<HomeProvider>()
                    .ContactList[index]
                    .mobile
                    .toString()),
                trailing: IconButton(
                    onPressed: () async {
                      await launchUrl(
                          "tel:${context.watch<HomeProvider>().ContactList[index].mobile}"
                              as Uri);
                    },
                    icon: const Icon(Icons.phone)),
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
