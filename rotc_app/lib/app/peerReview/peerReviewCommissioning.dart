import 'package:flutter/material.dart';
import 'package:rotc_app/app/peerReview/peerReviewLanding.dart';

/*
 Author: Kyle Serruys
  This class is the home page for our Commissioning Planning peer review
 */

class PeerReviewCommissioning extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Commissioning Planning Peer Review"),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.logout),
            onPressed: signOut,
          ),
        ],
      ),
    );
  }
}

