import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:food_app_python/src/models/food.dart';
import 'package:food_app_python/src/widgets/bought_foods.dart';
import 'package:food_app_python/src/widgets/food_category.dart';
import 'package:food_app_python/src/widgets/home_top_indo.dart';
import 'package:food_app_python/src/widgets/search_field.dart';
import 'package:food_app_python/src/state/food_state.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Food> _listFoods;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          children: <Widget>[
            HomeTopInfo(),
            FoodCategory(),
            SizedBox(
              height: 13.0,
            ),
            SearchField(),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Frequently bought foods',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    'View all',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.orangeAccent,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 13.0,
            ),
            Consumer<FoodState>(
              builder: (build, foodstate, child) {
                _listFoods = foodstate.foodList;

                return Column(
                  children: foodstate.foodList.map(_buildFoodItems).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFoodItems(Food food) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.0),
      child: BoughtFoods(
        food: food,
      ),
    );
  }
}
