import 'package:flutter/material.dart';
import 'package:food_app_python/src/models/user.dart';

class Session extends ChangeNotifier {
  User _userSession;

  User get userSession => _userSession;

  void setSession(User user) {
    this._userSession = user;
    notifyListeners();
  }
}
