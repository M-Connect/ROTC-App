import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:rotc_app/app/peerReview/peerReview.dart';
import 'package:rotc_app/app/peerReview/peerReviewLanding.dart';
import 'package:rotc_app/common_widgets/buttonWidgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../main.dart';

/*
 Author: Sawyer Kisha
 Co-author: Kyle Serruys
  This class is the home page for our peer review request page
  Needs functionality
 */

class PeerReviewRequest extends StatefulWidget {
  PeerReviewRequest() : super();

  @override
  PeerReviewRequestState createState() => PeerReviewRequestState();
}

class PeerReviewRequestState extends State<PeerReviewRequest> {
  var userList = new List<String>();
  var usersToEvaluate = new List<String>();
  var selectUsersList = new List<String>();

  List<ElevatedButton> userButtonList = new List<ElevatedButton>();
  String firstName = "";
  String lastName = "";

  @override
  void initState() {
    super.initState();
    getUserInfo();
    //  initSliderValue();
  }

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

  List<Widget> makeButtonsList() {
    for (int i = 0; i < userList.length; i++) {
      userButtonList.add(
        new ElevatedButton(
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            usersToEvaluate.add(userList[i]);
            prefs.setStringList('usersToEvaluate', usersToEvaluate);
          },
          child: Container(
              width: 200,
              height: 40,
              child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:<Widget>[
                    Text(userList[i])
                  ]
              )
          ),
        ),
    );
  }
    return userButtonList;
  }

  /*
  List<Widget> makeButtonsList() {
    for (int i = 0; i < userList.length; i++) {
      userButtonList.add(
        new ElevatedButton(
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            usersToEvaluate.add(userList[i]);
            prefs.setStringList('usersToEvaluate', usersToEvaluate);
          },
          child: Text(userList[i]),

          ),
      );
    }
    return userButtonList;
  }
*/

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Evaluation Request'),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50.0, bottom: 50.0),
                  child: Container(
                    child: Text('Select Cadet(s) Under Evaluation:',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ),

                ),
                Center(
                  child: Column(
                    children: makeButtonsList(),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                ),
              ]),
        ),
      ),

      bottomNavigationBar: Padding(
        padding:
            EdgeInsets.only(bottom: 40.0, left: 10.0, top: 40.0, right: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: Text('Next'),
              onPressed: () async {
                navigation.currentState.pushNamed('/multipleEvalConfirmationPage');
              },
            ),
          ],
        ),
      ),
    );
  }
}
