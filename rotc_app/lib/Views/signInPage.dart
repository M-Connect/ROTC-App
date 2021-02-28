import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:rotc_app/services/auth.dart';
import 'package:provider/provider.dart';

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
  CollectionReference cadres = FirebaseFirestore.instance.collection('cadres');
  CollectionReference cadets = FirebaseFirestore.instance.collection('cadets');

  //Controllers for e-mail and password textfields.
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  //Handling signup and signin
  bool signUp = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign-In'),


      ),
      body: Container(
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
                  child: Text('Username / Email: '),
                ),
                TextFormField(
                  controller: email,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Username / Email',
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
                        hintText: 'Password',
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
                                  context.read<Auth>().signIn(
                                    email: email.text.trim(),
                                    password: password.text.trim());
                                      Navigator.pop(context, '/home');

                                  /*
                                  UserCredential user = await FirebaseAuth
                                      .instance
                                      .signInWithEmailAndPassword(
                                          email: email.text,
                                          password: password.text);
                                  Navigator.pushNamed(context, '/home');*/

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
