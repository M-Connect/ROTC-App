
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:rotc_app/services/auth.dart';



// Added common widget for log out alertSignOut button,
alertSignOut(BuildContext context) {
  Widget button2 = FlatButton(
      child: Text("No"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      });
  Widget button = FlatButton(
      child: Text("Yes"),
      onPressed: () async {
        context.read<Auth>().signOut();
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