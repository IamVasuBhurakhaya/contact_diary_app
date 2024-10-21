import 'dart:io';

import 'package:contact_diary_app/views/addContact/model/contact_model.dart';
import 'package:contact_diary_app/views/homeScreen/provider/home_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ContactModel model =
        ModalRoute.of(context)!.settings.arguments as ContactModel;
    nameController.text = model.name!;
    emailController.text = model.email!;
    numberController.text = model.mobile!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.lock),
            onPressed: () {
              context.read<HomeProvider>().HideDetails();
              Navigator.pop(context);
            },
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              _buildShowDialog(context, model);
            },
          ),
        ],
        elevation: 0,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage:
                  model.image != null ? FileImage(File(model.image!)) : null,
              child: model.image == null
                  ? Text(
                      model.name!.substring(0, 1).toUpperCase(),
                      style: const TextStyle(fontSize: 40),
                    )
                  : null,
            ),
            const SizedBox(height: 30),
            _buildInfoCard("Name", model.name!),
            const SizedBox(height: 10),
            _buildInfoCard("Email", model.email!),
            const SizedBox(height: 10),
            _buildInfoCard("Number", model.mobile!),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String value) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      child: ListTile(
        title: Text(value, style: const TextStyle(fontSize: 16)),
        subtitle:
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }

  Future<void> _buildShowDialog(BuildContext context, ContactModel model) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Edit Contact"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Name"),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: "Email"),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: numberController,
                decoration: const InputDecoration(labelText: "Number"),
                keyboardType: TextInputType.phone,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
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
            child: const Text("Update"),
          ),
          TextButton(
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
