import 'package:flutter/material.dart';
import '../../main.dart';

class peerReviewForm extends StatelessWidget {

  bool isCadre = false;
  @override
  Widget build(BuildContext context) {
    const TextStyle tabTextStyle =
    TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(25.0),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              child: ElevatedButton(
                child: Text('Peer Review'),
                onPressed: () {
                  navigation.currentState.pushNamed('/peerReview');
                },
              ),
            ),
            Visibility(
              visible: isCadre == true,
              child: Container(
                child: ElevatedButton(
                  child: Text('Request a Peer Review'),
                  onPressed: () {
                    navigation.currentState.pushNamed('/peerReviewRequest');
                  },
                ),
              ),
            ),
            Container(
              child: ElevatedButton(
                child: Text('Review Stats'),
                onPressed: () {
                  navigation.currentState.pushNamed('/peerReviewStats');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
