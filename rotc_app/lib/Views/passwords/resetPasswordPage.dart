import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:form_field_validator/form_field_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ForgotPassword.dart';

class ResetPasswordPage extends StatefulWidget {
  /* CollectionReference users = FirebaseFirestore.instance.collection('users');

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<void> updatePassword() async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    SharedPreferences pref = await SharedPreferences.getInstance();
    var newPassword = pref.getString("currentEvaluationId");
    users.doc(newPassword).update({
      'password': password.text,
    });
  }

  Future<void> userRegistration(String id) {
    return users.doc(id).set({
      'email': email.text,
      'password': password.text,
      'isCadre': false,
    });
  }
*/
  static final SizedBox spaceBetweenFields = SizedBox(height: 20.0);

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  CollectionReference user = FirebaseFirestore.instance.collection('users');

  String pass;

  TextEditingController password = TextEditingController();

  String p = '';


  Future resetPassword(String newPassword) async {
    var pinAndEmail = sendPinAndEmail().split(',');
    var tempEmail = pinAndEmail[0].replaceAll("[", "");
    String email = tempEmail.trim();

    FutureBuilder<DocumentSnapshot>(
      future: user.doc(email).get(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){

        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data();
          print("${data['password']}");
          return Text("Full Name: ${data['password']}");
        }

        return Text("loading");

      },
    );



    /* user.doc(email).get().then((docD) {
      docD.data().forEach((result) {
        var pas = element.data()['password'].toString();
      });
    });*/
    String pwd;
    /*
    * DocumentReference docRef =
    FirebaseFirestore.instance.collection('users').doc(email).get().then((docSnap) {
      docSnap.docs.forEach((result) {
        var pas = element.data()['password'].toString();
      });
    });
    * */

    // String pwd = docRef.get();

    // print(docRef);
    /*String doc = docRef. as String;
//await FirebaseAuth.instance.signInWithEmailAndPassword(email: newEmail, password: newPassword);
    var event1;
    event1 = FirebaseFirestore.instance
        .collection("users")
        .where(email, isEqualTo: 1)
        .snapshots().toList();
      /*  .listen((event) {
      print(event.docs);
    });*/
*/

//.get();
    /* user.updatePassword(newPassword);
    FirebaseFirestore.instance
        .collection("user")
        .doc(user.uid)
        .update({"password": newPassword}).then(
            (value) => print("password database update was successful"));

   _auth.signOut().then((value) => print("user successfully signed out "));*/
  }

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
                        MinLengthValidator(5,
                            errorText:
                            "Password must be at least 5 characters."),
                      ]),
                    ),
                  ],
                ),
                ResetPasswordPage.spaceBetweenFields,
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
                      validator: (value) =>
                          MatchValidator(errorText: "Passwords do not match")
                              .validateMatch(value, pass),
                    ),
                    Container(
                      child: Padding(
                        padding:
                        const EdgeInsets.fromLTRB(247.0, 12.0, 0.0, 30.0),
                        child: ElevatedButton(
                          child: Text('Reset'),
                          onPressed: () async {
                            // try {
                            //updatePassword();
                            resetPassword(pass);

                            ///Sending to signInPage instead of welcomePage -Christine
                            // Navigator.pushNamed(context, '/signIn');
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
    );
  }
}
