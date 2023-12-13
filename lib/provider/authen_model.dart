import 'package:flutter/material.dart';

class AuthenModel extends ChangeNotifier {
  bool _isAuthenticated = false;
  String? _token;

  AuthenModel(this._isAuthenticated, this._token);

  void setAuthenticated(bool isAuthenticated) {
    _isAuthenticated = isAuthenticated;
    notifyListeners();
  }

  bool get getAuthenticated {
    return _isAuthenticated;
  }

  String? get token {
    return _token;
  }

  void setToken(String? newToken) {
    _token = newToken;
  }

  void removeToken() {
    _token = null;
  }
}
