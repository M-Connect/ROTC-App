import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:googleapis/doubleclickbidmanager/v1_1.dart';
import 'package:rotc_app/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

/*
Sawyer Kisha
02/02/2021
1.0 - Prototype 01
Ui for the sign in page

Co-Author:  Kyle Serruys
Added Validation for the email and password properties
*/
class SignInView extends StatefulWidget {
  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  //Controllers for e-mail and password textfields.
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  //Handling signup and signin
  bool signUp = true;
  bool isCadre;
  final String firstName="";
  final String lastName="";
  final String nickname = "";
  final String emailAddress ="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            navigation.currentState.pushNamed('/welcomePage');
          },
        ),
        title: Text('Sign-In'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(25.0),
        child: Form(
          // ignore: deprecated_member_use
          autovalidate: true,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Text('Email: '),
                ),
                TextFormField(
                  controller: email,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Email',
                  ),
                  //onSaved: (String value) {},********************
                  validator: MultiValidator([
                    RequiredValidator(errorText: "Required"),
                    EmailValidator(errorText: "Not a valid email"),
                  ]),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Text('Password: '),
                    ),
                    TextFormField(
                      controller: password,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter Password',
                      ),
                      obscureText: true,
                      // onSaved: (String value) {},******************
                      validator: MultiValidator([
                        MinLengthValidator(5,
                            errorText:
                                "Password must be at least 5 characters."),
                      ]),
                    ),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: ElevatedButton(
                              child: Text('Sign In'),
                              onPressed: () async {
                                try {
                                 /* context.read<Auth>().signIn(
                                      email: email.text.trim(),
                                      password: password.text.trim());*/

                                  UserCredential user = await FirebaseAuth
                                      .instance
                                      .signInWithEmailAndPassword(
                                      email: email.text,
                                      password: password.text);

                                  var currentUser = await FirebaseAuth.instance.currentUser;
                                  SharedPreferences prefs = await SharedPreferences.getInstance();

                                  var uid = currentUser.uid;

                                  var data = await FirebaseFirestore.instance.collection('users').doc(uid).get().then((docSnapshot) {
                                    return docSnapshot.data();
                                  });

                                  await prefs.setString('firstName', data['firstName'].toString());
                                  await prefs.setString('lastName', data['lastName'].toString());
                                  await prefs.setString('nickname', data['nickName'].toString());
                                  await prefs.setString('email', currentUser.email);
                                  await prefs.setString('isCadre', data['isCadre'].toString());

                                  if (user.user.emailVerified) {
                                    Navigator.pushNamed(context, '/homePage');
                                  }
                                  else
                                    {
                                      _verifyEmailAlertDialog(context);
                                    }

                                } catch (e) {
                                  alertDialog(context);
                                }
                              },
                            ),
                          ),

                          //added forgot password button - MRU
                          SizedBox(height: 1.0),
                          Column(
                            children: [
                              TextButton(
                                child: Text(
                                  "Forgot Password?",
                                  style: TextStyle(
                                    color: Colors.blueAccent,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, '/forgotPassword');
                                },
                              ),
                            ],
                          ),
                        ])
                  ],
                ),
              ]),
        ),
      ),
    );
  }
}

alertDialog(BuildContext context) {
  Widget button = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.pushNamed(context, '/signIn');
    },
  );
  AlertDialog alert = AlertDialog(
    title: Text("Error"),
    content: Text("Invalid login, please re-enter your email and password."),
    actions: [
      button,
    ],
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}



Future<void> _verifyEmailAlertDialog(BuildContext context) async {
  Widget button = FlatButton(
    child: Text("close"),
    onPressed: () {
      Navigator.pushNamed(context, '/signIn');
    },
  );
  AlertDialog alert = AlertDialog(
    title: Text("Verify Email"),
    content: Text("your email isn't regiestered with us yet or \n"
        "has not yet been verified."),
    actions: [
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      button,
    ],
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
