import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rotc_app/common_widgets/buttonWidgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';

/*
Author:  Kyle Serruys
This page will show the signed in user their pending and completed evaluations
  Co-Author: Christine Thomas
  added the isCadre check to change the appBar Color depending on which
  type of user is signed in.

 */
class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  var userList = new List<String>();
  var statusList = new List<String>();
  List<ElevatedButton> userButtonList = new List<ElevatedButton>();
  var selectUsersList = new List<String>();

String firstName = "";
String lastName = "";
String uid = "";
Map evaluationMap = new Map();
String status = "";
String selectedActivityString = "";
String selectedUserString = "";
bool isCadre = false;

  @override
  void initState() {
    super.initState();
  getUserToEvaluateData();
    getUserInfo();
    getBool();

  }
  CollectionReference evaluation =
  FirebaseFirestore.instance.collection('peerEvaluation');
  CollectionReference evaluationRequests =
  FirebaseFirestore.instance.collection('userEvaluationRequests');

  /*
 Author: Kyle Serruys
This retrieves the evaluation data from the database and stores into shared preferences
 */
  getEvaluationFromDb(String evaluationId)async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    evaluationRequests.doc(evaluationId).get().then((DocumentSnapshot documentSnapshot) {
      if(documentSnapshot.exists){
       var activity = documentSnapshot.data()["activity"]?? " ";
       prefs.setString('activity', activity);
       var evaluatee = documentSnapshot.data()["evaluatee"]?? " ";
       prefs.setString('evaluatee', evaluatee);
      }
    });
    evaluation.doc(evaluationId).get().then((DocumentSnapshot documentSnapshot){
      if(documentSnapshot.exists){
       var debrief = documentSnapshot.data()["debrief"]?? " ";
       var debriefValue = documentSnapshot.data()["debriefValue"]?? "0";
       var communication = documentSnapshot.data()["communication"]?? " ";
       var communicationValue = documentSnapshot.data()["communicationValue"]?? "0";
       var execution = documentSnapshot.data()["execution"]?? " ";
       var executionValue = documentSnapshot.data()["executionValue"]?? "0";
       var leadership = documentSnapshot.data()["leadership"]?? " ";
       var leadershipValue = documentSnapshot.data()["leadershipValue"]?? "0";
       var planning = documentSnapshot.data()["planning"]?? " ";
       var planningValue = documentSnapshot.data()["planningValue"]?? "0";
       prefs.setString('debrief', debrief);
       prefs.setString('debriefValue', debriefValue);
       prefs.setString('communication', communication);
       prefs.setString('communicationValue', communicationValue);
       prefs.setString('execution', execution);
       prefs.setString('executionValue', executionValue);
       prefs.setString('leadership', leadership);
       prefs.setString('leadershipValue', leadershipValue);
       prefs.setString('planning', planning);
       prefs.setString('planningValue', planningValue);
      } else {
        prefs.setString('debrief', "");
        prefs.setString('debriefValue', "0");
        prefs.setString('communication', "");
        prefs.setString('communicationValue', "0");
        prefs.setString('execution', "");
        prefs.setString('executionValue', "0");
        prefs.setString('leadership', "");
        prefs.setString('leadershipValue', "0");
        prefs.setString('planning', "");
        prefs.setString('planningValue', "0");
      }
    });
  }
/*
 Author: Kyle Serruys
This gets the UID, first name, last name, and activity from Shared Preferences
*/
  getUserToEvaluateData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var currentUser = await FirebaseAuth.instance.currentUser;

    setState(() {
      uid = currentUser.uid;
      firstName = prefs.getString('firstName');
      lastName =  prefs.getString('lastName');
      status = prefs.getString('status');
    });
  }

/*
 Author: Kyle Serruys
 This gets the user information from the database and adds it to a map to use later

*/
  getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = await FirebaseFirestore.instance
        .collection('userEvaluationRequests')
    .orderBy("status")
        .get()
        .then((docSnapshot) {
      docSnapshot.docs.forEach((element) {
        var userName = firstName + " " + lastName;
        var evaluator = element.data()['evaluator'].toString();
        var evaluatee = element.data()['evaluatee'].toString();
        var status = element.data()['status'].toString();

        if(evaluator == userName)
          {
            var userKey = uid + evaluatee + userList.length.toString();
            evaluationMap[userKey] = element.id;
            userList.add(evaluatee);
            statusList.add(status);
          }

      });
    });
    setState(() {});
  }
  /*
  Author:  Kyle Serruys
  This list takes the users from our users collection and adds a button with
  their name on it.  This will populate for each and every user in the users
  collection.
  Co-Author: Sawyer Kisha
  Formatted the list of cadets for the interface

  */
  List<Widget> makeButtonsList(){
    for (int i = 0; i < userList.length; i++) {
      userButtonList
          .add(new ElevatedButton(onPressed: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();

        var userKey =  uid + userList[i] + i.toString();

        var currentEvaluationId = evaluationMap[userKey];
        prefs.setString("currentEvaluationId", currentEvaluationId);
        selectUsersList.add(userList[i]);
        await getEvaluationFromDb(currentEvaluationId);
        navigation.currentState.pushNamed('/peerReviewLLAB2FT');
      }, child: Text(userList[i] + "-" + statusList[i])));

    }
    return userButtonList;
  }

  /*
  Author:  Kyle Serruys
  This gets the isCadre value from the database and will be used to allow visibility
  for certain buttons.
   */
  getBool() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isCadre = prefs.getString('isCadre') == 'true';
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isCadre ? Color(0xFF031f72) : Colors.blue,
        title: Text('Evaluation Confirmation'),
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
