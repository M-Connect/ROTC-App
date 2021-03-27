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
Ui for the sign in page, turned into the replacement
for the welcome page. User begins here.
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

      body: SingleChildScrollView(
        padding: EdgeInsets.all(25.0),
        child: Form(
          // ignore: deprecated_member_use
          autovalidate: true,
          //child: SizedBox(height: 100.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 100.0, bottom: 100.0),
                  child: Text('ROTC App',
                    style: TextStyle(fontSize: 40.0,
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),


                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: email,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Email',
                      ),
                      //onSaved: (String value) {},********************
                      validator: MultiValidator([
                        RequiredValidator(errorText: "Required"),
                        EmailValidator(errorText: "Not a valid email"),
                      ]
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                      //child: Text('Password: '),
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
                      ]
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                ),
                Container(
                  width: double.infinity,
                  height: 50.0,
                  child: ElevatedButton(
                    child: Text('Sign In',
                        style: TextStyle(
                          fontSize: 15.0,
                        )
                    ),
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


                        Navigator.pushNamed(context, '/homePage');

                      } catch (e) {
                        alertDialog(context);
                      }
                    },
                  ),
                ),

                //added forgot password button - MRU
                SizedBox(height: 1.0),
                Container(
                    child: Row(
                      children: [
                        TextButton(
                          child: Text(
                            "Forgot password?",
                            style: TextStyle(
                              color: Colors.blueAccent,
                              //decoration: TextDecoration.underline,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(
                                context, '/forgotPassword');
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 95.0),
                        ),
                        TextButton(
                          child: Text(
                            "New user? Sign up",
                            style: TextStyle(
                              color: Colors.blueAccent,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(
                                context, '/register');
                          },
                        ),
                      ],
                    )
                )
              ]
          ),
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