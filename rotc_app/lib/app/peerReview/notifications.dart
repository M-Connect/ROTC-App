import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rotc_app/common_widgets/buttonWidgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  var userList = new List<String>();
  List<ElevatedButton> userButtonList = new List<ElevatedButton>();
  var selectUsersList = new List<String>();
String firstName = "";
String lastName = "";
String uid = "";
Map evaluationMap = new Map();

  @override
  void initState() {
    super.initState();
  getUserToEvaluateData();
    getUserInfo();

  }

  getUserToEvaluateData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var currentUser = await FirebaseAuth.instance.currentUser;

    setState(() {
      uid = currentUser.uid;
      firstName = prefs.getString('firstName');
      lastName =  prefs.getString('lastName');
    });
  }


  getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = await FirebaseFirestore.instance
        .collection('userEvaluationRequests')
        .get()
        .then((docSnapshot) {
      docSnapshot.docs.forEach((element) {
        var userName = firstName + lastName;
        var evaluator = element.data()['evaluator'].toString();
        var evaluatee = element.data()['evaluatee'].toString();
        var status = element.data()['status'].toString();

        if(evaluator == userName && status == "Pending")
          {
            var userKey = uid + evaluatee;
            //var userKey = userName + evaluatee;
            evaluationMap[userKey] = element.id;
            userList.add(evaluatee);
          }
        /*
        var evaluators = List.from(element.data()['usersToDoEvaluation']);

        if(evaluators.contains(userName)) {
          var usersToEvaluate = List.from(element.data()['usersToEvaluate']);
          usersToEvaluate.forEach((element) {userList.add(element);});
          *//*for(var user in usersToEvaluate) {
            userList.add(user.toString());
          }*//*
        }*/
      });
    });
    setState(() {});
  }

  List<Widget> makeButtonsList(){
    for (int i = 0; i < userList.length; i++) {
      userButtonList
          .add(new ElevatedButton(onPressed: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();

        var userKey =  uid + userList[i];

        //var userKey =  firstName + lastName + userList[i];
        var currentEvaluationId = evaluationMap[userKey];
        prefs.setString("currentEvaluationId", currentEvaluationId);
        selectUsersList.add(userList[i]);
        navigation.currentState.pushNamed('/peerReviewLLAB2FT');
      }, child: Text(userList[i])));
    }
    return userButtonList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Peer Review Confirmation'),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.logout),
            onPressed: () {
              alertSignOut(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(25.0),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,

          children: makeButtonsList(),
        ),

      ),

    );
  }
}
