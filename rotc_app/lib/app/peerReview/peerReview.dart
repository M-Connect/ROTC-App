import 'package:flutter/material.dart';
import 'package:rotc_app/app/peerReview/peerReviewLanding.dart';
import 'package:rotc_app/common_widgets/buttonWidgets.dart';

import '../../main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*
 Author: Sawyer Kisha
 Co-author: Kyle Serruys
  This class is the home page for our peer review request page
  Needs functionality
 */

class PeerReview extends StatefulWidget {
  @override
  PeerReviewState createState() => PeerReviewState();

}

class PeerReviewState extends State<PeerReview> {
  var userList = new List<String>();
  var selectedUserList = new List<String>();

  List<ElevatedButton> userButtonList = new List<ElevatedButton>();
  String firstName = "";
  String lastName = "";

  CollectionReference cadets = FirebaseFirestore.instance.collection('cadets');

  Future<void> peerReview() {
    return cadets.add({
      "firstName": firstName,
      "lastName": lastName,
    });
  }

/*
Author:  Kyle Serruys
This sets the state for the functions getCadetNames and getUserInfo.  We put
them in this initState becuase both functions need to be async, and you can't
make initState an async function.
  */
  @override
  void initState() {
    super.initState();
    getCadetNames();
    getUserInfo();
    //  initSliderValue();
  }

  getCadetNames() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      firstName = prefs.getString("firstName");
      lastName = prefs.getString("lastName");
    });
  }

/*
Author:  Kyle Serruys
This is the function used to take a snapshot of our collection and import the
first and last name of the users in the users collection.
  */
  getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = await FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((docSnapshot) {
      docSnapshot.docs.forEach((element) {
        userList.add(element.data()['firstName'].toString() +
            element.data()['lastName'].toString());
      });
    });
    setState(() {});
  }

  /*
  Author:  Kyle Serruys
  This list takes the users from our users collection and adds a button with
  their name on it.  This will populate for each and every user in the users
  collection.
  */
  List<Widget> makeButtonsList() {
    for (int i = 0; i < userList.length; i++) {
      userButtonList.add(
        new ElevatedButton(
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            selectedUserList.add(userList[i]);
            prefs.setStringList('selectedUserList', selectedUserList);
            navigation.currentState.pushNamed('/individualEvalConfirmationPage');
          },
          child: Text(userList[i]),
        ),
      );
    }
    return userButtonList;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Peer Review Request'),
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.logout),
              onPressed: () {
                alertSignOut(context);
              }),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(25.0),
        child: Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50.0, bottom: 70.0),
                  child: Text('Select Cadet:'),
                ),
                Container(
                  child: Column(
                    children: makeButtonsList(),
                  ),
                ),
                Container(
                  child: Column(
                    children: <Widget>[

                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                ),
              ]),
        ),
      ),

    );
  }
}
