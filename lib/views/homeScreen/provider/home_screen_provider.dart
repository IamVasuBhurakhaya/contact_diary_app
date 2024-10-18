import 'package:contact_diary_app/views/addContact/model/contact_model.dart';
import 'package:flutter/cupertino.dart';

class HomeProvider extends ChangeNotifier {
  List<ContactModel> ContactList = [];
  int selectedIndex = 0;

  bool isDarkTheme = false;

  void toggleTheme() {
    isDarkTheme = !isDarkTheme;
    notifyListeners();
  }

  void changeIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  void addDetails(ContactModel model) {
    ContactList.add(model);
    notifyListeners();
  }

  void removeDetails(int index) {
    ContactList.removeAt(index);
    notifyListeners();
  }

  void updateData(ContactModel model) {
    ContactList[selectedIndex] = model;
    notifyListeners();
  }

  void HideDetails() {
    if (ContactList[selectedIndex].ishide == true) {
      ContactList[selectedIndex].ishide = false;
    } else {
      ContactList[selectedIndex].ishide = true;
    }
    notifyListeners();
  }
}
