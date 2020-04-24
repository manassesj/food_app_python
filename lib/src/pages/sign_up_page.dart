import 'package:flutter/material.dart';
import 'package:food_app_python/src/models/user.dart';
import 'package:food_app_python/src/state/user_state.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String name;
  String password;

  // GlobalKey<FormState> _userItemFormKey = GlobalKey();
  // GlobalKey<ScaffoldState> _scaffoldStateKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Food App'),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 60.0),
            child: Form(
              child: Column(
                children: <Widget>[
                  Text(
                    'Sign Up',
                    style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  _buildTextFormField('Name'),
                  SizedBox(
                    height: 15.0,
                  ),
                  _buildTextFormField('Password'),
                  SizedBox(
                    height: 50.0,
                  ),
                  Consumer<UserState>(builder: (builder, userState, child) {
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
                        onSubmit(userState.addUser);
                        print('pushed');
                      },
                    );
                  })
                ],
              ),
            ),
          ),
        ));
  }

  void onSubmit(Function addUser) async {
    // if (_userItemFormKey.currentState.validate()) {
    //   _userItemFormKey.currentState.save();
    // }

    final User user = User(name: name, passoword: password);

    bool value = await addUser(user);
    print(value);
  }

  Widget _buildTextFormField(String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '$hint',
          style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent),
        ),
        TextFormField(
          decoration: InputDecoration(
            hintText: 'Type your $hint',
          ),
          validator: (String value) {
            if (value.isEmpty && hint == 'Name') {
              return 'Name is required';
            }
            if (value.isEmpty && hint == 'Password') {
              return 'Password is required';
            }
          },
          onChanged: (String value) {
            if (hint == 'Name') {
              this.name = value;
            } else if (hint == 'Password') {
              this.password = value;
            }
          },
        ),
      ],
    );
  }
}
