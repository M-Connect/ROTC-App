import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:form_field_validator/form_field_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ForgotPassword.dart';

/*
* Author: Mac-Rufus Umeokolo
* This page requests the user to enter the pin sent to there email
* before they can register
* */

class ProcessPin extends StatefulWidget {
  @override
  _ProcessPinState createState() => _ProcessPinState();
}

class _ProcessPinState extends State<ProcessPin> {
  CollectionReference resetpassword =
      FirebaseFirestore.instance.collection('resetpassword');
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<void> userPasswsordChange(String id) {
    return users.doc(id).set({
      'email': email.text,
      'password': password.text,
      'isCadre': false,
    });
  }

  Future<void> userPasswordChange(String id) {
    return users.doc(id).set({
      'email': email.text,
      'password': password.text,
      'isCadre': false,
    });
  }

  Future<void> userRegistration(String id) {
    return resetpassword.doc(id).set({
      'email': email.text,
      'password': password.text,
      'isCadre': false,
    });
  }

  String pass;
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  TextEditingController _emailPin = TextEditingController();
  _passwordReset(String mail) async {

    try {
     // _formKey.currentState.save();
      await _auth.sendPasswordResetEmail(email: mail.trim());

      Navigator.of(context).pop();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return AlertDialog(
            title: Text("Password Reset"),
            content: Text("An email has been sent out. Use link to reset password."),
            actions: [

              TextButton(
                onPressed: () {
                  //Navigator.of(context).pop();

                  Navigator.popAndPushNamed(context, '/signIn');
                },
                child: Text("Close"),
              ),
            ],
          );
          /*ConfirmEmailView(
            message: widget.message,
          );*/
        }),

      );
    } catch (e) {
      print(e);
    }
  }


  @override
  Widget build(BuildContext context) {
    var pinAndEmail = sendPinAndEmail().split(',');
    var email = pinAndEmail[0].replaceAll("[", "");
    var pin = pinAndEmail[1].replaceAll("]", "");



    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Password Pin Field'),
      ),
      body: Form(
        // ignore: deprecated_member_use
        autovalidate: true,
        //  key: key,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 10.0, bottom: 10.0, right: 10.0, left: 10.0),
                child: Text(
                  '* indicates a required field.',
                  style: TextStyle(
                    color: Colors.red,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, bottom: 10.0, right: 10.0, left: 10.0),
                    child: Text(
                      'Enter Pin to reset $email*',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, bottom: 10.0, right: 10.0, left: 10.0),
                    child: TextFormField(
                      controller: _emailPin,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      onSaved: (String value) {},
                      validator: MinLengthValidator(5,
                          errorText: "Password is more then 7 characters."),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding:
                          const EdgeInsets.fromLTRB(247.0, 12.0, 0.0, 30.0),
                      child: ElevatedButton(
                        child: Text('Reset'),
                        onPressed: () async {
                          final snackBar = SnackBar(content: Text('Pin not found!'));

                          if (_emailPin.text.trim() == pin.trim()) {
                            print(_emailPin.text);
                            _passwordReset(email);

                            return 0;
                          }
                          else {
                            print(_emailPin.text + "a" + pin);
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}