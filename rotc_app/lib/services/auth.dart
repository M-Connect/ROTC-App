import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Auth {
  final FirebaseAuth auth = FirebaseAuth.instance;

  //TODO move registration code here


  //TODO move signin code here


  //TODO move logout code here
  Future<void> logOut() async {
    await auth.signOut();
  }


}

