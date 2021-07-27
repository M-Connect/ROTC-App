import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:rotc_app/Views/signInPage.dart';

/*
* Author: Mac-Rufus Umeokolo
* Directs the user to the Sign-in page
* */
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
      return SignInView();
    }
    return SignInView(

    );
  }
}
