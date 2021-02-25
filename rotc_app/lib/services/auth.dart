import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Auth {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseAuth firebaseAuth;

  Auth(this.firebaseAuth);

  Stream<User> get authState => firebaseAuth.idTokenChanges();

  //TODO move registration code here


  //TODO move signin code here
  Future<String> signIn({String email, String password}) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return "Signed in";
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

 /* //TODO move logout code here
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }*/

 //TODO who is current user code here
  Future<String> uid() async {
    return firebaseAuth.currentUser.uid;
  }
  /*
  Future<void> logOut() async {
    await auth.signOut();
  }*/


}

