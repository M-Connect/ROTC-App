import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:animated_button/animated_button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../main.dart';

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
            Center(
              child: Visibility(
                visible: isCadre == true,
                child: AnimatedButton(
                  child: Text(
                    'Start evaluation on an individual',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () {
                    navigation.currentState.pushNamed('/peerReview');
                  },
                  width: 300,
                  height: 80,
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
                  child: Text(
                    'Request others to evaluate an individual',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () {},
                  width: 300,
                  height: 80,
                  shadowDegree: ShadowDegree.dark,
                  duration: 100,
                ),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Container(
                child: AnimatedButton(
                  child: Text(
                    'View individual evaluation profile',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () {
                    navigation.currentState.pushNamed('/lineGraph');
                  },
                  width: 300,
                  height: 80,
                  shadowDegree: ShadowDegree.dark,
                  duration: 100,
                ),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Container(
                child: AnimatedButton(
                  child: Text(
                    'Respond to pending eval requests',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () {
                    navigation.currentState.pushNamed('/notifications');
                  },
                  width: 300,
                  height: 80,
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
