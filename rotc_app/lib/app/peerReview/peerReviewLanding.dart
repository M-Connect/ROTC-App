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
