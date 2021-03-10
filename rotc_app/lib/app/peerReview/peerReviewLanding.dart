import 'package:animated_button/animated_button.dart';
import 'package:flutter/material.dart';
import '../../main.dart';

class peerReviewForm extends StatelessWidget {
  bool isCadre = false;
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
                visible: isCadre == false,
                child: AnimatedButton(
                  child: Text(
                    'Start Evaluation on an individual',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () {
                    navigation.currentState.pushNamed('/peerReviewLLAB2FT');
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
                visible: isCadre == false,
                child: AnimatedButton(
                  child: Text(
                    'Request Others to Evaluate an individual',
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
                    'View Individual Evaluation Profile',
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
                    'Respond to Pending Eval Requests',
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
          ],
        ),
      ),
    );
  }
}
