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

  set setIsLoading(bool value){
    this._isLoading = value;
    notifyListeners();
  }

  List<User> get userList {
    return _userList;
  }

  Future<bool> addUser(User user) async {
    _isLoading = true;
    notifyListeners();

    try {
      final Map<String, dynamic> userData = {
        'name' : user.name,
        'password': user.passoword,
      };


      final http.Response response = await http.post(
        'http:',
        body: json.encode(userData)
      );

      final Map<String, dynamic> responseData = json.decode(response.body);
      print(responseData);
      notifyListeners();
      return Future.value(true);
    } catch (e) {
      notifyListeners();
      return Future.value(false);
    }
  }

  Future<bool> userLogin(User user) async {
    _isLoading = true;
    notifyListeners();

    try {
      final Map<String, dynamic> userData = {
        'name': user.name,
        'password': user.passoword,
      };

      final http.Response response = await http.post(
          'http:',
          body: json.encode(userData));

      final Map<String, dynamic> responseData = json.decode(response.body);
      status = responseData['status'].toString();
      print(status);
      notifyListeners();
      return Future.value(true);
    } catch (e) {
      notifyListeners();
      return Future.value(false);
    }
  }
}
