import 'package:flutter/material.dart';

import 'package:food_app_python/src/widgets/food_card.dart';

import 'package:food_app_python/src/state/category_data.dart';

import 'package:food_app_python/src/models/category_model.dart';

class FoodCategory extends StatelessWidget {
  final List<Category> _caregories = categories;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _caregories.length,
        itemBuilder: (BuildContext contex, int index) {
          return FoodCard(
            categoryName: _caregories[index].categoryName,
            imagePath: _caregories[index].imagePath,
            numberOfItems: _caregories[index].numberOfItems,
          );
        },
      ),
    );
  }
}
