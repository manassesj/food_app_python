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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.blueAccent),
        ),
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.add),
                title: Text(
                  'Add Food Item',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ),
              Divider(
                color: Colors.black,
                height: 2,
                indent: 10,
                endIndent: 10.0,
              )
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentTabIndex,
          type: BottomNavigationBarType.fixed,
          
          onTap: (int index) {
            setState(() {
              currentTabIndex = index;
              currentPage = pages[index];
            });
          },
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.explore),
              title: Text('Explore'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              title: Text('Cart'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
