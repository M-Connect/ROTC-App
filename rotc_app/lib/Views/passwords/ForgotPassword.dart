import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:rotc_app/Views/passwords/resetfunction.dart';
import 'package:shared_preferences/shared_preferences.dart';
/*
* Author: Mac-Rufus Umeokolo
* This page request the user to enter the email that would be used to reset the
* password.
* afterwords, an email will be sent to them to assisting them resetting
* the password.
* */

//this method gets the random password to use for the password reset.
getPin() {
  String pin = getRandomTempPassword();
  return pin;
}

String pin = getPin();

class ForgotPasswordView extends StatefulWidget {
  final String message = "An email has been sent to you,\n"
      "Click the link provided to complete password reset\n"
      "if not found, check if you entered the right email.";

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPasswordView> {
  final _formKey = GlobalKey<FormState>();


  TextEditingController _email = TextEditingController();



  var userList = <String>[];
  var usersToEvaluate = <String>[];
  var usersToDoEvaluation = <String>[];
  var selectUsersList = <String>[];
  var filteredUserList = <String>[];
  var tempList = <String>[];
  var usersSelected = new Map<String, bool>();
  var emailCheck;

  TextEditingController userSearch = TextEditingController();

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  getUserInfo() async {
   /* SharedPreferences prefs =*/ await SharedPreferences.getInstance();
   /*var data = */await FirebaseFirestore.instance
        .collection('users')
        .orderBy("email")
        .get()
        .then((docSnapshot) {
      docSnapshot.docs.forEach((element) {
        userList.add(element.data()['email'].toString());
      });
    });
    setState(() {
      for (int i = 0; i < userList.length; i++) {
        if (!usersSelected.containsKey(userList[i].toString())) {
          usersSelected[userList[i].toString()] = false;
        }
      }
      searchList("");
    });
  }

  CollectionReference resetpassword =
  FirebaseFirestore.instance.collection('resetpassword');
  Future<void> resetRegistration() {
    return resetpassword.add({
      'email': _email.text,
      'resetPin': pin,
    });
  }

  searchList(String value) {
    var filter = userSearch.value.text;
    setState(() {
      if (filter == "" || filter == null) {
        filteredUserList = userList;
      } else {
        filteredUserList = userList
            .where((element) =>
            element.toLowerCase().contains(filter.toLowerCase()))
            .toList();
      }
    });
  }

  _resetAlert() async {
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
                  child: Text("No"),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                  }),
              TextButton(
                onPressed: () {
                  resetRegistration();
                  sendMail();
                  Navigator.of(context).pop();
                  _passwordReset();
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


  _passwordReset() async {
    if(_formKey.currentState.validate()) {
      _formKey.currentState.save();
    }

    try {
      _formKey.currentState.save();
      //await _auth.sendPasswordResetEmail(email: _email);


      Navigator.of(context).pop();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {

          return AlertDialog(
            title: Text("Password Reset"),
            content: Text("An email will be sent to you within 15 minutes,\n"
                "Use the Pin to continue on the next page"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.popAndPushNamed(context, '/ProcessPin');
                  //Navigator.of(context).pop();
                },
                child: Text("close"),
              ),
            ],
          );
        }),
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.white,

      body: Form(
        autovalidateMode: AutovalidateMode.always,
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 3.0, bottom: 6.0),
                    child: Text(
                      'Enter email to reset password *',
                    ),

                  ),
                  TextFormField(
                    controller: _email,
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
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue, // background
                  onPrimary: Colors.white, // foreground
                ),
                child: Text('Send Email'),
                onPressed: () async {
                  try {
                    if(_email.text != null) {
                      getEmail(_email.text);
                      _resetAlert();
                    }
                    final snackBar = SnackBar(content: Text("Email can't be empty!"));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    return 0;
                  } catch (e) {
                    invalidAlertDialog(context);
                  }
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white, // background
                  onPrimary: Colors.blue, // foreground
                ),
                child: Text('Sign In'),
                onPressed: () {
                  Navigator.pop(context, '/signIn');
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

/*
* Once the user inputs there email, this link send the user a random pin so
* they can us it to verify there email. before given the chance to reset the
* password.
* */
String mailingEmail = "testplaceholder";
getEmail(String value) {
  mailingEmail = value;
}
String sendPinAndEmail(){
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
print("$pin");
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

invalidAlertDialog(BuildContext context) {
  Widget button = ElevatedButton(
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