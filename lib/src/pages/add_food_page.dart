import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_app_python/src/models/food.dart';
import 'package:image_picker/image_picker.dart';

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

  Future<File> file;
  String status = '';
  File tmpFile;
  String errMessage = 'Error Uploading Image';

  GlobalKey<FormState> _foodItemFormKey = GlobalKey();
  GlobalKey<ScaffoldState> _scaffoldStateKey = GlobalKey();

  chooseImage() {
    setState(() {
      file = ImagePicker.pickImage(source: ImageSource.gallery);
    });
    setStatus('');
  }

  setStatus(String message) {
    setState(() {
      status = message;
    });
  }

  Widget showImage() {
    return FutureBuilder<File>(
        future: file,
        builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data != null) {
            tmpFile = snapshot.data;
            base64Image = base64Encode(snapshot.data.readAsBytesSync());
            print("Image: "+ base64Image);
            return Container(
              width: 200.0,
              height: 200.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: FileImage(snapshot.data), fit: BoxFit.cover),
              ),
            );
            // return Flexible(
            //   child: Image.file(
            //     snapshot.data,
            //     fit: BoxFit.contain,
            //   ),
            // );
          } else if (snapshot.error != null) {
            return const Text(
              'Error Picking Image',
              textAlign: TextAlign.center,
            );
          } else {
            return const Text(
              'No Image Selected',
              textAlign: TextAlign.center,
            );
          }
        });
  }

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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        showImage(),
                        SizedBox(
                          height: 10.0,
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        OutlineButton(
                          onPressed: chooseImage,
                          child: Text(
                            'Choose Image',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildTextFormField('Food Title'),
                  _buildTextFormField('Category'),
                  _buildTextFormField('Descripition', maxLine: 3),
                  _buildTextFormField('Price'),
                  _buildTextFormField('Discount'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField(String hint, {int maxLine = 1}) {
    return TextFormField(
      decoration: InputDecoration(hintText: '$hint'),
      maxLines: maxLine,
      keyboardType: hint == 'Price' || hint == 'Discount'
          ? TextInputType.number
          : TextInputType.text,
      validator: (String value) {
        if (value.isEmpty && hint == 'name') {
          return 'name required';
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
      },
      onChanged: (dynamic value) {
        if (hint == 'name') {
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
      },
    );
  }
}
