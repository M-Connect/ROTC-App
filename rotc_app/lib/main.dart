import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rotc_app/welcomePage.dart';
import 'app/cadreView/cadreHome.dart';
import 'app/passwords/ForgotPassword.dart';
import 'app/registration_page/registrationPage.dart';
import 'app/sign_in/signInPage.dart';
import 'welcomePage.dart';

/*
  Author: Kyle Serruys
  created main and MConnect class.
  Co-Author: Christine Thomas
  created routes and added more Theme colors.
 */

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        '/cadreHome':(context) => CadreHome(),
         '/forgotPassword': (context) => ForgotPassword(),
      },
    );
  }
}


