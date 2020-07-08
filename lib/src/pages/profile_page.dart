import 'package:flutter/material.dart';
import 'package:food_app_python/src/widgets/customListTile.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool turnOnOffNotif = false;
  bool turnOnOffLocat = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Profile',
                style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                children: <Widget>[
                  Container(
                    height: 120.0,
                    width: 120.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60.0),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 3.0,
                          color: Colors.black38,
                          offset: Offset(0, 4.0),
                        ),
                      ],
                      image: DecorationImage(
                        image: AssetImage('assets/images/coffee-cup.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Tatiana Shch',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        '+7 923 777 77 77',
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(
                        height: 7.0,
                      ),
                      Container(
                        height: 25.0,
                        width: 50.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          border: Border.all(color: Colors.blue),
                        ),
                        child: Center(
                          child: Text(
                            'Edit',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 30.0,
              ),
              Text(
                'Account',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15.0,
              ),
              Card(
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    children: <Widget>[
                      CustomListTile(
                          icon: Icons.location_on, title: 'Location'),
                      Divider(
                        height: 1.0,
                      ),
                      CustomListTile(
                          icon: Icons.visibility, title: 'Change Password'),
                      Divider(
                        height: 1.0,
                      ),
                      CustomListTile(icon: Icons.traffic, title: 'Shipping'),
                      Divider(
                        height: 1.0,
                      ),
                      CustomListTile(icon: Icons.payment, title: 'Payment'),
                      Divider(
                        height: 1.0,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'Notifications',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15.0,
              ),
              Card(
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'App Notifications',
                            style: TextStyle(fontSize: 15.0),
                          ),
                          Switch(
                            inactiveThumbColor: Colors.lightBlueAccent,
                            inactiveTrackColor: Colors.blueGrey,
                            value: turnOnOffNotif,
                            onChanged: (bool value) {
                              setState(
                                () {
                                  turnOnOffNotif = value;
                                },
                              );
                            },
                          ),
                        ],
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Location Tracking',
                            style: TextStyle(fontSize: 15.0),
                          ),
                          Switch(
                            inactiveThumbColor: Colors.lightBlueAccent,
                            inactiveTrackColor: Colors.blueGrey,
                            value: turnOnOffLocat,
                            onChanged: (bool value) {
                              setState(
                                () {
                                  turnOnOffLocat = value;
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'Other',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15.0,
              ),
              Card(
                child: Padding(
                  padding: EdgeInsets.all(14.0),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          'Language',
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ),
                      Divider(
                        height: 1.0,
                      ),
                      ListTile(
                        title: Text(
                          'Currency',
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ),
                      Divider(
                        height: 1.0,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
