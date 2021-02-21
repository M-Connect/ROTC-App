import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rotc_app/app/peerReview/lllab2FT/debrief.dart';
import 'package:rotc_app/app/peerReview/lllab2FT/execution.dart';
import 'package:rotc_app/app/peerReview/peerReviewRequest.dart';
import 'package:rotc_app/app/peerReview/peerReviewStats.dart';
import 'Views/passwords/ForgotPassword.dart';
import 'Views/registrationPage.dart';
import 'Views/signInPage.dart';
import 'Views/welcomePage.dart';
import 'app/home.dart';
import 'app/peerReview/lllab2FT/communication.dart';
import 'app/peerReview/lllab2FT/leadership.dart';
import 'app/peerReview/lllab2FT/peerReviewLLAB2FT.dart';
import 'app/peerReview/lllab2FT/planning.dart';
import 'app/peerReview/lllab2FT/execution.dart';
import 'app/peerReview/lllab2FT/debrief.dart';
import 'app/peerReview/peerReview.dart';
import 'app/peerReview/peerReviewCommissioning.dart';
import 'app/peerReview/peerReviewFLXFlight.dart';
import 'app/peerReview/peerReviewLanding.dart';
/*
  Author: Kyle Serruys
  created main and MConnect class.
  Co-Author: Christine Thomas
  created routes and added more Theme colors.
 */

final GlobalKey<NavigatorState> navigation = new GlobalKey<NavigatorState>();
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
      navigatorKey: navigation,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColorLight: Colors.cyan[300],
        primaryColor: Colors.blue[900],
        accentColor: Colors.amber[200],
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomeView(),
        '/signIn': (context) => SignInView(),
        '/register': (context) => RegistrationView(),
        '/home':(context) => HomeView(),
        '/forgotPassword': (context) => ForgotPasswordView(),
        '/peerReviewLanding': (context) => PeerReviewLanding(),
        '/peerReview': (context) => PeerReview(),
        '/peerReviewRequest': (context) => PeerReviewRequest(),
        '/peerReviewStats': (context) => PeerReviewStats(),
        '/peerReviewLLAB2FT': (context)=> PeerReviewLLAB2FT(),
        '/peerReviewFLXFlight': (context) => PeerReviewFLXFlight(),
        '/peerReviewCommissioning': (context) => PeerReviewCommissioning(),
        '/planning':(context) => Planning(),
        '/communication':(context) => Communication(),
        '/execution': (context) => Execution(),
        '/leadership': (context) => Leadership(),
        '/debrief': (context) => Debrief(),
      },
    );
  }
}


