
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:rotc_app/services/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*
Added common widget for log out alertSignOut button,
will direct the user to the sign-in page
*/

alertSignOut(BuildContext context) {
  Widget button2 = ElevatedButton(
      child: Text("No"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      });
  Widget button = ElevatedButton(
      child: Text("Yes"),
      onPressed: () async {
        context.read<Auth>().signOut();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.clear();
        Navigator.of(context, rootNavigator: true).pushNamed('/signIn');
      });
  AlertDialog alert = AlertDialog(
    title: Text("Sign Out"),
    content: Text("Are you sure you want to sign out"),
    actions: [
      button2,
      button,
    ],
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}