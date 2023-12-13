import 'package:flutter/material.dart';

class AuthenModel extends ChangeNotifier {
  bool _isAuthenticated = false;

  AuthenModel(this._isAuthenticated);

  void setAuthenticated(bool isAuthenticated) {
    _isAuthenticated = isAuthenticated;
    notifyListeners();
  }

  bool get getAuthenticated {
    return _isAuthenticated;
  }
}
