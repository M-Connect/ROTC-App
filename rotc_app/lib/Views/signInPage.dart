import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:rotc_app/Views/passwords/ForgotPassword.dart';

import 'package:shared_preferences/shared_preferences.dart';
//import 'package:rotc_app/images/landscape_in_mountains.jpeg';

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
  final String firstName = "";
  final String lastName = "";
  final String nickname = "";
  final String emailAddress = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:/* DecoratedBox(
        decoration: BoxDecoration(
        image: DecorationImage(
        // image:NetworkImage("https://flutter-examples.com/wp-content/uploads/2020/02/dice.jpg"),
        image: AssetImage("assets/images/DET390_symbol.jpeg"),

    ),
    ),
    child: */SingleChildScrollView(
          padding: EdgeInsets.all(25.0),
          child: Form(
            // ignore: deprecated_member_use
            autovalidate: true,
            //child: SizedBox(height: 100.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  /// Tried to add an image, but wont load -CT
                  /*Center(
                    child: Image(
                      image: AssetImage('assets/logo.png'),
                    ),
                  ),*/
                  Padding(
                    padding: const EdgeInsets.only(top: 100.0, bottom: 1.0),
                    child: Text(
                      'M-Connect',
                      style: TextStyle(
                        fontSize: 40.0,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(),
                    child: Image.asset(
                      'assets/images/DET390_symbol.jpeg',
                      fit: BoxFit.fill,
                      height: 100, // set your height
                      width: 100,
                       // and width here
                    ),
                  ),
                  SizedBox(height: 7),
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
                        ]),
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
                        ]),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                  ),
                  Container(
                    child: ElevatedButton(
                      child: Text('Sign In',
                          style: TextStyle(
                            fontSize: 15.0,
                          )),
                      onPressed: () async {
                        try {
                          /* context.read<Auth>().signIn(
                                        email: email.text.trim(),
                                        password: password.text.trim());*/

                          /* UserCredential user = await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: email.text, password: password.text);

                          var currentUser =
                              await FirebaseAuth.instance.currentUser;
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();

                          var uid = currentUser.uid;

                          var data = await FirebaseFirestore.instance
                              .collection('users')
                              .doc(email.text)
                              .get()
                              .then((docSnapshot) {
                            return docSnapshot.data();
                          });

                          await prefs.setString(
                              'firstName', data['firstName'].toString());
                          await prefs.setString(
                              'lastName', data['lastName'].toString());
                          await prefs.setString(
                              'nickname', data['nickName'].toString());
                          await prefs.setString('email', currentUser.email);
                          await prefs.setString(
                              'isCadre', data['isCadre'].toString());

                          if (user.user.emailVerified) {
                            Navigator.pushNamed(context, '/homePage');
                          } else {
                            _verifyEmailAlertDialog(context);
                          }

                          // Navigator.pushNamed(context, '/homePage');*/

                          UserCredential user = await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: email.text, password: password.text);

                          var currentUser =
                              await FirebaseAuth.instance.currentUser;
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();

                          var uid = currentUser.uid;

                          var data = await FirebaseFirestore.instance
                              .collection('users')
                              .doc(uid)
                              .get()
                              .then((docSnapshot) {
                            return docSnapshot.data();
                          });

                          await prefs.setString(
                              'firstName', data['firstName'].toString());
                          await prefs.setString(
                              'lastName', data['lastName'].toString());
                          await prefs.setString(
                              'nickname', data['nickName'].toString());
                          await prefs.setString('email', currentUser.email);
                          await prefs.setString(
                              'isCadre', data['isCadre'].toString());

                          if (user.user.emailVerified) {
                            Navigator.pushNamed(context, '/homePage');
                          } else {
                            _verifyEmailAlertDialog(context);
                          }

                          //Navigator.pushNamed(context, '/homePage');

                        } catch (e) {
                          alertDialog(context);
                        }
                      },
                    ),
                  ),
                ),

                //added forgot password button - MRU
                SizedBox(height: 1.0),
                Container(
                    child: Column(
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
                        TextButton(
                          child: Text(
                            "New user? Sign up",
                            style: TextStyle(
                              color: Colors.blueAccent,
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/ConfirmToRegister');
                        },
                      ),
                    ],
                  ))
                ]),
          ),
        ),
    );
  }
}

String mailingEmail = "testplaceholder";
getEmail(String value) {
  mailingEmail = value;
}

String sendPinAndEmail() {
  List<String> pinAndEmail = [mailingEmail, pin];
  return pinAndEmail.toString();
}

sendMail() async {
  String username = 'rotc.application@gmail.com';
  String password = 'Rotc123!';
  //String pin = SentForgetPasswordEmail().getPinTwo();
//  String _email = SentForgetPasswordEmail().getEmail();

  final smtpServer = gmail(username, password);
  // Use the SmtpServer class to configure an SMTP server:
  // final smtpServer = SmtpServer('smtp.domain.com');
  // See the named arguments of SmtpServer for further configuration
  // options.

  // Create our message.
  final message = Message()
    ..from = Address(username, 'DET 390 Mobile')
    ..recipients.add('$mailingEmail')
    ..subject = 'Reset Password pin number is attached'
    ..text = 'This is the plain text.\nThis is line 2 of the text part.'
    ..html = "<h1>DET 390 M-Connect</h1>\n"
        "<p>Hey!<br>"
        " your reset password link is $pin</p>";

  try {
    final sendReport = await send(message, smtpServer);
    print('Message sent: ' + sendReport.toString());
  } on MailerException catch (e) {
    print('Message not sent.');
    for (var p in e.problems) {
      print('Problem: ${p.code}: ${p.msg}');
    }
  }
  // DONE
}

alertDialog(BuildContext context) {
  Widget button = FlatButton(
    child: Text("OK"),
    onPressed: () {
      // Navigator.pushNamed(context, '/signIn');
      Navigator.of(context).pop();
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
