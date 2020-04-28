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
  
  GlobalKey<FormState> _userItemFormKey = GlobalKey();
  GlobalKey<ScaffoldState> _scaffoldStateKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldStateKey,
        appBar: AppBar(
          title: Text('Food App'),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 60.0),
            child: Form(
              key: _userItemFormKey,
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
                        if (userState.isLoading) {
                          showLoadingIndicator();
                        }
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
    if (_userItemFormKey.currentState.validate()) {
      _userItemFormKey.currentState.save();
    }

    final User user = User(name: name, passoword: password);

    bool value = await addUser(user);
    print(value);
    if (value) {
      Navigator.of(context).pop();
      SnackBar snackBar = SnackBar(
        content: Text(
          'User successfully added',
          textAlign: TextAlign.center,
        ),
      );
      _scaffoldStateKey.currentState.showSnackBar(snackBar);
    } else {
      Navigator.of(context).pop();
      SnackBar snackBar = SnackBar(
        content: Text(
          'Fail to add user',
          textAlign: TextAlign.center,
        ),
      );
      _scaffoldStateKey.currentState.showSnackBar(snackBar);
    }
  }

  Future<void> showLoadingIndicator() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Row(
              children: <Widget>[
                CircularProgressIndicator(),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  'Adding user...',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          );
        });
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
            print(value);
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
