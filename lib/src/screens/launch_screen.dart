import 'package:flutter/material.dart';
import 'package:food_app_python/src/services/constants.dart';
import 'package:food_app_python/src/widgets/launch_buttons.dart';

class LaunchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: 300.0,
          padding: EdgeInsets.only(top: 150.0),
          margin: EdgeInsets.all(
            20.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                kAppName,
                style: TextStyle(
                  fontSize: 25.0,
                ),
              ),
              SizedBox(
                height: 35.0,
              ),
              LaunchButton(
                title: 'Sign In',
                onPress: () {
                  Navigator.pushNamed(context, '/signIn');
                },
              ),
              SizedBox(height: 15.0,)
              ,
              LaunchButton(
                title: 'Sign Up',
                onPress: () {
                  Navigator.pushNamed(context, '/signUp');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
