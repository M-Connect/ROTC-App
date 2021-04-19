import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:animated_button/animated_button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../main.dart';

/*
Author: Sawyer Kisha
The main peer review page for the user to access any of
the following features:
1. Starting the user's evaluation
2. Requesting a user's evaluation
3. Viewing the user's evaluation profile
4. Viewing the user's pending requests
*/

/*
Creating peer review form state -SK
 */
class PeerReviewForm extends StatefulWidget {
  PeerReviewForm() : super();

  @override
  PeerReviewFormState createState() => PeerReviewFormState();
}

/*
Database data such as
firstName
lastName
status
uid
selected user
selected string
 */
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

  /*
  initing evaluation and user data from database -SK
   */
  @override
  void initState() {
    super.initState();
    getBool();
    getUserToEvaluateData();
    getUserInfo();
    //  initSliderValue();
  }

  /*
  Firebase peereval and evalrequest collections -SK
   */
  CollectionReference evaluation =
  FirebaseFirestore.instance.collection('peerEvaluation');
  CollectionReference evaluationRequests =
  FirebaseFirestore.instance.collection('userEvaluationRequests');

  /*
  Getting the evaluation data from database. -SK
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
  }

  /*
  If user is cadre or cadet -SK
   */
  getBool() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var currentUser = await FirebaseAuth.instance.currentUser;

    setState(() {
      isCadre = prefs.getString('isCadre') == 'true';
    });
  }

  /*
  getting evaluation data from the database such as:
  currentUser
  uid
  firstName
  lastName
  status
  -SK
   */
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
/*
Getting evaluation information from database such as:
userName
evaluator
evaluatee
status
-SK
 */
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

        /*
        Checks the number of pending requests current
        in the database for the current user -SK
         */
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
    //setting the state -SK
    setState(() {});
  }


  /*
  UI / building the page -SK
   */
  @override
  Widget build(BuildContext context) {
    const TextStyle tabTextStyle =
        TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          // Box decoration takes a gradient
          gradient: LinearGradient(
            // Where the linear gradient begins and ends
            begin: Alignment.topRight,
            end: Alignment(0.3, 0),
            tileMode: TileMode.repeated, // repeats the gradient over the canvas
            colors: [
              // Colors are easy thanks to Flutter's Colors class.
              Colors.white,
              Colors.lightBlue,
            ],
          ),
        ),
        child: Column(
          children: [
            SingleChildScrollView(
              padding:
                  EdgeInsets.only(top: 50, right: 5, left: 5, bottom: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  /*
                  Starting the evaluation -SK
                   */
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
                                '     Start Evaluation',
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
                        width: 350,
                        height: 100,
                        shadowDegree: ShadowDegree.dark,
                        duration: 100,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  /*
                  Requesting evaluation -SK
                   */
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
                                '   Request Evaluation',
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
                          navigation.currentState
                              .pushNamed('/peerReviewRequest');
                        },
                        width: 350,
                        height: 100,
                        shadowDegree: ShadowDegree.dark,
                        duration: 100,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  /*
                  Viewing the current user's profile
                  that consists of their evaluation
                  data -SK

                  Sends to the line graph and the bar
                  graph -SK
                   */
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
                                ' View Evaluation Profile',
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
                        width: 350,
                        height: 100,
                        shadowDegree: ShadowDegree.dark,
                        duration: 100,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  /*
                  Viewing the pending requests which
                  is where the current user is able
                  to complete their requested
                  evaluations -SK

                  Shows the number of the currently
                  pending requests -SK
                   */
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
                        width: 350,
                        height: 100,
                        shadowDegree: ShadowDegree.dark,
                        duration: 100,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
