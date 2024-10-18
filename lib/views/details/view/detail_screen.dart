import 'dart:io';
import 'package:contact_diary_app/views/addContact/model/contact_model.dart';
import 'package:contact_diary_app/views/homeScreen/provider/home_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailscreenState();
}

class _DetailscreenState extends State<DetailScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    ContactModel model =
        ModalRoute.of(context)!.settings.arguments as ContactModel;
    nameController.text = model.name!;
    emailController.text = model.email!;
    numberController.text = model.mobile!;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        actions: [
          IconButton(
            onPressed: () {
              print("Index : ${context.read<HomeProvider>().selectedIndex}");
              context.read<HomeProvider>().HideDetails();
              Navigator.pop(context);
            },
            icon: const Icon(Icons.lock),
          ),
          IconButton(
            onPressed: () {
              buildShowDialog(context, model);
            },
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 60,
                foregroundImage: FileImage(
                  File(model.image ?? ''),
                ),
                child: Center(
                  child: Text(
                    model.name!.substring(0, 1).toUpperCase(),
                    style: const TextStyle(
                      fontSize: 40,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              ListTile(
                leading: const Text(
                  "Name: ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                title: Text(model.name!),
              ),
              SizedBox(
                height: 10,
              ),
              ListTile(
                leading: const Text(
                  "Email: ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                title: Text(model.email!),
              ),
              SizedBox(
                height: 10,
              ),
              ListTile(
                leading: const Text(
                  "Number: ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                title: Text(model.mobile!),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> buildShowDialog(BuildContext context, ContactModel model) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Edit Contact"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Name",
              ),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "Email",
              ),
            ),
            TextField(
              controller: numberController,
              decoration: const InputDecoration(labelText: "Number"),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              ContactModel cmodel = ContactModel(
                name: nameController.text,
                mobile: numberController.text,
                email: emailController.text,
                image: model.image,
                ishide: model.ishide,
              );
              context.read<HomeProvider>().updateData(cmodel);
              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),
        ],
      ),
    );
  }
}
