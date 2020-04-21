import 'package:flutter/material.dart';
import 'package:food_app_python/src/pages/sign_in_page.dart';
import 'package:food_app_python/src/pages/sign_out_page.dart';
import 'package:food_app_python/src/screens/launch_screen.dart';
import 'package:food_app_python/src/screens/main_screen.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Food felivery python',
        theme: ThemeData(primaryColor: Colors.blueAccent),
        initialRoute: '/',
        routes: {
          '/': (context) => LaunchScreen(),
          '/home': (context) => MainScreen(),
          '/signIn': (context) => SignIn(),
          '/signOut': (context) => SignOut(),
        },
      ),
    );
  }
}
