import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:animated_button/animated_button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  bool isCadre;

  @override
  void initState() {
    super.initState();
    getBool();
    //  initSliderValue();
  }


  getBool() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isCadre = prefs.getString('isCadre') == 'true';
    });
  }


  @override
  Widget build(BuildContext context) {
    const TextStyle tabTextStyle =
        TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(25.0),
        //color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            //Cadre View
            Center(
              child: Visibility(
                visible: isCadre == true,
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: <Widget>[
                  Text(
                    '    Cadre View    ',
                    style: TextStyle(
                      fontSize: 50.0,
                      color: Colors.black45,
                      fontWeight: FontWeight.bold,
                      //decoration: TextDecoration.underline,
                    ),
                  ),
                ],
                ),
              ),
            ),

            //Cadet View
            Center(
              child: Visibility(
                visible: isCadre == false,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '    Cadet View    ',
                      style: TextStyle(
                        fontSize: 50.0,
                        color: Colors.black45,
                        fontWeight: FontWeight.bold,
                        //decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            //Underline
            Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '                                                                                          ', //length of underline
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black45,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
            ),
            SizedBox(
              height: 20.0,
            ),
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
                  height: 90,
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
                    navigation.currentState.pushNamed('/peerReviewRequest');
                  },
                  width: 350,
                  height: 90,
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
                  height: 90,
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
                          ' View Pending Requests',
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
                    navigation.currentState.pushNamed('/notifications');
                  },
                  width: 350,
                  height: 90,
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
