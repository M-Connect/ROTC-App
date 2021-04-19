import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*
 Author: Christine Thomas
 This class creates the UI for the RegistrationPage.

  Co-Author:  Kyle Serruys
  This class now has the functionality to connect to our users database.
  This class now has validation on first name, last name, email, and password fields.
  Co-Author: Mac-Rufus Umeokolo
*/

// ignore: must_be_immutable
class RegistrationView extends StatelessWidget {
  // This is a collection reference to the users collection
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  // Declaring and initializing the text editing controllers to be able to get the user's input
  TextEditingController fName = TextEditingController();
  TextEditingController lName = TextEditingController();
  TextEditingController nName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

// setting the fields in the database to the user's input
  Future<void> userRegistration(String id) {
    return users.doc(id).set({
      'firstName': fName.text,
      'lastName': lName.text,
      'nickName': nName.text,
      'email': email.text,
      'password': password.text,
      'isCadre': false,
    });
  }

  String pass;

  // styling variable for between text fields
  static final SizedBox spaceBetweenFields = SizedBox(height: 20.0);

  // Author: Mac-Rufus Umeokolo
// This method displays an alert dialog to the user to verify their email.
  // It takes as a parameter the context of type BuildContext and returns a type of
  // Future<void>. Once the user hits close on the alert dialog they will be re-routed to the
  // Sign-In Page.
  Future<void> _verifyEmailAlertDialog(BuildContext context) async {
    Widget button = FlatButton(
      child: Text("Close"),
      onPressed: () {
        Navigator.pushNamed(context, '/signIn');
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text("Verify Email"),
      content: Text("An email has been sent to you. \n"
          "Don't forget to verify your email before signing-in"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: null,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Register'),
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
                Padding(
                  padding: const EdgeInsets.only(left: 3.0, bottom: 6.0),
                  child: RichText(
                    text: TextSpan(
                      text: 'First Name',
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: ' *',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                TextFormField(
                  controller: fName,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'John',
                  ),
                  onSaved: (String value) {},
                  validator: MultiValidator([
                    RequiredValidator(errorText: "First name is required."),
                    PatternValidator(r'([a-zA-Z])',
                        errorText: 'First name can only contain letters.'),
                  ]),
                ),
                spaceBetweenFields,
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 3.0, bottom: 6.0),
                      child: RichText(
                        text: TextSpan(
                          text: 'Last Name',
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: ' *',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: lName,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Doe',
                      ),
                      onSaved: (String value) {},
                      validator: MultiValidator([
                        RequiredValidator(errorText: "Last name is required."),
                        PatternValidator(r'([a-zA-Z])',
                            errorText: 'Last name can only contain letters.'),
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
                      child: RichText(
                        text: TextSpan(
                          text: ' Nickname',
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: ' *',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: nName,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: '\"The Deer\"',
                      ),
                      onSaved: (String value) {},
                      validator: (String value) {
                        return value.contains('_')
                            ? 'Only type in letters and numbers.'
                            : null;
                      },
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
                      child: RichText(
                        text: TextSpan(
                          text: 'Email',
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: ' *',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: email,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'johndoe@rotc.com',
                      ),
                      onSaved: (String value) {},
                      validator: MultiValidator([
                        RequiredValidator(errorText: "Required"),
                        EmailValidator(errorText: "Not a valid email"),
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
                      child: RichText(
                        text: TextSpan(
                          text: 'Password',
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: ' *',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
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
                spaceBetweenFields,
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 3.0, bottom: 6.0),
                      child: RichText(
                        text: TextSpan(
                          text: 'Confirm Password',
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: ' *',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
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
                          child: Text('Register'),
                          onPressed: () async {
                            // try {
                            final newUser = await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                    email: email.text, password: password.text);
                            var currentUser =
                                await FirebaseAuth.instance.currentUser;

                            await userRegistration(currentUser.uid);
                            await newUser.user.sendEmailVerification();
                            _verifyEmailAlertDialog(context);

                            ///Sending to signInPage instead of welcomePage -Christine
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

/* Author:
This method shows an alert dialog to the user if their inputted email address is already taken.
Upon hitting OK they will be routed back to the Registration Page.
 */
Future<void> alertDialog(BuildContext context) {
  Widget button = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.pushNamed(context, '/register');
    },
  );
  AlertDialog alert = AlertDialog(
    title: Text("Error"),
    content: Text(
        "Email Address is Already Taken.  Please Use Another Email Address."),
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
