import 'dart:io';
import 'package:contact_diary_app/views/addContact/model/contact_model.dart';
import 'package:contact_diary_app/views/homeScreen/provider/home_screen_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  int stepIndex = 0;
  String? path;
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(CupertinoIcons.back),
        ),
        title: const Text('Add Contact'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Stepper(
              elevation: 0,
              currentStep: stepIndex,
              onStepContinue: () {
                if (stepIndex < 4) {
                  setState(() {
                    stepIndex++;
                  });
                }
              },
              onStepCancel: () {
                if (stepIndex > 0) {
                  setState(() {
                    stepIndex--;
                  });
                }
              },
              steps: [
                Step(
                  title: const Text('Photo'),
                  content: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipOval(
                        child: path == null
                            ? const CircleAvatar(
                                radius: 60,
                                child: Icon(Icons.person, size: 60),
                                backgroundColor: Colors.grey,
                              )
                            : CircleAvatar(
                                radius: 60,
                                backgroundImage: FileImage(File(path!)),
                              ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () async {
                          final imagePicker = ImagePicker();
                          final XFile? image = await imagePicker.pickImage(
                              source: ImageSource.gallery);
                          if (image != null) {
                            setState(() {
                              path = image.path;
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text('Add Photo'),
                      ),
                    ],
                  ),
                ),
                Step(
                  title: const Text('Name'),
                  content: TextFormField(
                    controller: nameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter Name';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: 'Name',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                Step(
                  title: const Text('Number'),
                  content: TextFormField(
                    controller: numberController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter Number';
                      } else if (value.length < 10) {
                        return 'Number Must Be 10 Digits';
                      }
                      return null;
                    },
                    maxLength: 10,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: const InputDecoration(
                      hintText: 'Number',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                Step(
                  title: const Text('Email'),
                  content: TextFormField(
                    controller: emailController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter Email';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: 'Email',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                Step(
                  title: const Text('Save'),
                  content: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        final contactDetails = ContactModel(
                          name: nameController.text,
                          mobile: numberController.text,
                          email: emailController.text,
                          imagePath: path,
                        );
                        context.read<HomeProvider>().addDetails(contactDetails);
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please Fill All Fields'),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('Save'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
