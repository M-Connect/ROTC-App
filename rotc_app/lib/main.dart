import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rotc_app/app/peerReview/activityToBeEvaluated.dart';

import 'package:rotc_app/app/peerReview/lllab2FT/debrief.dart';
import 'package:rotc_app/app/peerReview/lllab2FT/execution.dart';
import 'package:rotc_app/app/peerReview/lllab2FT/individualEvalConfirmationPage.dart';
import 'package:rotc_app/app/peerReview/lllab2FT/multipleEvalConfirmationPage.dart';
import 'package:rotc_app/app/peerReview/lllab2FT/usersToDoEvaluation.dart';
import 'package:rotc_app/app/peerReview/peerReviewRequest.dart';
import 'package:rotc_app/app/peerReview/peerReviewStats.dart';
import 'package:rotc_app/app/profile/editProfile.dart';
import 'package:rotc_app/services/auth.dart';
import 'Views/passwords/ForgotPassword.dart';
import 'Views/registrationPage.dart';
import 'Views/signInPage.dart';
import 'Views/welcomePage.dart';
import 'app/Schedule/CalendarTasks.dart';
import 'app/home.dart';
import 'app/peerReview/graphs/barGraphs.dart';
import 'app/peerReview/graphs/lineGraphs.dart';
import 'app/peerReview/lllab2FT/communication.dart';
import 'app/peerReview/lllab2FT/confirmation.dart';
import 'app/peerReview/lllab2FT/leadership.dart';
import 'app/peerReview/lllab2FT/peerReviewLLAB2FT.dart';
import 'app/peerReview/lllab2FT/planning.dart';
import 'app/peerReview/lllab2FT/execution.dart';
import 'app/peerReview/lllab2FT/debrief.dart';
import 'app/peerReview/notifications.dart';
import 'app/peerReview/peerReview.dart';
import 'app/peerReview/commissioning/peerReviewCommissioning.dart';
import 'app/peerReview/flxflight/peerReviewFLXFlight.dart';
import 'app/peerReview/peerReviewLanding.dart';
import 'app/profile/profile.dart';
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
    return MultiProvider(
      providers: [
        Provider<Auth>(
          create: (_) => Auth(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) => context.read<Auth>().authState, initialData: null,
        )
      ],
      child: MaterialApp(
        title: 'Firebase Authentication',
        navigatorKey: navigation,
        home: Authenticate(),
    initialRoute: '/',
    routes: {
      '/welcomePage': (context) => WelcomeView(),
      '/signIn': (context) => SignInView(),
      '/register': (context) => RegistrationView(),
      '/homePage': (context) => HomeView(),
      '/forgotPassword': (context) => ForgotPasswordView(),
      '/profile': (context) => Profile(),
      '/editProfile': (context) => EditProfile(),
      '/calendar': (context) => CalendarTasks(),
      '/activityToBeEvaluated': (context) => ActivityToBeEvaluated(),
      '/peerReviewLanding': (context) => PeerReviewForm(),

      '/peerReview': (context) => PeerReview(),
      '/peerReviewRequest': (context) => PeerReviewRequest(),
      '/peerReviewStats': (context) => PeerReviewStats(),
      '/peerReviewLLAB2FT': (context) => PeerReviewLLAB2FT(),
      '/peerReviewFLXFlight': (context) => PeerReviewFLXFlight(),

      '/peerReviewCommissioning': (context) => PeerReviewCommissioning(),

      '/planning': (context) => Planning(),
      '/communication': (context) => Communication(),
      '/execution': (context) => Execution(),
      '/leadership': (context) => Leadership(),
      '/debrief': (context) => Debrief(),

      '/confirmation': (context) => Confirmation(),
      '/individualEvalConfirmationPage': (context) => IndividualEvalConfirmationPage(),
      '/multipleEvalConfirmationPage':(context) => MultipleEvalConfirmationPage(),
      '/usersToDoEvaluation':(context) => UsersToDoEvaluation(),
      '/notifications':(context) => Notifications(),
    //  '/barGraph': (context) => BarGraph(),
    //  '/lineGraph': (context) => LineGraph(),

    } ),
    );
  }
}

class Authenticate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    if (firebaseUser != null) {
      return HomeView();
    }
    return WelcomeView();
  }
}

