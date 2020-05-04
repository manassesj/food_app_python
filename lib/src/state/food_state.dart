import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_app_python/src/models/food.dart';
import 'package:food_app_python/src/state/constants.dart';
import 'package:http/http.dart' as http;

class FoodState extends ChangeNotifier {
  List<Food> _foodList = List<Food>();
  bool _isLoading = false;
  String status;

  bool get isLoading {
    return _isLoading;
  }

  set setIsLoading(bool value) {
    this._isLoading = value;
    notifyListeners();
  }

  List<Food> get foodList {
    return _foodList;
  }


  Future<bool> addFood(Food food) async {
    _isLoading = true;
    notifyListeners();

    try {
      final Map<String, dynamic> foodData = {
        'name': food.name,
        'image': food.image,
        'description': food.description,
        'category_id': food.categoryId,
        'price': food.price,
        'discount': food.discount,
        'rating': food.rating

      };

      print(foodData);

      final http.Response response = await http.post(
          'http://$BASE_URL/food/insert',
          body: json.encode(foodData));

      final Map<String, dynamic> responseData = json.decode(response.body);

      print(responseData['image']);

      Food foodWithId = Food(
          id: responseData['id'],
          name: responseData['name'],
          image: responseData['image'],
          description: responseData['description'],
          categoryId: responseData['category_id'],
          price: responseData['price'],
          discount: responseData['discount'],
          rating: responseData['rating'],
          );

      _foodList.add(foodWithId);
      notifyListeners();
      return Future.value(true);
    } catch (e) {
      notifyListeners();
      return Future.value(false);
    }
  }

  // Future<bool> fetchFoods() async {
  //   _isLoading = true;
  //   notifyListeners();
  //   try {
  //     final http.Response response =
  //         await http.get("https://foodapp-6872d.firebaseio.com/foods.json");

  //     final Map<String, dynamic> fetchedData = json.decode(response.body);

  //     final List<Food> foodItems = [];

  //     fetchedData.forEach((String id, dynamic foodData) {
  //       Food foodItem = Food(
  //         id: id,
  //         name: foodData['title'],
  //         description: foodData['descrioption'],
  //         category: foodData['category'],
  //         price: foodData['price'],
  //         discount: foodData['discount'],
  //       );

  //       foodItems.add(foodItem);
  //     });

  //     _foods = foodItems;
  //     _isLoading = false;
  //     notifyListeners();
  //     return Future.value(true);

  //   } catch (e) {
  //     _isLoading = false;
  //     notifyListeners();
  //     return Future.value(false);
  //   }
  // }

}
