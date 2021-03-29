import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:form_field_validator/form_field_validator.dart';

class ResetPasswordPage extends StatelessWidget {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();



  Future<void> userRegistration(String id)  {
    return users.doc(id).set({
      'email': email.text,
      'password': password.text,
      'isCadre': false,
    });
  }

  String pass;

  // variables
  static final SizedBox spaceBetweenFields = SizedBox(height: 20.0);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Reset Password'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(25.0, 19.0, 35.0, 8.0),
          width: MediaQuery.of(context).size.width,
          child: Form(
            // ignore: deprecated_member_use
            autovalidate: true,
            //  key: key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 3.0, bottom: 18.0),
                  child: Text(
                    '* indicates a required field.',
                    style: TextStyle(
                      color: Colors.red,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 3.0, bottom: 6.0),
                      child: Text(
                        'Password *',
                      ),
                    ),
                    TextFormField(
                      controller: password,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                      onSaved: (String value) {},
                      onChanged: (value) => pass = value,
                      validator: MultiValidator([
                        MinLengthValidator(5, errorText: "Password must be at least 5 characters."),

                      ]),
                    ),
                  ],
                ),
                spaceBetweenFields,
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 3.0, bottom: 6.0),
                      child: Text(
                        'Confirm Password *',
                      ),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                      onSaved: (String value) {},
                      validator: (value) => MatchValidator(errorText: "Passwords do not match").validateMatch(value, pass),

                    ),
                    Container(
                      child: Padding(
                        padding:
                        const EdgeInsets.fromLTRB(247.0, 12.0, 0.0, 30.0),
                        child: ElevatedButton(
                          child: Text('Reset'),
                          onPressed: () async {
                            // try {
                            await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                email: email.text, password: password.text);
                            var currentUser = await FirebaseAuth.instance
                                .currentUser;

                            await userRegistration(currentUser.uid);

                            ///Sending to signInPage instead of welcomePage -Christine
                            Navigator.pushNamed(context, '/signIn');
                            /*   } catch (e) {
                              alertDialog(context);
                             }*/
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
      ),
    );  }
}
