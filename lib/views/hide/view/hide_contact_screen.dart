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
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text('Hide Contact'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: context.watch<HomeProvider>().ContactList.length,
          itemBuilder: (context, index) {
            return Visibility(
              visible:
                  context.watch<HomeProvider>().ContactList[index].ishide ==
                      true,
              child: ListTile(
                onLongPress: () =>
                    context.read<HomeProvider>().removeDetails(index),
                onTap: () {
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
                title:
                    Text(context.read<HomeProvider>().ContactList[index].name!),
                subtitle: Text(
                    context.read<HomeProvider>().ContactList[index].mobile!),
                trailing: IconButton(
                    onPressed: () async {
                      await launchUrl(
                          "tel:${context.read<HomeProvider>().ContactList[index].mobile}"
                              as Uri);
                    },
                    icon: const Icon(Icons.phone)),
              ),
            );
          },
        ),
      ),
    );
  }
}
