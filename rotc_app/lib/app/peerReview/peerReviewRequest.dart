import 'package:flutter/material.dart';


/*
 Author: Kyle Serruys
  This class is the home page for our peer review request page
 */
class PeerReviewRequest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Peer Review request'),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.logout),
            onPressed: () {

            },
          ),
        ],
      ),
    );
  }
}
