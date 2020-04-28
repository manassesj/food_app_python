import 'package:flutter/material.dart';
import 'package:food_app_python/src/models/user.dart';

//pages
import 'package:food_app_python/src/pages/home_page.dart';
import 'package:food_app_python/src/pages/order_page.dart';
import 'package:food_app_python/src/pages/explore_page.dart';
import 'package:food_app_python/src/pages/profile_page.dart';
import 'package:food_app_python/src/state/session.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentTabIndex = 0;

  List<Widget> pages;
  Widget currentPage;

  HomePage homePage;
  ExplorePage explorePage;
  OrderPage orderPage;
  ProfilePage profilePage;

  @override
  void initState() {
    super.initState();
    //initializing pages
    homePage = HomePage();
    orderPage = OrderPage();
    explorePage = ExplorePage();
    profilePage = ProfilePage();

    pages = [homePage, explorePage, orderPage, profilePage];

    currentPage = homePage;
  }

  @override
  Widget build(BuildContext context) {  

    User user = Provider.of<Session>(context).userSession;
    print(user.name);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.blueAccent),
      ),
    );
  }
}
