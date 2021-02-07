import 'package:flutter/material.dart';
import 'app/registration_page/registrationPage.dart';
import 'app/sign_in/signInPage.dart';
import 'welcomePage.dart';

// Author: Kyle Serruys
// created main and MConnect class
// Co-Author: Christine Thomas created routes and
// added primaryColor and accentColor.
void main() {
  runApp(MConnect());
}

class MConnect extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'M-Connect',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColorLight: Colors.cyan[300],
        primaryColor: Colors.blue[900],
        accentColor: Colors.amber[200],
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomePage(),
        '/signIn': (context) => SignInPage(),
        '/register': (context) => RegistrationPage(),
      },
    );
  }
}


