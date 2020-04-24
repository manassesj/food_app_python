import 'package:flutter/material.dart';

class LaunchButton extends StatelessWidget {
  final String title;
  final Function onPress;

  const LaunchButton({this.title, this.onPress});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: MaterialButton(
        child: Text(
          "$title",
          style: TextStyle(fontSize: 20.0, color: Colors.white),
        ),
        color: Colors.blueAccent[200],
        height: 60.0,
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        onPressed: onPress,
      ),
    );
  }
}
