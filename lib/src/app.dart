import 'package:flutter/material.dart';
import 'package:food_app_python/src/pages/add_food_page.dart';
import 'package:food_app_python/src/pages/sign_in_page.dart';
import 'package:food_app_python/src/pages/sign_up_page.dart';
import 'package:food_app_python/src/screens/launch_screen.dart';
import 'package:food_app_python/src/screens/main_screen.dart';
import 'package:food_app_python/src/state/session.dart';
import 'package:food_app_python/src/state/user_state.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserState(),
        ),
        ChangeNotifierProvider(
          create: (_) => Session(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Food felivery python',
        theme: ThemeData(primaryColor: Colors.blueAccent),
        initialRoute: '/',
        routes: {
          '/': (context) => LaunchScreen(),
          '/home': (context) => MainScreen(),
          '/signIn': (context) => SignIn(),
          '/signUp': (context) => SignUp(),
          '/addFood': (context) => AddFood(),
        },
      ),
    );
  }
}
