import 'package:flutter/material.dart';
import 'package:rotc_app/app/peerReview/peerReviewLanding.dart';
import 'package:rotc_app/common_widgets/buttonWidgets.dart';

/*
 Author: Kyle Serruys
  This class is the home page for our FLX Flight Commander peer review
 */

class PeerReviewFLXFlight extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FLX Flight Commander Peer Review'),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.logout),
        onPressed: () {
          alertSignOut(context);
        }),
        ],
      ),
    );
  }
}
