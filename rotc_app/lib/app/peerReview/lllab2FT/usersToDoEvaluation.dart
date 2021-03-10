import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rotc_app/common_widgets/buttonWidgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../main.dart';

class UsersToDoEvaluation extends StatefulWidget {
  @override
  _UsersToDoEvaluationState createState() => _UsersToDoEvaluationState();
}

class _UsersToDoEvaluationState extends State<UsersToDoEvaluation> {
  var userList = new List<String>();
  var usersToEvaluate = new List<String>();
  var usersToDoEvaluation = new List<String>();
  var selectUsersList = new List<String>();

  List<ElevatedButton> userButtonList = new List<ElevatedButton>();
  String firstName = "";
  String lastName = "";

  CollectionReference evaluationRequests = FirebaseFirestore.instance.collection('userEvaluationRequests');

  Future<void> userEvaluationRequests() {
    selectUsersList.forEach((evaluator) {
      usersToEvaluate.forEach((evaluatee) {
        return evaluationRequests.add({
          "evaluator": evaluator,
          "evaluatee":evaluatee,
          "status":"Pending"
        });
      });
    });


    /*return evaluationRequests.add({
      "usersToEvaluate": usersToEvaluate,
      "usersToDoEvaluation": selectUsersList,
    });*/
  }

/*
Author:  Kyle Serruys

  */
  @override
  void initState() {
    super.initState();
    getUserInfo();
    getUsersToEvaluate();
  }

  getUsersToEvaluate() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    usersToEvaluate = prefs.getStringList("usersToEvaluate");
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
            selectUsersList.add(userList[i]);
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
                  child: Text('Select One or More Individuals who will be evaluating previously selected people - you ca evaluate yourself:'),
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
      bottomNavigationBar: Padding(
        padding:
        EdgeInsets.only(bottom: 40.0, left: 10.0, top: 40.0, right: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: Text('Submit'),
              onPressed: () async {
                SharedPreferences prefs= await SharedPreferences.getInstance();
                await userEvaluationRequests();
                prefs.remove("usersToEvaluate");
                navigation.currentState.pushNamed('/homePage');
              },
            ),
          ],
        ),
      ),
    );
  }
}
