import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'passwords/ForgotPassword.dart';

class ConfirmToRegister extends StatefulWidget {
  @override
  _ConfirmToRegisterState createState() => _ConfirmToRegisterState();
}

class _ConfirmToRegisterState extends State<ConfirmToRegister> {
  String pass;
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  TextEditingController _emailPin = TextEditingController();
  String pin;
  _registrationPin() async {
    FirebaseFirestore.instance
        .collection("registerPin")
        .doc("registerPin")
        .get()
        .then((querySnapshot) {
      //print("result");
      //print(querySnapshot.data());

      //convert the result to a model
      var userModel = new UserModel();
      userModel.fromMap('registerPin', querySnapshot.data());

      // print(userModel.getId());
      print(userModel.name);
      pin = userModel.name;
      //print("temp =  $temp");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('M-Connect Pin Field'),
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
                  '* indicates a required field. ',
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
                      'Enter your M-Connect Pin to register*',
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
                      validator: MinLengthValidator(7,
                          errorText: "Pin is more then 7 characters."),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding:
                      const EdgeInsets.fromLTRB(247.0, 12.0, 0.0, 30.0),
                      child: ElevatedButton(
                        child: Text('Start Registration'),
                        onPressed: () async {
                          _registrationPin();
                          final snackBar =
                          SnackBar(content: Text('Pin not found!'));

                          if (_emailPin.text.trim() == pin.trim()) {
                            print("Registration pin match found");
                            Navigator.popAndPushNamed(context, '/register');
                            return 0;
                          } else {
                            print("No match for the registration pin");
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, bottom: 10.0, right: 10.0, left: 10.0),
                    child: Text(
                        "Note:\nThis pin should be given to you by your cadre because without it, you can't register"),
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

class UserModel {
  String _id = "";
  String name;

  UserModel({this.name});

  void fromMap(String id, Map map) {
    //this._id = id;
    this.name = map["registerPin"];
  }

  String getId() {
    return this._id;
  }
}