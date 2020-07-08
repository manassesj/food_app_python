import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_app_python/src/models/user.dart';
import 'package:food_app_python/src/state/constants.dart';

import 'package:http/http.dart' as http;

class UserState extends ChangeNotifier {
  bool _isLoading = false;
  User _userLogged = User(id: -1, name: 'None', passoword: 'None');
  String status;

  bool get isLoading {
    return _isLoading;
  }

  set setIsLoading(bool value) {
    this._isLoading = value;
    notifyListeners();
  }
  
  User get userLogged {
    return _userLogged;
  }

  Future<bool> addUser(User user) async {
    _isLoading = true;
    notifyListeners();

    try {
      final Map<String, dynamic> userData = {
        'name': user.name,
        'password': user.passoword,
      };

      final http.Response response = await http
          .post('http://$BASE_URL/user/insert', body: json.encode(userData));

      final Map<String, dynamic> responseData = json.decode(response.body);
      print(responseData);
      notifyListeners();
      return Future.value(true);
    } catch (e) {
      notifyListeners();
      return Future.value(false);
    }
  }

  Future<User> userLogin(User user, BuildContext context) async {
    print(user.name);
    _isLoading = true;
    notifyListeners();
    try {
      final Map<String, dynamic> userData = {
        'name': user.name,
        'password': user.passoword,
      };

      final http.Response response = await http
          .post('http://$BASE_URL/user/login', body: json.encode(userData));

      final Map<String, dynamic> responseData = json.decode(response.body);
      _userLogged = User(
        id: responseData['id'],
        name: responseData['name'],
        passoword: responseData['password'],
      );

      notifyListeners();
      return Future.value(_userLogged);
    } catch (e) {
      notifyListeners();
      return Future.value(_userLogged);
    }
  }
}
