import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rotc_app/common_widgets/buttonWidgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../main.dart';

/*
Where the user finds and accepts their requested evaluations,
once the user selects their designated evaluation that specific
evaluation will be completed and disappear.
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

  @override
  void initState() {
    super.initState();
  getUserToEvaluateData();
    getUserInfo();

  }
  CollectionReference evaluation =
  FirebaseFirestore.instance.collection('peerEvaluation');
  CollectionReference evaluationRequests =
  FirebaseFirestore.instance.collection('userEvaluationRequests');

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
       var debriefValue = documentSnapshot.data()["debriefValue"]?? "10";
       var communication = documentSnapshot.data()["communication"]?? " ";
       var communicationValue = documentSnapshot.data()["communicationValue"]?? "10";
       var execution = documentSnapshot.data()["execution"]?? " ";
       var executionValue = documentSnapshot.data()["executionValue"]?? "10";
       var leadership = documentSnapshot.data()["leadership"]?? " ";
       var leadershipValue = documentSnapshot.data()["leadershipValue"]?? "10";
       var planning = documentSnapshot.data()["planning"]?? " ";
       var planningValue = documentSnapshot.data()["planningValue"]?? "10";
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
        prefs.setString('debriefValue', "10");
        prefs.setString('communication', "");
        prefs.setString('communicationValue', "10");
        prefs.setString('execution', "");
        prefs.setString('executionValue', "10");
        prefs.setString('leadership', "");
        prefs.setString('leadershipValue', "10");
        prefs.setString('planning', "");
        prefs.setString('planningValue', "10");
      }
    });
  }

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


  getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = await FirebaseFirestore.instance
        .collection('userEvaluationRequests')
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
            //var userKey = userName + evaluatee;
            evaluationMap[userKey] = element.id;
            userList.add(evaluatee);
            statusList.add(status);
          }
      });
    });
    setState(() {});
  }

  List<Widget> makeButtonsList(){
    for (int i = 0; i < userList.length; i++) {
      userButtonList
          .add(
        new ElevatedButton(
          style: ButtonStyle(

          ),
        onPressed: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();

        var userKey =  uid + userList[i] + i.toString();

        //var userKey =  firstName + lastName + userList[i];
        var currentEvaluationId = evaluationMap[userKey];
        prefs.setString("currentEvaluationId", currentEvaluationId);
        selectUsersList.add(userList[i]);
        await getEvaluationFromDb(currentEvaluationId);
        navigation.currentState.pushNamed('/peerReviewLLAB2FT');

      }, child: Text(userList[i] + "-" + statusList[i])));


        },
          child: Container(
            width: 250,
            height: 44,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:<Widget>[
                Text(userList[i],
                  style: TextStyle(
                  fontSize: 17.0,
                ),
                ),
              ],
            ),
          ),
        ),
      );

    }
    return userButtonList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        child: Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Container(
                    child: Text('  Select Cadet    ',
                      style: TextStyle(
                        fontSize: 45.0,
                        color: Colors.black45,
                        decoration: TextDecoration.underline,
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
    );
  }
}
