import 'package:flutter/material.dart';
import 'package:food_app_python/src/models/user.dart';
import 'package:food_app_python/src/state/user_state.dart';
import 'package:food_app_python/src/state/session.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
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
                    'Sign In',
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
                        onSubmit(userState.userLogin);
                        print('pushed');
                        if (userState.userLogged.id == -1) {
                          showLoadingIndicator();
                        }
                      },
                    );
                  },
                  )
                ],
              ),
            ),
          ),
        ));
  }

  void onSubmit(Function userLogin) async {
    if (_userItemFormKey.currentState.validate()) {
      _userItemFormKey.currentState.save();
    }

    final User user = User(name: name, passoword: password);

    User value = await userLogin(user, context);
    print(value.id);
    if (value.id != -1) {
      Provider.of<Session>(context,listen: false).setSession(value);
      Navigator.of(context).pushReplacementNamed('/home');
    } else {
      Navigator.of(context).pop();
      SnackBar snackBar = SnackBar(
        content: Text(
          'Fail to Login',
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
                  'Loading...',
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
