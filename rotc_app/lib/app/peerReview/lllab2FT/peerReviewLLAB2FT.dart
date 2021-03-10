import 'package:flutter/material.dart';

import '../../../main.dart';
import '../peerReviewLanding.dart';

/*
 Author: Kyle Serruys
  This class is the home page for our LLAB2FT peer review
 */

class PeerReviewLLAB2FT extends StatelessWidget {

  static final SizedBox spaceBetweenFields = SizedBox(height: 40.0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            navigation.currentState.pushNamed('/homePage');
          },
        ),
        title: Text('LLAB 2FT Peer Review'),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.logout),
            onPressed: (){},
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(25.0),
        color: Colors.white,
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[

            Container(
              child: ElevatedButton(
                child: Text('Planning'),
                onPressed: () {
                  navigation.currentState.pushNamed('/planning');
                },
              ),
            ),
            Container(
              child: ElevatedButton(
                child: Text('Communication'),
                onPressed: () {
                  navigation.currentState.pushNamed('/communication');
                },
              ),
            ),

            Container(
              child: ElevatedButton(
                child: Text('Execution'),
                onPressed: () {
                  navigation.currentState.pushNamed('/execution');
                },
              ),
            ),
            Container(
              child: ElevatedButton(
                child: Text('Leadership'),
                onPressed: () {
                  navigation.currentState.pushNamed('/leadership');
                },
              ),
            ),
            Container(
              child: ElevatedButton(
                child: Text('Debrief'),
                onPressed: () {
                  navigation.currentState.pushNamed('/debrief');
                },
              ),
            ),
            spaceBetweenFields,
            Container(

              child: ElevatedButton(

                child: Text('Confirmation'),
                onPressed: () {
                  navigation.currentState.pushNamed('/confirmation');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
