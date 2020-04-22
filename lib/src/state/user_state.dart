import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_app_python/src/models/user.dart';
import 'package:http/http.dart' as http;

class UserState extends ChangeNotifier {
  List<User> _userList = List<User>();
  bool _isLoading = false;
  String status;

  bool get isLoading {
    return _isLoading;
  }

  List<User> get userList {
    return _userList;
  }

  Future<bool> addUser(User user) async {
    _isLoading = true;
    notifyListeners();

    try {
      final Map<String, dynamic> userData = {
        'name': user.name,
        'password': user.passoword,
      };

      final http.Response response = await http.post(
          'http://192.168.1.104:5000/user/insert',
          body: json.encode(userData));

      final Map<String, dynamic> responseData = json.decode(response.body);
      notifyListeners();
      return Future.value(true);
    } catch (e) {
      notifyListeners();
      return Future.value(false);
    }
  }

  Future<String> userLogin(User user) async {
    _isLoading = true;
    notifyListeners();

    try {
      final Map<String, dynamic> userData = {
        'name': user.name,
        'password': user.passoword,
      };

      final http.Response response = await http.post(
          'http://192.168.1.104:5000/user/login',
          body: json.encode(userData));

      final Map<String, dynamic> responseData = json.decode(response.body);
      status = responseData['status'].toString();
      notifyListeners();
      return Future.value(status);
    } catch (e) {
      notifyListeners();
      return Future.value("ERROR2");
    }
  }
}
