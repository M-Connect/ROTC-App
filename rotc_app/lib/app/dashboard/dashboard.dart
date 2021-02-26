
import 'package:flutter/material.dart';
import 'package:rotc_app/main.dart';

Widget dashboard() {
  const TextStyle tabTextStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  return Scaffold(
    body: Container(
      padding: EdgeInsets.all(25.0),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            child: ElevatedButton(
              child: Text('Review Request Anouncement'),
              onPressed: () {
                navigation.currentState.pushNamed('');
              },
            ),
          ),
          Container(
            child: ElevatedButton(
              child: Text('Lead Lab OPORD'),
              onPressed: () {
                navigation.currentState.pushNamed('');
              },
            ),
          ),
          Container(
            child: ElevatedButton(
              child: Text('PT ConOps'),
              onPressed: () {
                navigation.currentState.pushNamed('');
              },
            ),
          ),
        ],
      ),
    ),
  );
}