import 'package:flutter/material.dart';

class AuthenModel extends ChangeNotifier {
  bool _isAuthenticated = false;

  void setAuthenticated(bool isAuthenticated) {
    _isAuthenticated = isAuthenticated;
    notifyListeners();
  }

  bool get getAuthenticated {
    return _isAuthenticated;
  }
}
