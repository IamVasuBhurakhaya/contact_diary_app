import 'dart:io';

import 'package:contact_diary_app/views/addContact/model/contact_model.dart';
import 'package:contact_diary_app/views/homeScreen/provider/home_screen_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
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
        title: const Text('Add Contact'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Stepper(
              currentStep: stepIndex,
              onStepContinue: () {
                setState(() {
                  if (stepIndex < 4) {
                    stepIndex++;
                  }
                });
              },
              onStepCancel: () {
                setState(() {
                  if (stepIndex > 0) {
                    stepIndex--;
                  }
                });
              },
              steps: [
                Step(
                  title: const Text('Photo'),
                  content: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      path == null
                          ? const CircleAvatar(
                              radius: 60,
                              child: Icon(CupertinoIcons.person),
                            )
                          : CircleAvatar(
                              radius: 60,
                              backgroundImage: FileImage(File(path!)),
                            ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(),
                        onPressed: () async {
                          ImagePicker imagePicker = ImagePicker();
                          XFile? image = await imagePicker.pickImage(
                              source: ImageSource.gallery);
                          if (image != null) {
                            path = image.path;
                            setState(() {});
                          }
                        },
                        child: const Text('Add Photo'),
                      ),
                    ],
                  ),
                ),
                Step(
                  title: const Text('Name'),
                  content: _buildTextField(
                    controller: nameController,
                    hintText: 'Name',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter Name';
                      }
                      return null;
                    },
                  ),
                ),
                Step(
                  title: const Text('Number'),
                  content: _buildTextField(
                    controller: numberController,
                    hintText: 'Number',
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter Number';
                      } else if (value.length < 10) {
                        return 'Number Must Be 10 Digits';
                      }
                      return null;
                    },
                  ),
                ),
                Step(
                  title: const Text('Email'),
                  content: _buildTextField(
                    controller: emailController,
                    hintText: 'Email',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter Email';
                      }
                      return null;
                    },
                  ),
                ),
                Step(
                  title: const Text('Save'),
                  content: ElevatedButton(
                    style: ElevatedButton.styleFrom(),
                    onPressed: () {
                      bool isValid = formKey.currentState!.validate();
                      if (isValid) {
                        String name = nameController.text;
                        String number = numberController.text;
                        String email = emailController.text;

                        ContactModel details = ContactModel(
                          name: name,
                          mobile: number,
                          email: email,
                          image: path,
                          ishide: false,
                        );
                        context.read<HomeProvider>().addDetails(details);
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please Fill All Fields'),
                          ),
                        );
                      }
                    },
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    TextInputType? keyboardType,
    int? maxLength,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLength: maxLength,
      inputFormatters: inputFormatters,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: CupertinoColors.systemGrey),
        ),
      ),
    );
  }
}
