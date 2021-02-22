import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:rotc_app/Views/welcomePage.dart';
import 'package:rotc_app/app/peerReview/peerReviewLanding.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  User user;

  void userUpdate(User user){
    setState(() {
      user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(user == null){
      return WelcomeView();
    }
    return WelcomeView(

    );
  }
}
