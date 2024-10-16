import 'package:contact_diary_app/views/addContact/model/contact_model.dart';
import 'package:flutter/cupertino.dart';

class HomeProvider extends ChangeNotifier {
  List<ContactModel> ContactList = [];

  void addDetails(ContactModel model) {
    ContactList.add(model);
    notifyListeners();
  }

  void removeDetails(int index) {
    ContactList.removeAt(index);
    notifyListeners();
  }
}
