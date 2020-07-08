import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_app_python/src/models/food.dart';
import 'package:food_app_python/src/state/food_state.dart';
import 'package:food_app_python/src/utility.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddFood extends StatefulWidget {
  @override
  _AddFoodState createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
  String name;
  String base64Image;
  String description;
  int categoryId;
  double price;
  double discount;
  double rating;

  Image imageFromPreferences;

  Future<File> imagefile;

  pickImageFromGallery(ImageSource source) {
    setState(() {
      imagefile = ImagePicker.pickImage(source: source);
    });
  }

  loadImageFromPreferences() {
    Utility.getImageFromPreferences().then((img) {
      if (null == img) {
        return;
      }
      setState(() {
        imageFromPreferences = Utility.imageFromBase64String(img);
      });
    });
  }

  Widget imageFromGallery() {
    return FutureBuilder<File>(
      future: imagefile,
      builder: (BuildContext contex, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (null == snapshot.data) {
            return Text("Error", textAlign: TextAlign.center);
          }

          base64Image = Utility.base64String(snapshot.data.readAsBytesSync());
          print(base64Image);
          Utility.saveImageToPreferences(base64Image);
          return Image.file(snapshot.data);
        }
        if (null != snapshot.error) {
          return const Text('Error Picking Image', textAlign: TextAlign.center);
        }
        return const Text(
          'No image selected',
          textAlign: TextAlign.center,
        );
      },
    );
  }

  GlobalKey<FormState> _foodItemFormKey = GlobalKey();
  GlobalKey<ScaffoldState> _scaffoldStateKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldStateKey,
        appBar: AppBar(
          title: Text(
            'Food App',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: 14.0, left: 16.0, right: 16.0),
            child: Form(
              key: _foodItemFormKey,
              child: Column(
                children: <Widget>[
                  Container(
                    height: 40.0,
                    margin: EdgeInsets.symmetric(vertical: 15.0),
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      'Add food',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      imageFromGallery(),
                      SizedBox(
                        height: 10.0,
                      ),
                      GestureDetector(
                        child: Container(
                          height: 30,
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 5.0),
                          decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(15.0)),
                          child: Text(
                            'Pick Image',
                            style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        onTap: () {
                          pickImageFromGallery(ImageSource.gallery);
                        },
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                    ],
                  ),
                  _buildTextFormField('Name'),
                  _buildTextFormField('Category'),
                  _buildTextFormField('Descripition', maxLine: 3),
                  _buildTextFormField('Price'),
                  _buildTextFormField('Discount'),
                  _buildTextFormField('Rating'),
                  SizedBox(
                    height: 20.0,
                  ),
                  Consumer<FoodState>(
                    builder: (builder, foodState, child) {
                      return GestureDetector(
                        child: Container(
                          height: 50.0,
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          child: Center(
                            child: Text(
                              'Submit',
                              style: TextStyle(
                                fontSize: 19.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          onSubmit(foodState.addFood);
                          print('pushed');
                          if (foodState.isLoading) {
                            // show Loading progess indicator
                            showLoadingInficator();
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onSubmit(Function addFood) async {
    if (_foodItemFormKey.currentState.validate()) {
      _foodItemFormKey.currentState.save();

      print(rating);

      final Food food = Food(
          name: name,
          image: base64Image,
          description: description,
          categoryId: categoryId,
          discount: discount,
          price: price,
          rating: rating);

      bool value = await addFood(food);
      if (value) {
        Navigator.of(context).pop();
        SnackBar snackBar = SnackBar(
          content: Text('Food item successfully added'),
        );

        _scaffoldStateKey.currentState.showSnackBar(snackBar);
      } else {
        Navigator.of(context).pop();
        SnackBar snackBar = SnackBar(
          content: Text('Fail to add food item'),
        );
        _scaffoldStateKey.currentState.showSnackBar(snackBar);
      }
    }
    ;
  }

  Future<void> showLoadingInficator() {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext contex) {
        return AlertDialog(
          content: Row(
            children: <Widget>[
              CircularProgressIndicator(),
              SizedBox(
                width: 10.0,
              ),
              Text(
                'Adding food item...',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildTextFormField(String hint, {int maxLine = 1}) {
    return TextFormField(
      decoration: InputDecoration(hintText: '$hint'),
      maxLines: maxLine,
      keyboardType: hint == 'Price' || hint == 'Discount' || hint == 'Rating'
          ? TextInputType.number
          : TextInputType.text,
      validator: (String value) {
        if (value.isEmpty && hint == 'Name') {
          return 'Name required';
        }
        if (value.isEmpty && hint == 'Category') {
          return 'Category required';
        }
        if (value.isEmpty && hint == 'Descripition') {
          return 'Descripition required';
        }
        if (value.isEmpty && hint == 'Price') {
          return 'Price required';
        }
        if (value.isEmpty && hint == 'Rating') {
          return 'Rating required';
        }
      },
      onChanged: (dynamic value) {
        if (hint == 'Name') {
          this.name = value;
        }
        if (hint == 'Category') {
          this.categoryId = int.parse(value);
        }
        if (hint == 'Descripition') {
          this.description = value;
        }
        if (hint == 'Price') {
          this.price = double.parse(value);
        }
        if (hint == 'Discount') {
          this.discount = double.parse(value);
        }
        if (hint == 'Rating') {
          this.rating = double.parse(value);
        }
      },
    );
  }
}
