import 'package:flutter/material.dart';

import 'package:rotc_app/app/peerReview/peerReviewLanding.dart';
import 'package:rotc_app/common_widgets/buttonWidgets.dart';

import '../../main.dart';



class PeerReview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();;
          },
        ),
        title: Text('Peer Review'),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.logout),
              onPressed: () {
                alertSignOut(context);
              }),
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
                child: Text('LLAB 2 FT Presentation Peer Review'),
                onPressed: () {
                  navigation.currentState.pushNamed('/peerReviewLLAB2FT');
                },
              ),
            ),
            Container(
              child: ElevatedButton(
                child: Text('FLX flight Commander Peer Review'),
                onPressed: () {
                  navigation.currentState.pushNamed('/peerReviewFLXFlight');
                },
              ),
            ),
            Container(
              child: ElevatedButton(
                child: Text('Commissioning Planning Peer Review'),
                onPressed: () {
                  navigation.currentState.pushNamed('/peerReviewCommissioning');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
