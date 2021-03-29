import 'package:animated_button/animated_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:rotc_app/Views/passwords/resetfunction.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



getPin() {
  String pin = getRandomTempPassword();
  return pin;
}
String pin = getPin();
String _email;

class SentForgetPasswordEmail extends StatefulWidget {
  @override
  _SentForgetPasswordEmailState createState() => _SentForgetPasswordEmailState();
}

class _SentForgetPasswordEmailState extends State<SentForgetPasswordEmail> {


  CollectionReference resetpassword =
      FirebaseFirestore.instance.collection('resetpassword');





  Future<void> resetPinRegistration() {
    return resetpassword.add({
      'email': _email,
      'resetPin': pin,
    });
  }

  Future<void> ResetEmail(String email) {
    setEmail(email);
    SentForgetPasswordEmail();
  }

  Future<void> setEmail(String email) {
    _email = email;
  }
  getEmail() {
    return _email;
  }

  startMailing(){
    SentForgetPasswordEmail();
  }

  _passwordReset() async {

    try {
      //await _auth.sendPasswordResetEmail(email: _email);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return AlertDialog(
            title: Text("Password Reset"),
            content: Text("Click yes to continue."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Yes"),
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
    return Container(
      child:  _passwordReset(),
    );
  }
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
    ..recipients.add('maccreed313@gmail.com')
    ..subject = 'Reset Password pin number ${DateTime.now()}'
    ..text = 'This is the plain text.\nThis is line 2 of the text part.'
    ..html = "<h1>Test</h1>\n<p>Hey! Here's some HTML content $pin</p>";

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