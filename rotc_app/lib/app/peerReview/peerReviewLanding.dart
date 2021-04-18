import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:animated_button/animated_button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rotc_app/common_widgets/buttonWidgets.dart';
import '../../main.dart';

/*
The main peer review page for the user to access any of
the following features:
1. Starting the user's evaluation
2. Requesting a user's evaluation
3. Viewing the user's evaluation profile
4. Viewing the user's pending requests
*/

class PeerReviewForm extends StatefulWidget {
  PeerReviewForm() : super();

  @override
  PeerReviewFormState createState() => PeerReviewFormState();
}

class PeerReviewFormState extends State<PeerReviewForm> {

  var userList = new List<String>();
  Map evaluationMap = new Map();
  List<ElevatedButton> userButtonList = new List<ElevatedButton>();
  var selectUsersList = new List<String>();
  String selectedActivityString = "";
  String selectedUserString = "";

  var statusList = new List<String>();
  String firstName = "";
  String lastName = "";
  String status = "";
  String uid = "";

  bool isCadre;

  @override
  void initState() {
    super.initState();
    getBool();
    getUserToEvaluateData();
    getUserInfo();
    //  initSliderValue();
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
  }


  getBool() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var currentUser = await FirebaseAuth.instance.currentUser;

    setState(() {
      isCadre = prefs.getString('isCadre') == 'true';
    });
  }


  getUserToEvaluateData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var currentUser = await FirebaseAuth.instance.currentUser;

    setState((){
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

        if(evaluator == userName) {
          var userKey = uid + evaluatee + userList.length.toString();
          evaluationMap[userKey] = element.id;
          userList.add(evaluatee);
          if(status == "Pending"){
            statusList.add(status);
          }
        }
      }
      );
    }
    );
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    const TextStyle tabTextStyle =
    TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 50, right: 5, left: 5, bottom: 50),
        //color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Center(
              child: Visibility(
                visible: isCadre == true,
                child: AnimatedButton(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.assignment_outlined,
                          size: 32.5,
                          color: Colors.white,
                        ),
                        SizedBox(width: 6),
                        Text(
                          '         Start Evaluation',
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onPressed: () {
                    navigation.currentState.pushNamed('/peerReview');
                  },
                  width: 400,
                  height: 100,
                  shadowDegree: ShadowDegree.dark,
                  duration: 100,
                ),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Visibility(
                visible: isCadre == true,
                child: AnimatedButton(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.assignment_outlined,
                          size: 32.5,
                          color: Colors.white,
                        ),
                        SizedBox(width: 6),
                        Text(
                          '      Request Evaluation',
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onPressed: () {
                    navigation.currentState.pushNamed('/peerReviewRequest');
                  },
                  width: 400,
                  height: 100,
                  shadowDegree: ShadowDegree.dark,
                  duration: 100,
                ),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Container(
                child: AnimatedButton(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.assessment_outlined,
                          size: 32.5,
                          color: Colors.white,
                        ),
                        SizedBox(width: 6),
                        Text(
                          '    View Evaluation Profile',
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onPressed: () {
                    navigation.currentState.pushNamed('/lineGraph');
                  },
                  width: 400,
                  height: 100,
                  shadowDegree: ShadowDegree.dark,
                  duration: 100,
                ),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Container(
                child: AnimatedButton(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.add_alert_outlined,
                          size: 32.5,
                          color: Colors.white,
                        ),
                        SizedBox(width: 6),
                        Text(
                          '    View ' + statusList.length.toString() +  ' Pending Requests',
                          style: TextStyle(
                            fontSize: 23,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onPressed: () {
                    navigation.currentState.pushNamed('/notifications');
                  },
                  width: 400,
                  height: 100,
                  shadowDegree: ShadowDegree.dark,
                  duration: 100,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
