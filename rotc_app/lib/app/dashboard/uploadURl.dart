import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

/*
* Author: Mac-Rufus O. Umeokolo
* This page is for the dashboard UI to upload their url
* */

class UploadUrl extends StatelessWidget {
  CollectionReference dashboardUrls =
      FirebaseFirestore.instance.collection('dashboardUrls');
  TextEditingController dashboardUrl = TextEditingController();

  Future<void> userRegistration() {
    return dashboardUrls.add({
      'dashboardUrl': dashboardUrl.text,
    });
  }

  alertUploadURL(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: Text("Upload Document URL"),
      content: TextFormField(
        controller: dashboardUrl,
      ),
      actions: <Widget>[
        MaterialButton(
          elevation: 5.0,
          child: Text('Post'),
          onPressed: null,
        )
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
