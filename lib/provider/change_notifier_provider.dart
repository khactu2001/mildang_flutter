import 'package:flutter/material.dart';
import 'package:flutter_mildang/model/login_model.dart';

class UserProvider extends ChangeNotifier {
  UserModel? userProvider;

  void updateUserProvider(UserModel? user) {
    userProvider = user;
    notifyListeners();
  }

  void removeUserProvider() {
    userProvider = null;
    notifyListeners();
  }

  UserModel? getUserProvider() {
    return userProvider;
  }
}
